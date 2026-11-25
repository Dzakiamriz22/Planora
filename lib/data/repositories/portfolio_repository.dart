import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class ComponentDraft {
  const ComponentDraft({
    this.id,
    required this.instrumentType,
    this.name,
    required this.targetPercent,
    this.actualAmount,
    this.codeNote,
  });

  final String? id;
  final String instrumentType;
  final String? name;
  final double targetPercent;
  final int? actualAmount;
  final String? codeNote;
}

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

  Future<void> _saveComponentsInTx({
    required String portfolioId,
    required String ownerId,
    required List<ComponentDraft> drafts,
    required String nowIso,
  }) async {
    if (drafts.isEmpty) {
      await (_db.delete(_db.portfolioComponents)
            ..where((t) => t.portfolioId.equals(portfolioId)))
          .go();
      return;
    }

    final seen = <String>{};
    for (final d in drafts) {
      final norm = d.instrumentType.trim().toLowerCase();
      if (norm.isEmpty) {
        throw ComponentLimitException('Nama instrumen komponen wajib diisi.');
      }
      if (!seen.add(norm)) {
        throw ComponentLimitException(
          'Instrumen "${d.instrumentType.trim()}" duplikat dalam satu porto. Naikkan persen pada komponen yang sudah ada.',
        );
      }
      if (d.targetPercent < 0 || d.targetPercent > 100) {
        throw ComponentLimitException(
          'Persentase komponen harus antara 0% sampai 100%.',
        );
      }
    }

    final roundedPercents =
        drafts.map((d) => PlanoraV22Calc.round2(d.targetPercent)).toList();
    if (!PlanoraV22Calc.isExact100(roundedPercents)) {
      final total = PlanoraV22Calc.totalTargetPercent(roundedPercents);
      throw ComponentLimitException(
        'Total target komponen harus tepat 100% (saat ini ${PlanoraV22Calc.formatPercent(total, forceTwoDecimals: true)}).',
      );
    }

    final existing = await (_db.select(_db.portfolioComponents)
          ..where((t) => t.portfolioId.equals(portfolioId)))
        .get();
    final actualById = {for (final e in existing) e.id: e.actualAmount};
    final actualByType = {
      for (final e in existing) e.instrumentType.trim().toLowerCase(): e.actualAmount,
    };

    await (_db.delete(_db.portfolioComponents)
          ..where((t) => t.portfolioId.equals(portfolioId)))
        .go();

    for (var i = 0; i < drafts.length; i++) {
      final d = drafts[i];
      final id = d.id ?? _uuid.v4();
      final preservedActual = d.actualAmount ??
          (d.id != null ? actualById[d.id!] : null) ??
          actualByType[d.instrumentType.trim().toLowerCase()] ??
          0;
      await _db.into(_db.portfolioComponents).insert(
            PortfolioComponentsCompanion.insert(
              id: id,
              portfolioId: portfolioId,
              ownerId: ownerId,
              instrumentType: d.instrumentType.trim(),
              name: Value(
                d.name?.trim().isEmpty ?? true ? null : d.name!.trim(),
              ),
              targetPercent: Value(roundedPercents[i]),
              actualAmount: Value(preservedActual),
              codeNote: Value(
                d.codeNote?.trim().isEmpty ?? true ? null : d.codeNote!.trim(),
              ),
              sortOrder: Value(i),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );
    }
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
    List<ComponentDraft>? initialComponents,
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
          'Total rencana setoran (${AppFormatters.rupiah(projectedTotal)}) melebihi batas nabung (${AppFormatters.rupiah(ceiling)}).',
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
      if (initialComponents != null && initialComponents.isNotEmpty) {
        await _saveComponentsInTx(
          portfolioId: id,
          ownerId: ownerId,
          drafts: initialComponents,
          nowIso: nowIso,
        );
      }
    });

    return id;
  }

  Future<void> updatePortfolio({
    required String id,
    required PortfoliosCompanion changes,
    Map<String, int>? rebalancedPlans,
    List<ComponentDraft>? components,
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
          'Total rencana setoran (${AppFormatters.rupiah(projectedTotal)}) melebihi batas nabung (${AppFormatters.rupiah(ceiling)}).',
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

      if (components != null) {
        final ownerId = await _ownerId();
        await _saveComponentsInTx(
          portfolioId: id,
          ownerId: ownerId,
          drafts: components,
          nowIso: nowIso,
        );
      }
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
          'Total rencana setoran (${AppFormatters.rupiah(total)}) melebihi batas nabung (${AppFormatters.rupiah(ceiling)}).',
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

  Future<void> replacePortfolioComponents({
    required String portfolioId,
    required List<ComponentDraft> drafts,
  }) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final ownerId = await _ownerId();
      await _saveComponentsInTx(
        portfolioId: portfolioId,
        ownerId: ownerId,
        drafts: drafts,
        nowIso: nowIso,
      );
    });
  }

  Future<void> updateComponentActualAmount({
    required String componentId,
    required int actualAmount,
  }) async {
    if (actualAmount < 0) {
      throw ComponentLimitException('Saldo aktual komponen tidak boleh negatif.');
    }
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await (_db.update(_db.portfolioComponents)
          ..where((t) => t.id.equals(componentId)))
        .write(
      PortfolioComponentsCompanion(
        actualAmount: Value(actualAmount),
        updatedAt: Value(nowIso),
      ),
    );
  }

  Future<void> deleteComponent(String componentId) async {
    await (_db.delete(_db.portfolioComponents)
          ..where((t) => t.id.equals(componentId)))
        .go();
  }

  Future<String> addContribution({
    required String portfolioId,
    required int amount,
    required String dateIso,
    String? note,
    String? componentId,
  }) async {
    if (amount <= 0) {
      throw ArgumentError('Jumlah setoran harus lebih dari Rp 0.');
    }
    final id = _uuid.v4();
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final ownerId = await _ownerId();
      await _db.into(_db.contributions).insert(
            ContributionsCompanion.insert(
              id: id,
              portfolioId: portfolioId,
              ownerId: ownerId,
              amount: amount,
              date: dateIso,
              note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
              componentId: Value(componentId),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      if (componentId != null) {
        final comp = await (_db.select(_db.portfolioComponents)
              ..where((t) => t.id.equals(componentId)))
            .getSingleOrNull();
        if (comp != null) {
          await (_db.update(_db.portfolioComponents)
                ..where((t) => t.id.equals(componentId)))
              .write(
            PortfolioComponentsCompanion(
              actualAmount: Value(comp.actualAmount + amount),
              updatedAt: Value(nowIso),
            ),
          );
        }
      }
    });
    return id;
  }

  Future<void> updateContribution({
    required String id,
    required int amount,
    required String dateIso,
    String? note,
    String? componentId,
  }) async {
    if (amount <= 0) {
      throw ArgumentError('Jumlah setoran harus lebih dari Rp 0.');
    }
    final nowIso = DateTime.now().toUtc().toIso8601String();

    await _db.transaction(() async {
      final existing = await (_db.select(_db.contributions)
            ..where((t) => t.id.equals(id)))
          .getSingle();

      final oldCompId = existing.componentId;
      final nextCompId = componentId ?? oldCompId;

      if (oldCompId != null && oldCompId == nextCompId) {
        final delta = amount - existing.amount;
        if (delta != 0) {
          final comp = await (_db.select(_db.portfolioComponents)
                ..where((t) => t.id.equals(oldCompId)))
              .getSingleOrNull();
          if (comp != null) {
            await (_db.update(_db.portfolioComponents)
                  ..where((t) => t.id.equals(oldCompId)))
                .write(
              PortfolioComponentsCompanion(
                actualAmount: Value((comp.actualAmount + delta).clamp(0, 1 << 60)),
                updatedAt: Value(nowIso),
              ),
            );
          }
        }
      } else {
        if (oldCompId != null) {
          final oldComp = await (_db.select(_db.portfolioComponents)
                ..where((t) => t.id.equals(oldCompId)))
              .getSingleOrNull();
          if (oldComp != null) {
            await (_db.update(_db.portfolioComponents)
                  ..where((t) => t.id.equals(oldCompId)))
                .write(
              PortfolioComponentsCompanion(
                actualAmount: Value(
                  (oldComp.actualAmount - existing.amount).clamp(0, 1 << 60),
                ),
                updatedAt: Value(nowIso),
              ),
            );
          }
        }
        if (nextCompId != null) {
          final nextComp = await (_db.select(_db.portfolioComponents)
                ..where((t) => t.id.equals(nextCompId)))
              .getSingleOrNull();
          if (nextComp != null) {
            await (_db.update(_db.portfolioComponents)
                  ..where((t) => t.id.equals(nextCompId)))
                .write(
              PortfolioComponentsCompanion(
                actualAmount: Value(nextComp.actualAmount + amount),
                updatedAt: Value(nowIso),
              ),
            );
          }
        }
      }

      await (_db.update(_db.contributions)..where((t) => t.id.equals(id)))
          .write(
        ContributionsCompanion(
          amount: Value(amount),
          date: Value(dateIso),
          note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
          componentId: Value(nextCompId),
          updatedAt: Value(nowIso),
        ),
      );
    });
  }

  Future<void> deleteContribution(String id) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    await _db.transaction(() async {
      final existing = await (_db.select(_db.contributions)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) return;

      if (existing.componentId != null) {
        final comp = await (_db.select(_db.portfolioComponents)
              ..where((t) => t.id.equals(existing.componentId!)))
            .getSingleOrNull();
        if (comp != null) {
          await (_db.update(_db.portfolioComponents)
                ..where((t) => t.id.equals(comp.id)))
              .write(
            PortfolioComponentsCompanion(
              actualAmount: Value(
                (comp.actualAmount - existing.amount).clamp(0, 1 << 60),
              ),
              updatedAt: Value(nowIso),
            ),
          );
        }
      }

      await (_db.delete(_db.contributions)..where((t) => t.id.equals(id))).go();
    });
  }
}

final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  return PortfolioRepository(ref.watch(appDatabaseProvider));
});

