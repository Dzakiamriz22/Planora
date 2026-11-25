import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class CeilingExceededException implements Exception {
  CeilingExceededException(this.message);
  final String message;

  @override
  String toString() => message;
}

class ComponentLimitException implements Exception {
  ComponentLimitException(this.message);
  final String message;

  @override
  String toString() => message;
}

class PortfolioRepository {
  PortfolioRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> _ownerId() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    return profile.id;
  }

  Future<int?> _currentCeiling() async {
    final s = await _db.select(_db.settings).getSingle();
    return PlanoraCalc.ceiling(
      monthlySalary: s.monthlySalary,
      minimumLivingCost: s.minimumLivingCost,
    );
  }

  Stream<List<Portfolio>> watchAllPortfolios() {
    return (_db.select(_db.portfolios)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Future<List<Portfolio>> getAllPortfolios() {
    return (_db.select(_db.portfolios)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
  }

  Stream<List<Contribution>> watchAllContributions() {
    return (_db.select(_db.contributions)
          ..orderBy([
            (t) => OrderingTerm.desc(t.date),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<Contribution>> watchContributionsForPortfolio(
    String portfolioId,
  ) {
    return (_db.select(_db.contributions)
          ..where((t) => t.portfolioId.equals(portfolioId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.date),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<PortfolioComponent>> watchAllComponents() {
    return (_db.select(_db.portfolioComponents)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<PortfolioComponent>> watchComponentsForPortfolio(
    String portfolioId,
  ) {
    return (_db.select(_db.portfolioComponents)
          ..where((t) => t.portfolioId.equals(portfolioId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Future<({int contributions, int components})> countPortfolioChildren(
    String portfolioId,
  ) async {
    final contribs = await (_db.select(_db.contributions)
          ..where((t) => t.portfolioId.equals(portfolioId)))
        .get();
    final comps = await (_db.select(_db.portfolioComponents)
          ..where((t) => t.portfolioId.equals(portfolioId)))
        .get();
    return (contributions: contribs.length, components: comps.length);
  }

  Future<int> _balanceForPortfolio(String portfolioId) async {
    final rows = await (_db.select(_db.contributions)
          ..where((t) => t.portfolioId.equals(portfolioId)))
        .get();
    return rows.fold<int>(0, (sum, r) => sum + r.amount);
  }

  Future<int> _totalComponentsForPortfolio(
    String portfolioId, {
    String? excludeComponentId,
  }) async {
    final rows = await (_db.select(_db.portfolioComponents)
          ..where((t) => t.portfolioId.equals(portfolioId)))
        .get();
    return rows
        .where((r) => r.id != excludeComponentId)
        .fold<int>(0, (sum, r) => sum + r.amount);
  }

  Future<String> createPortfolio({
    required String name,
    required String category,
    String? platformPreset,
    String? platformName,
    int? fullPrice,
    int? downPayment,
    int? fees,
    int? savedTarget,
    String? targetDate,
    required int monthlyPlan,
    required double annualReturnPct,
    String calcMode = 'deposit_driven',
    required String icon,
    required int color,
    String? note,
    Map<String, int>? rebalancedPlans,
  }) async {
    final id = _uuid.v4();
    final nowIso = DateTime.now().toUtc().toIso8601String();

    await _db.transaction(() async {
      final ownerId = await _ownerId();
      final ceiling = await _currentCeiling();
      final existing = await getAllPortfolios();

      var projectedTotal = monthlyPlan;
      for (final p in existing) {
        projectedTotal += rebalancedPlans?[p.id] ?? p.monthlyPlan;
      }
      if (ceiling != null && projectedTotal > ceiling) {
        throw CeilingExceededException(
          'Total rencana setoran (${AppFormatters.rupiah(projectedTotal)}) melebihi plafon menabung (${AppFormatters.rupiah(ceiling)}).',
        );
      }

      if (rebalancedPlans != null) {
        for (final entry in rebalancedPlans.entries) {
          if (entry.value < 0) {
            throw CeilingExceededException('Rencana setoran tidak boleh negatif.');
          }
          await (_db.update(_db.portfolios)
                ..where((t) => t.id.equals(entry.key)))
              .write(
            PortfoliosCompanion(
              monthlyPlan: Value(entry.value),
              updatedAt: Value(nowIso),
            ),
          );
        }
      }

      final nextSortOrder = existing.isEmpty
          ? 0
          : existing
                  .map((e) => e.sortOrder)
                  .reduce((a, b) => a > b ? a : b) +
              1;

      await _db.into(_db.portfolios).insert(
            PortfoliosCompanion.insert(
              id: id,
              ownerId: ownerId,
              name: name.trim(),
              category: category,
              platformPreset: Value(platformPreset),
              platformName: Value(
                platformName?.trim().isEmpty ?? true
                    ? null
                    : platformName!.trim(),
              ),
              fullPrice: Value(fullPrice),
              downPayment: Value(downPayment),
              fees: Value(fees),
              savedTarget: Value(savedTarget),
              targetDate: Value(targetDate),
              monthlyPlan: Value(monthlyPlan),
              annualReturnPct: Value(annualReturnPct),
              calcMode: Value(calcMode),
              icon: Value(icon),
              color: Value(color),
              note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
              sortOrder: Value(nextSortOrder),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      // FR-24: Porto baru otomatis menjadi alokasi Rp 0 di semua fase
      final phases = await _db.select(_db.phases).get();
      for (final phase in phases) {
        await _db.into(_db.phaseAllocations).insert(
              PhaseAllocationsCompanion.insert(
                id: _uuid.v4(),
                phaseId: phase.id,
                portfolioId: id,
                ownerId: ownerId,
                monthlyAmount: const Value(0),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    });

    return id;
  }

  Future<void> updatePortfolio({
    required String id,
    required PortfoliosCompanion changes,
    Map<String, int>? rebalancedPlans,
  }) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();

    await _db.transaction(() async {
      final ceiling = await _currentCeiling();
      final existing = await getAllPortfolios();

      var projectedTotal = 0;
      for (final p in existing) {
        if (p.id == id) {
          final nextPlan = changes.monthlyPlan.present
              ? changes.monthlyPlan.value
              : p.monthlyPlan;
          if (nextPlan < 0) {
            throw CeilingExceededException('Rencana setoran tidak boleh negatif.');
          }
          projectedTotal += nextPlan;
        } else {
          final nextPlan = rebalancedPlans?[p.id] ?? p.monthlyPlan;
          if (nextPlan < 0) {
            throw CeilingExceededException('Rencana setoran tidak boleh negatif.');
          }
          projectedTotal += nextPlan;
        }
      }

      if (ceiling != null && projectedTotal > ceiling) {
        throw CeilingExceededException(
          'Total rencana setoran (${AppFormatters.rupiah(projectedTotal)}) melebihi plafon menabung (${AppFormatters.rupiah(ceiling)}).',
        );
      }

      if (rebalancedPlans != null) {
        for (final entry in rebalancedPlans.entries) {
          if (entry.key == id) continue;
          await (_db.update(_db.portfolios)
                ..where((t) => t.id.equals(entry.key)))
              .write(
            PortfoliosCompanion(
              monthlyPlan: Value(entry.value),
              updatedAt: Value(nowIso),
            ),
          );
        }
      }

      await (_db.update(_db.portfolios)..where((t) => t.id.equals(id))).write(
        changes.copyWith(updatedAt: Value(nowIso)),
      );
    });
  }

  Future<void> applyMonthlyPlans(Map<String, int> plansById) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final ceiling = await _currentCeiling();
      final existing = await getAllPortfolios();
      var total = 0;
      for (final p in existing) {
        final next = plansById[p.id] ?? p.monthlyPlan;
        if (next < 0) {
          throw CeilingExceededException('Rencana setoran tidak boleh negatif.');
        }
        total += next;
      }
      if (ceiling != null && total > ceiling) {
        throw CeilingExceededException(
          'Total rencana setoran (${AppFormatters.rupiah(total)}) melebihi plafon menabung (${AppFormatters.rupiah(ceiling)}).',
        );
      }
      for (final entry in plansById.entries) {
        await (_db.update(_db.portfolios)..where((t) => t.id.equals(entry.key)))
            .write(
          PortfoliosCompanion(
            monthlyPlan: Value(entry.value),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  Future<void> deletePortfolio(String id) async {
    await (_db.delete(_db.portfolios)..where((t) => t.id.equals(id))).go();
  }

  Future<void> reorderPortfolios(List<String> orderedIds) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.portfolios)
              ..where((t) => t.id.equals(orderedIds[i])))
            .write(
          PortfoliosCompanion(
            sortOrder: Value(i),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });
  }

  // ===== KOMPONEN INSTRUMEN (FR-09, FR-10, BR-02) =====

  Future<String> upsertComponent({
    String? id,
    required String portfolioId,
    required String instrumentType,
    String? name,
    required int amount,
    String? codeNote,
  }) async {
    if (amount <= 0) {
      throw ComponentLimitException('Nominal komponen harus lebih dari Rp 0.');
    }

    final nowIso = DateTime.now().toUtc().toIso8601String();
    final targetId = id ?? _uuid.v4();

    await _db.transaction(() async {
      final ownerId = await _ownerId();
      final balance = await _balanceForPortfolio(portfolioId);
      final otherComponents = await _totalComponentsForPortfolio(
        portfolioId,
        excludeComponentId: id,
      );
      final nextTotal = otherComponents + amount;

      if (nextTotal > balance) {
        throw ComponentLimitException(
          'Total komponen (${AppFormatters.rupiah(nextTotal)}) melebihi saldo porto (${AppFormatters.rupiah(balance)}).',
        );
      }

      if (id == null) {
        final existing = await (_db.select(_db.portfolioComponents)
              ..where((t) => t.portfolioId.equals(portfolioId)))
            .get();
        final nextOrder = existing.isEmpty
            ? 0
            : existing
                    .map((e) => e.sortOrder)
                    .reduce((a, b) => a > b ? a : b) +
                1;

        await _db.into(_db.portfolioComponents).insert(
              PortfolioComponentsCompanion.insert(
                id: targetId,
                portfolioId: portfolioId,
                ownerId: ownerId,
                instrumentType: instrumentType.trim(),
                name: Value(name?.trim().isEmpty ?? true ? null : name!.trim()),
                amount: amount,
                codeNote: Value(
                  codeNote?.trim().isEmpty ?? true ? null : codeNote!.trim(),
                ),
                sortOrder: Value(nextOrder),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      } else {
        await (_db.update(_db.portfolioComponents)
              ..where((t) => t.id.equals(id)))
            .write(
          PortfolioComponentsCompanion(
            instrumentType: Value(instrumentType.trim()),
            name: Value(name?.trim().isEmpty ?? true ? null : name!.trim()),
            amount: Value(amount),
            codeNote: Value(
              codeNote?.trim().isEmpty ?? true ? null : codeNote!.trim(),
            ),
            updatedAt: Value(nowIso),
          ),
        );
      }
    });

    return targetId;
  }

  Future<void> deleteComponent(String componentId) async {
    await (_db.delete(_db.portfolioComponents)
          ..where((t) => t.id.equals(componentId)))
        .go();
  }

  // ===== CATATAN SETORAN (FR-11, BR-01, BR-02) =====

  Future<String> addContribution({
    required String portfolioId,
    required int amount,
    required String dateIso,
    String? note,
  }) async {
    if (amount <= 0) {
      throw ArgumentError('Jumlah setoran harus lebih dari Rp 0.');
    }
    final id = _uuid.v4();
    final ownerId = await _ownerId();
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.into(_db.contributions).insert(
          ContributionsCompanion.insert(
            id: id,
            portfolioId: portfolioId,
            ownerId: ownerId,
            amount: amount,
            date: dateIso,
            note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
            createdAt: nowIso,
            updatedAt: nowIso,
          ),
        );
    return id;
  }

  Future<void> updateContribution({
    required String id,
    required int amount,
    required String dateIso,
    String? note,
  }) async {
    if (amount <= 0) {
      throw ArgumentError('Jumlah setoran harus lebih dari Rp 0.');
    }
    final nowIso = DateTime.now().toUtc().toIso8601String();

    await _db.transaction(() async {
      final existing = await (_db.select(_db.contributions)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      final currentBalance = await _balanceForPortfolio(existing.portfolioId);
      final nextBalance = currentBalance - existing.amount + amount;
      final totalComponents =
          await _totalComponentsForPortfolio(existing.portfolioId);

      // BR-02 / FR-11: Saldo tidak boleh turun di bawah total komponen
      if (nextBalance < totalComponents) {
        throw ComponentLimitException(
          'Saldo baru (${AppFormatters.rupiah(nextBalance)}) lebih kecil dari total komponen (${AppFormatters.rupiah(totalComponents)}). Kurangi komponen terlebih dahulu.',
        );
      }

      await (_db.update(_db.contributions)..where((t) => t.id.equals(id)))
          .write(
        ContributionsCompanion(
          amount: Value(amount),
          date: Value(dateIso),
          note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
          updatedAt: Value(nowIso),
        ),
      );
    });
  }

  Future<void> deleteContribution(String id) async {
    await _db.transaction(() async {
      final existing = await (_db.select(_db.contributions)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) return;

      final currentBalance = await _balanceForPortfolio(existing.portfolioId);
      final nextBalance = currentBalance - existing.amount;
      final totalComponents =
          await _totalComponentsForPortfolio(existing.portfolioId);

      if (nextBalance < totalComponents) {
        throw ComponentLimitException(
          'Menghapus setoran ini membuat saldo (${AppFormatters.rupiah(nextBalance)}) turun di bawah total komponen (${AppFormatters.rupiah(totalComponents)}). Kurangi komponen terlebih dahulu.',
        );
      }

      await (_db.delete(_db.contributions)..where((t) => t.id.equals(id))).go();
    });
  }
}

final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  return PortfolioRepository(ref.watch(appDatabaseProvider));
});
