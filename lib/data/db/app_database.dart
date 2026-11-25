import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/data/db/seed_data.dart';
import 'package:planora/data/db/tables.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    Settings,
    Portfolios,
    PortfolioComponents,
    Contributions,
    Phases,
    PhaseAllocations,
    PriceReferences,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await customStatement('PRAGMA foreign_keys = OFF');
            try {
              const uuid = Uuid();
              final nowIso = DateTime.now().toUtc().toIso8601String();
              final ownerId = uuid.v4();

              await m.createTable(userProfiles);
              await m.createTable(portfolioComponents);

              await into(userProfiles).insert(
                UserProfilesCompanion.insert(
                  id: ownerId,
                  createdAt: nowIso,
                  updatedAt: nowIso,
                ),
              );

              final oldSettings =
                  await customSelect('SELECT * FROM settings').get();
              final oldPortfolios =
                  await customSelect('SELECT * FROM portfolios').get();
              final oldContributions =
                  await customSelect('SELECT * FROM contributions').get();
              final oldPhases =
                  await customSelect('SELECT * FROM phases').get();
              final oldAllocs =
                  await customSelect('SELECT * FROM phase_allocations').get();
              final oldRefs =
                  await customSelect('SELECT * FROM price_references').get();

              await customStatement('DROP TABLE IF EXISTS phase_allocations');
              await customStatement('DROP TABLE IF EXISTS contributions');
              await customStatement('DROP TABLE IF EXISTS phases');
              await customStatement('DROP TABLE IF EXISTS portfolios');
              await customStatement('DROP TABLE IF EXISTS price_references');
              await customStatement('DROP TABLE IF EXISTS settings');

              await m.createTable(settings);
              await m.createTable(portfolios);
              await m.createTable(contributions);
              await m.createTable(phases);
              await m.createTable(phaseAllocations);
              await m.createTable(priceReferences);

              if (oldSettings.isNotEmpty) {
                final s = oldSettings.first.data;
                await into(settings).insert(
                  SettingsCompanion.insert(
                    id: uuid.v4(),
                    ownerId: ownerId,
                    monthlySalary: Value((s['monthly_salary'] as num?)?.toInt()),
                    minimumLivingCost:
                        Value((s['minimum_living_cost'] as num?)?.toInt()),
                    currentLivingCost:
                        Value((s['current_living_cost'] as num?)?.toInt()),
                    defaultAnnualReturnPct: Value(
                      (s['default_annual_return_pct'] as num?)?.toDouble() ??
                          5.0,
                    ),
                    phaseLimitEnabled: const Value(false),
                    onboardingDone: const Value(true),
                    seedVersion: const Value(3),
                    createdAt: nowIso,
                    updatedAt: nowIso,
                  ),
                );
              }

              for (final row in oldPortfolios) {
                final d = row.data;
                final oldPlatform = d['platform'] as String?;
                await into(portfolios).insert(
                  PortfoliosCompanion.insert(
                    id: d['id'] as String,
                    ownerId: ownerId,
                    name: d['name'] as String,
                    category: d['category'] as String,
                    platformPreset: const Value('other'),
                    platformName: Value(oldPlatform),
                    fullPrice: Value((d['full_price'] as num?)?.toInt()),
                    downPayment: Value((d['down_payment'] as num?)?.toInt()),
                    fees: Value((d['fees'] as num?)?.toInt()),
                    savedTarget: Value((d['saved_target'] as num?)?.toInt()),
                    targetDate: Value(d['target_date'] as String?),
                    monthlyPlan: Value((d['monthly_plan'] as num?)?.toInt() ?? 0),
                    annualReturnPct: Value(
                      (d['annual_return_pct'] as num?)?.toDouble() ?? 5.0,
                    ),
                    calcMode:
                        Value((d['calc_mode'] as String?) ?? 'deposit_driven'),
                    icon: Value((d['icon'] as String?) ?? 'savings'),
                    color: Value((d['color'] as num?)?.toInt() ?? 0xFF0E7C66),
                    note: Value(d['note'] as String?),
                    sortOrder: Value((d['sort_order'] as num?)?.toInt() ?? 0),
                    createdAt: (d['created_at'] as String?) ?? nowIso,
                    updatedAt: (d['updated_at'] as String?) ?? nowIso,
                  ),
                );
              }

              for (final row in oldContributions) {
                final d = row.data;
                await into(contributions).insert(
                  ContributionsCompanion.insert(
                    id: d['id'] as String,
                    portfolioId: d['portfolio_id'] as String,
                    ownerId: ownerId,
                    amount: (d['amount'] as num).toInt(),
                    date: d['date'] as String,
                    note: Value(d['note'] as String?),
                    createdAt: (d['created_at'] as String?) ?? nowIso,
                    updatedAt: (d['updated_at'] as String?) ?? nowIso,
                  ),
                );
              }

              for (final row in oldPhases) {
                final d = row.data;
                await into(phases).insert(
                  PhasesCompanion.insert(
                    id: d['id'] as String,
                    ownerId: ownerId,
                    name: d['name'] as String,
                    description: Value(d['description'] as String?),
                    isActive: Value((d['is_active'] as num?)?.toInt() == 1),
                    sortOrder: Value((d['sort_order'] as num?)?.toInt() ?? 0),
                    createdAt: (d['created_at'] as String?) ?? nowIso,
                    updatedAt: (d['updated_at'] as String?) ?? nowIso,
                  ),
                );
              }

              for (final row in oldAllocs) {
                final d = row.data;
                await into(phaseAllocations).insert(
                  PhaseAllocationsCompanion.insert(
                    id: d['id'] as String,
                    phaseId: d['phase_id'] as String,
                    portfolioId: d['portfolio_id'] as String,
                    ownerId: ownerId,
                    monthlyAmount:
                        Value((d['monthly_amount'] as num?)?.toInt() ?? 0),
                    createdAt: nowIso,
                    updatedAt: nowIso,
                  ),
                );
              }

              for (final row in oldRefs) {
                final d = row.data;
                final grp = (d['group_name'] as String?) ?? '';
                final lbl = (d['label'] as String?) ?? '';
                final combinedName =
                    grp.isNotEmpty && lbl.isNotEmpty ? '$grp — $lbl' : (lbl.isNotEmpty ? lbl : grp);
                await into(priceReferences).insert(
                  PriceReferencesCompanion.insert(
                    id: d['id'] as String,
                    ownerId: ownerId,
                    name: combinedName,
                    fullPrice: (d['full_price'] as num).toInt(),
                    downPayment: (d['down_payment'] as num).toInt(),
                    fees: (d['fees'] as num).toInt(),
                    sortOrder: Value((d['sort_order'] as num?)?.toInt() ?? 0),
                    createdAt: nowIso,
                    updatedAt: nowIso,
                  ),
                );
              }
            } finally {
              await customStatement('PRAGMA foreign_keys = ON');
            }
          }

          if (from < 3) {
            await customStatement('PRAGMA foreign_keys = OFF');
            try {
              if (from >= 2) {
                await customStatement(
                  "ALTER TABLE settings ADD COLUMN component_input_mode TEXT NOT NULL DEFAULT 'percent'",
                );
                await customStatement(
                  'ALTER TABLE settings ADD COLUMN quote_card_dismissed_month TEXT',
                );
                await customStatement(
                  'ALTER TABLE contributions ADD COLUMN component_id TEXT',
                );
              }

              final oldComponents = await customSelect(
                'SELECT * FROM portfolio_components',
              ).get();
              final allPortfolios = await customSelect(
                'SELECT id, saved_target FROM portfolios',
              ).get();
              final targetByPortfolio = <String, int>{
                for (final r in allPortfolios)
                  r.data['id'] as String:
                      (r.data['saved_target'] as num?)?.toInt() ?? 0,
              };

              final byPortfolio = <String, List<Map<String, dynamic>>>{};
              for (final row in oldComponents) {
                final pid = row.data['portfolio_id'] as String;
                byPortfolio.putIfAbsent(pid, () => []).add(row.data);
              }

              final migratedRows = <PortfolioComponentsCompanion>[];
              for (final entry in byPortfolio.entries) {
                final pid = entry.key;
                final rows = entry.value;
                final amounts = rows
                    .map((r) => (r['amount'] as num?)?.toInt() ?? 0)
                    .toList();
                final sumAmt = amounts.fold<int>(0, (s, a) => s + a);
                final savedTarget = targetByPortfolio[pid] ?? 0;
                final totalTargetForMigration =
                    savedTarget > 0 ? savedTarget : sumAmt;

                final percents = PlanoraV22Calc.migrateAmountsToPercents(
                  amounts: amounts,
                  portfolioTotalTarget: totalTargetForMigration,
                );

                if (!PlanoraV22Calc.isExact100(percents)) {
                  throw MigrationValidationException(
                    'Migrasi dibatalkan: total persen porto $pid tidak tepat 100%.',
                  );
                }

                for (var i = 0; i < rows.length; i++) {
                  final d = rows[i];
                  migratedRows.add(
                    PortfolioComponentsCompanion.insert(
                      id: d['id'] as String,
                      portfolioId: pid,
                      ownerId: d['owner_id'] as String,
                      instrumentType: d['instrument_type'] as String,
                      name: Value(d['name'] as String?),
                      targetPercent: Value(percents[i]),
                      actualAmount: Value(amounts[i]),
                      codeNote: Value(d['code_note'] as String?),
                      sortOrder: Value((d['sort_order'] as num?)?.toInt() ?? i),
                      createdAt: d['created_at'] as String,
                      updatedAt: d['updated_at'] as String,
                      syncStatus: Value((d['sync_status'] as String?) ?? 'local'),
                      remoteId: Value(d['remote_id'] as String?),
                      deletedAt: Value(d['deleted_at'] as String?),
                    ),
                  );
                }
              }

              await customStatement('DROP TABLE IF EXISTS portfolio_components');
              await m.createTable(portfolioComponents);
              for (final comp in migratedRows) {
                await into(portfolioComponents).insert(comp);
              }
            } finally {
              await customStatement('PRAGMA foreign_keys = ON');
            }
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> ensureInitialized({DateTime? now}) async {
    await ensureEmptyInitialState(this, now: now);
  }

  Future<void> resetToEmpty({DateTime? now}) async {
    final profiles = await select(userProfiles).get();
    for (final prof in profiles) {
      if (prof.avatarPath != null && prof.avatarPath!.isNotEmpty) {
        final f = File(prof.avatarPath!);
        if (await f.exists()) {
          await f.delete().catchError((_) => f);
        }
      }
    }

    await transaction(() async {
      await delete(phaseAllocations).go();
      await delete(portfolioComponents).go();
      await delete(contributions).go();
      await delete(phases).go();
      await delete(portfolios).go();
      await delete(priceReferences).go();
      await delete(settings).go();
      await delete(userProfiles).go();
    });
    await ensureEmptyInitialState(this, now: now);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'planora.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

