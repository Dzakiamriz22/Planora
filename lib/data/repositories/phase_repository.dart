import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class PhaseValidationException implements Exception {
  PhaseValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class PhaseWithAllocations {
  const PhaseWithAllocations({
    required this.phase,
    required this.allocations,
  });

  final Phase phase;
  final Map<String, int> allocations;

  int get totalMonthly =>
      allocations.values.fold<int>(0, (sum, value) => sum + value);
}

class PhaseRepository {
  PhaseRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> _ownerId() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    return profile.id;
  }

  Stream<List<Phase>> watchPhases() {
    return (_db.select(_db.phases)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<PhaseAllocation>> watchAllAllocations() {
    return _db.select(_db.phaseAllocations).watch();
  }

  Future<void> applyPhase(String phaseId) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final s = await _db.select(_db.settings).getSingle();
      final ceiling = PlanoraCalc.ceiling(
        monthlySalary: s.monthlySalary,
        minimumLivingCost: s.minimumLivingCost,
      );

      final allocRows = await (_db.select(_db.phaseAllocations)
            ..where((t) => t.phaseId.equals(phaseId)))
          .get();
      final allocMap = {
        for (final row in allocRows) row.portfolioId: row.monthlyAmount,
      };
      final portfolios = await _db.select(_db.portfolios).get();
      var total = 0;
      for (final p in portfolios) {
        total += allocMap[p.id] ?? 0;
      }
      if (ceiling != null && total > ceiling) {
        throw PhaseValidationException(
          'Total fase (${AppFormatters.rupiah(total)}) melebihi batas nabung saat ini (${AppFormatters.rupiah(ceiling)}).',
        );
      }

      await _db.update(_db.phases).write(
            const PhasesCompanion(isActive: Value(false)),
          );
      await (_db.update(_db.phases)..where((t) => t.id.equals(phaseId))).write(
        PhasesCompanion(
          isActive: const Value(true),
          updatedAt: Value(nowIso),
        ),
      );

      for (final p in portfolios) {
        final nextPlan = allocMap[p.id] ?? 0;
        await (_db.update(_db.portfolios)..where((t) => t.id.equals(p.id)))
            .write(
          PortfoliosCompanion(
            monthlyPlan: Value(nextPlan),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  Future<String> savePhase({
    String? id,
    required String name,
    String? description,
    required Map<String, int> allocationsByPortfolioId,
  }) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final targetId = id ?? _uuid.v4();

    await _db.transaction(() async {
      final ownerId = await _ownerId();
      final s = await _db.select(_db.settings).getSingle();
      final ceiling = PlanoraCalc.ceiling(
        monthlySalary: s.monthlySalary,
        minimumLivingCost: s.minimumLivingCost,
      );
      final portfolios = await _db.select(_db.portfolios).get();

      final validationInputs = portfolios
          .map(
            (p) => PhaseAllocationInput(
              portfolioId: p.id,
              portfolioName: p.name,
              monthlyAmount: allocationsByPortfolioId[p.id] ?? 0,
            ),
          )
          .toList();

      final validation = PlanoraCalc.validatePhaseAllocations(
        allocations: validationInputs,
        ceilingAmount: ceiling,
        phaseLimitEnabled: s.phaseLimitEnabled,
        phaseLimitAmount: s.phaseLimitAmount,
      );
      if (!validation.isValid) {
        throw PhaseValidationException(
          validation.errorMessage ?? 'Alokasi fase tidak valid.',
        );
      }

      if (id == null) {
        final existingPhases = await _db.select(_db.phases).get();
        final nextOrder = existingPhases.isEmpty
            ? 0
            : existingPhases
                    .map((e) => e.sortOrder)
                    .reduce((a, b) => a > b ? a : b) +
                1;

        await _db.into(_db.phases).insert(
              PhasesCompanion.insert(
                id: targetId,
                ownerId: ownerId,
                name: name.trim(),
                description: Value(
                  description?.trim().isEmpty ?? true
                      ? null
                      : description!.trim(),
                ),
                isActive: const Value(false),
                sortOrder: Value(nextOrder),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      } else {
        await (_db.update(_db.phases)..where((t) => t.id.equals(id))).write(
          PhasesCompanion(
            name: Value(name.trim()),
            description: Value(
              description?.trim().isEmpty ?? true ? null : description!.trim(),
            ),
            updatedAt: Value(nowIso),
          ),
        );
      }

      await (_db.delete(_db.phaseAllocations)
            ..where((t) => t.phaseId.equals(targetId)))
          .go();

      for (final p in portfolios) {
        await _db.into(_db.phaseAllocations).insert(
              PhaseAllocationsCompanion.insert(
                id: _uuid.v4(),
                phaseId: targetId,
                portfolioId: p.id,
                ownerId: ownerId,
                monthlyAmount: Value(allocationsByPortfolioId[p.id] ?? 0),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      }
    });

    return targetId;
  }

  Future<String> createBalancedPhase({String name = 'Fase Seimbang'}) async {
    final s = await _db.select(_db.settings).getSingle();
    final ceiling = PlanoraCalc.ceiling(
      monthlySalary: s.monthlySalary,
      minimumLivingCost: s.minimumLivingCost,
    );
    if (ceiling == null || ceiling <= 0) {
      throw PhaseValidationException(
        'Atur gaji dan biaya hidup minimum terlebih dahulu untuk membuat fase seimbang.',
      );
    }

    final portfolios = await (_db.select(_db.portfolios)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
    if (portfolios.isEmpty) {
      throw PhaseValidationException(
        'Buat minimal satu porto terlebih dahulu sebelum membuat fase seimbang.',
      );
    }

    final allocs = PlanoraCalc.balancedPhaseAllocations(
      portfolioIds: portfolios.map((p) => p.id).toList(),
      ceilingAmount: ceiling,
      phaseLimitEnabled: s.phaseLimitEnabled,
      phaseLimitAmount: s.phaseLimitAmount,
    );

    return savePhase(
      name: name,
      description: 'Pembagian batas nabung merata ke seluruh porto sebagai titik mulai.',
      allocationsByPortfolioId: allocs,
    );
  }

  Future<String> duplicatePhase(String sourcePhaseId) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final newId = _uuid.v4();

    await _db.transaction(() async {
      final ownerId = await _ownerId();
      final source = await (_db.select(_db.phases)
            ..where((t) => t.id.equals(sourcePhaseId)))
          .getSingleOrNull();
      if (source == null) {
        throw PhaseValidationException('Fase sumber tidak ditemukan.');
      }

      final existingPhases = await _db.select(_db.phases).get();
      final nextOrder = existingPhases.isEmpty
          ? 0
          : existingPhases
                  .map((e) => e.sortOrder)
                  .reduce((a, b) => a > b ? a : b) +
              1;

      await _db.into(_db.phases).insert(
            PhasesCompanion.insert(
              id: newId,
              ownerId: ownerId,
              name: '${source.name} (salinan)',
              description: Value(source.description),
              isActive: const Value(false),
              sortOrder: Value(nextOrder),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      final sourceAllocs = await (_db.select(_db.phaseAllocations)
            ..where((t) => t.phaseId.equals(sourcePhaseId)))
          .get();
      final allocMap = {
        for (final a in sourceAllocs) a.portfolioId: a.monthlyAmount,
      };

      final portfolios = await _db.select(_db.portfolios).get();
      for (final p in portfolios) {
        await _db.into(_db.phaseAllocations).insert(
              PhaseAllocationsCompanion.insert(
                id: _uuid.v4(),
                phaseId: newId,
                portfolioId: p.id,
                ownerId: ownerId,
                monthlyAmount: Value(allocMap[p.id] ?? 0),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      }
    });

    return newId;
  }

  Future<void> reorderPhases(List<String> orderedPhaseIds) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      for (var i = 0; i < orderedPhaseIds.length; i++) {
        await (_db.update(_db.phases)
              ..where((t) => t.id.equals(orderedPhaseIds[i])))
            .write(
          PhasesCompanion(
            sortOrder: Value(i),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  Future<void> deletePhase(String phaseId) async {
    await _db.transaction(() async {
      final phase = await (_db.select(_db.phases)
            ..where((t) => t.id.equals(phaseId)))
          .getSingleOrNull();
      if (phase == null) return;
      if (phase.isActive) {
        throw PhaseValidationException(
          'Fase yang sedang aktif tidak boleh dihapus. Aktifkan fase lain terlebih dahulu.',
        );
      }
      await (_db.delete(_db.phases)..where((t) => t.id.equals(phaseId))).go();
    });
  }
}

final phaseRepositoryProvider = Provider<PhaseRepository>((ref) {
  return PhaseRepository(ref.watch(appDatabaseProvider));
});

