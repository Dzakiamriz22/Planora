import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class PlanValidationException implements Exception {
  PlanValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class PlanWithAllocations {
  const PlanWithAllocations({
    required this.plan,
    required this.sharePercentX100ByPortfolioId,
    required this.derivedAmountsByPortfolioId,
  });

  final Plan plan;
  final Map<String, int> sharePercentX100ByPortfolioId;
  final Map<String, int> derivedAmountsByPortfolioId;

  int get totalX100 =>
      PlanPercentCalc.totalX100(sharePercentX100ByPortfolioId.values);

  bool get isExact100 => totalX100 == PlanPercentCalc.exact100X100;

  bool get isDraft => !isExact100;

  int get totalMonthly => plan.totalAmount;
}

class PlanRepository {
  PlanRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> _ownerId() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    return profile.id;
  }

  Stream<List<Plan>> watchPlans() {
    return (_db.select(_db.plans)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<PlanAllocation>> watchAllAllocations() {
    return _db.select(_db.planAllocations).watch();
  }

  Future<void> applyPlan(String planId) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final plan = await (_db.select(_db.plans)
            ..where((t) => t.id.equals(planId)))
          .getSingleOrNull();
      if (plan == null) {
        throw PlanValidationException('Plan tidak ditemukan.');
      }

      final s = await _db.select(_db.settings).getSingle();
      final ceiling = PlanoraCalc.ceiling(
        monthlySalary: s.monthlySalary,
        minimumLivingCost: s.minimumLivingCost,
      );

      final portfolios = await _db.select(_db.portfolios).get();
      final allocRows = await (_db.select(_db.planAllocations)
            ..where((t) => t.planId.equals(planId)))
          .get();

      final shareMap = <String, int>{
        for (final p in portfolios) p.id: 0,
      };
      for (final row in allocRows) {
        if (shareMap.containsKey(row.portfolioId)) {
          shareMap[row.portfolioId] = row.sharePercentX100;
        }
      }

      final namesById = {for (final p in portfolios) p.id: p.name};
      final validation = PlanPercentCalc.validateForApply(
        totalAmount: plan.totalAmount,
        sharePercentX100ById: shareMap,
        portfolioNamesById: namesById,
        ceilingAmount: ceiling,
        planLimitEnabled: s.planLimitEnabled,
        planLimitAmount: s.planLimitAmount,
      );

      if (!validation.isValid) {
        throw PlanValidationException(
          validation.errorMessage ?? 'Plan belum bisa dipakai.',
        );
      }

      await _db.update(_db.plans).write(
            const PlansCompanion(isActive: Value(false)),
          );
      await (_db.update(_db.plans)..where((t) => t.id.equals(planId))).write(
        PlansCompanion(
          isActive: const Value(true),
          updatedAt: Value(nowIso),
        ),
      );

      for (final p in portfolios) {
        final nextMonthly = validation.derivedAmountsById[p.id] ?? 0;
        await (_db.update(_db.portfolios)..where((t) => t.id.equals(p.id)))
            .write(
          PortfoliosCompanion(
            monthlyPlan: Value(nextMonthly),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  Future<void> deactivatePlan(String planId) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await (_db.update(_db.plans)..where((t) => t.id.equals(planId))).write(
      PlansCompanion(
        isActive: const Value(false),
        updatedAt: Value(nowIso),
      ),
    );
  }

  Future<String> savePlan({
    String? id,
    required String name,
    String? description,
    required int totalAmount,
    required Map<String, int> sharePercentX100ByPortfolioId,
  }) async {
    if (name.trim().isEmpty) {
      throw PlanValidationException('Nama Plan wajib diisi.');
    }
    if (totalAmount < 0) {
      throw PlanValidationException('Total Plan tidak boleh negatif.');
    }
    for (final v in sharePercentX100ByPortfolioId.values) {
      if (v < 0 || v > PlanPercentCalc.exact100X100) {
        throw PlanValidationException(
          'Persentase bagian harus antara 0% sampai 100%.',
        );
      }
    }

    final nowIso = DateTime.now().toUtc().toIso8601String();
    final targetId = id ?? _uuid.v4();

    await _db.transaction(() async {
      final ownerId = await _ownerId();
      final portfolios = await _db.select(_db.portfolios).get();

      if (id == null) {
        final existingPlans = await _db.select(_db.plans).get();
        final nextOrder = existingPlans.isEmpty
            ? 0
            : existingPlans
                    .map((e) => e.sortOrder)
                    .reduce((a, b) => a > b ? a : b) +
                1;

        await _db.into(_db.plans).insert(
              PlansCompanion.insert(
                id: targetId,
                ownerId: ownerId,
                name: name.trim(),
                description: Value(
                  description?.trim().isEmpty ?? true
                      ? null
                      : description!.trim(),
                ),
                totalAmount: Value(totalAmount),
                isActive: const Value(false),
                sortOrder: Value(nextOrder),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      } else {
        await (_db.update(_db.plans)..where((t) => t.id.equals(id))).write(
          PlansCompanion(
            name: Value(name.trim()),
            description: Value(
              description?.trim().isEmpty ?? true ? null : description!.trim(),
            ),
            totalAmount: Value(totalAmount),
            updatedAt: Value(nowIso),
          ),
        );
      }

      await (_db.delete(_db.planAllocations)
            ..where((t) => t.planId.equals(targetId)))
          .go();

      for (final p in portfolios) {
        await _db.into(_db.planAllocations).insert(
              PlanAllocationsCompanion.insert(
                id: _uuid.v4(),
                planId: targetId,
                portfolioId: p.id,
                ownerId: ownerId,
                sharePercentX100: Value(
                  sharePercentX100ByPortfolioId[p.id] ?? 0,
                ),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      }
    });

    return targetId;
  }

  Future<String> createBalancedPlan({String name = 'Plan Seimbang'}) async {
    final s = await _db.select(_db.settings).getSingle();
    final ceiling = PlanoraCalc.ceiling(
      monthlySalary: s.monthlySalary,
      minimumLivingCost: s.minimumLivingCost,
    );
    if (ceiling == null || ceiling <= 0) {
      throw PlanValidationException(
        'Atur gaji dan biaya hidup minimum dulu di Pengaturan untuk membuat Plan Seimbang.',
      );
    }

    final portfolios = await (_db.select(_db.portfolios)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
    if (portfolios.isEmpty) {
      throw PlanValidationException(
        'Buat minimal satu porto dulu sebelum membuat Plan Seimbang.',
      );
    }

    final percents = PlanPercentCalc.presetBalanced(
      portfolios.map((p) => p.id).toList(),
    );

    return savePlan(
      name: name,
      description: 'Pembagian setoran merata ke semua porto sebagai titik mulai.',
      totalAmount: ceiling,
      sharePercentX100ByPortfolioId: percents,
    );
  }

  Future<void> scaleActivePlanToCeiling(int newCeiling) async {
    if (newCeiling < 0) return;
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final active = await (_db.select(_db.plans)
            ..where((t) => t.isActive.equals(true)))
          .getSingleOrNull();
      if (active == null || active.totalAmount <= newCeiling) return;

      await (_db.update(_db.plans)..where((t) => t.id.equals(active.id))).write(
        PlansCompanion(
          totalAmount: Value(newCeiling),
          updatedAt: Value(nowIso),
        ),
      );

      final portfolios = await _db.select(_db.portfolios).get();
      final allocs = await (_db.select(_db.planAllocations)
            ..where((t) => t.planId.equals(active.id)))
          .get();
      final shareMap = {
        for (final a in allocs) a.portfolioId: a.sharePercentX100,
      };
      final derived = PlanPercentCalc.computeAmountsFromPercents(
        totalAmount: newCeiling,
        sharePercentX100ById: shareMap,
      );
      for (final p in portfolios) {
        await (_db.update(_db.portfolios)..where((t) => t.id.equals(p.id)))
            .write(
          PortfoliosCompanion(
            monthlyPlan: Value(derived[p.id] ?? 0),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  Future<String> duplicatePlan(String sourcePlanId) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final newId = _uuid.v4();

    await _db.transaction(() async {
      final ownerId = await _ownerId();
      final source = await (_db.select(_db.plans)
            ..where((t) => t.id.equals(sourcePlanId)))
          .getSingleOrNull();
      if (source == null) {
        throw PlanValidationException('Plan sumber tidak ditemukan.');
      }

      final existingPlans = await _db.select(_db.plans).get();
      final nextOrder = existingPlans.isEmpty
          ? 0
          : existingPlans
                  .map((e) => e.sortOrder)
                  .reduce((a, b) => a > b ? a : b) +
              1;

      await _db.into(_db.plans).insert(
            PlansCompanion.insert(
              id: newId,
              ownerId: ownerId,
              name: '${source.name} (salinan)',
              description: Value(source.description),
              totalAmount: Value(source.totalAmount),
              isActive: const Value(false),
              sortOrder: Value(nextOrder),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      final sourceAllocs = await (_db.select(_db.planAllocations)
            ..where((t) => t.planId.equals(sourcePlanId)))
          .get();
      final shareMap = {
        for (final a in sourceAllocs) a.portfolioId: a.sharePercentX100,
      };

      final portfolios = await _db.select(_db.portfolios).get();
      for (final p in portfolios) {
        await _db.into(_db.planAllocations).insert(
              PlanAllocationsCompanion.insert(
                id: _uuid.v4(),
                planId: newId,
                portfolioId: p.id,
                ownerId: ownerId,
                sharePercentX100: Value(shareMap[p.id] ?? 0),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      }
    });

    return newId;
  }

  Future<void> reorderPlans(List<String> orderedPlanIds) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      for (var i = 0; i < orderedPlanIds.length; i++) {
        await (_db.update(_db.plans)
              ..where((t) => t.id.equals(orderedPlanIds[i])))
            .write(
          PlansCompanion(
            sortOrder: Value(i),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  Future<void> deletePlan(String planId) async {
    await _db.transaction(() async {
      final plan = await (_db.select(_db.plans)
            ..where((t) => t.id.equals(planId)))
          .getSingleOrNull();
      if (plan == null) return;
      if (plan.isActive) {
        throw PlanValidationException(
          'Plan yang sedang aktif tidak bisa dihapus. Pakai Plan lain terlebih dahulu.',
        );
      }
      await (_db.delete(_db.plans)..where((t) => t.id.equals(planId))).go();
    });
  }
}

final planRepositoryProvider = Provider<PlanRepository>((ref) {
  return PlanRepository(ref.watch(appDatabaseProvider));
});
