import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
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
    Plans,
    PlanAllocations,
    PriceReferences,
    StockTransactions,
    CashFlowCategories,
    CashFlowTransactions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 6;

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
              await m.createTable(plans);
              await m.createTable(planAllocations);
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
                    planLimitEnabled: const Value(false),
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
                final pid = d['id'] as String;
                final phaseAllocs = oldAllocs
                    .where((a) => (a.data['phase_id'] as String) == pid)
                    .toList();
                final amountsByPorto = <String, int>{
                  for (final a in phaseAllocs)
                    a.data['portfolio_id'] as String:
                        (a.data['monthly_amount'] as num?)?.toInt() ?? 0,
                };
                final migrated = PlanPercentCalc.migrateNominalAmountsToPlanPercents(
                  amountsByPorto,
                );
                await into(plans).insert(
                  PlansCompanion.insert(
                    id: pid,
                    ownerId: ownerId,
                    name: d['name'] as String,
                    description: Value(d['description'] as String?),
                    totalAmount: Value(migrated.totalAmount),
                    isActive: Value((d['is_active'] as num?)?.toInt() == 1),
                    sortOrder: Value((d['sort_order'] as num?)?.toInt() ?? 0),
                    createdAt: (d['created_at'] as String?) ?? nowIso,
                    updatedAt: (d['updated_at'] as String?) ?? nowIso,
                  ),
                );
                for (final entry in migrated.sharePercentX100ById.entries) {
                  await into(planAllocations).insert(
                    PlanAllocationsCompanion.insert(
                      id: uuid.v4(),
                      planId: pid,
                      portfolioId: entry.key,
                      ownerId: ownerId,
                      sharePercentX100: Value(entry.value),
                      createdAt: nowIso,
                      updatedAt: nowIso,
                    ),
                  );
                }
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

          if (from < 4) {
            await migrateToV23LotMechanism(m);
          }

          if (from < 5) {
            await migrateToV31PlanPercent(m);
          }

          if (from < 6) {
            await migrateToV33CashFlow(m);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          if (await _hasTable('plan_allocations') &&
              !await _hasColumn('plan_allocations', 'fixed_amount')) {
            await customStatement(
              'ALTER TABLE plan_allocations ADD COLUMN fixed_amount INTEGER',
            );
          }
          if (await _hasTable('settings') &&
              !await _hasColumn('settings', 'hide_amounts')) {
            await customStatement(
              'ALTER TABLE settings ADD COLUMN hide_amounts INTEGER NOT NULL DEFAULT 0',
            );
          }
        },
      );

  Future<bool> _hasColumn(String table, String column) async {
    final rows = await customSelect('PRAGMA table_info($table)').get();
    return rows.any((r) => (r.data['name'] as String?) == column);
  }

  Future<bool> _hasTable(String table) async {
    final rows = await customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name = ?",
      variables: [Variable.withString(table)],
    ).get();
    return rows.isNotEmpty;
  }

  Future<void> migrateToV23LotMechanism([Migrator? m]) async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      final beforeContribRows = await customSelect(
        'SELECT COALESCE(SUM(amount), 0) AS total FROM contributions',
      ).getSingle();
      final totalContribBefore =
          (beforeContribRows.data['total'] as num?)?.toInt() ?? 0;

      final beforeCompRows = await customSelect(
        'SELECT id, portfolio_id, instrument_type, actual_amount FROM portfolio_components',
      ).get();

      var totalCompActualBefore = 0;
      for (final row in beforeCompRows) {
        final amt = (row.data['actual_amount'] as num?)?.toInt() ?? 0;
        if (amt < 0) {
          throw MigrationValidationException(
            'Migrasi v2.3 dibatalkan: saldo aktual komponen ${row.data['id']} tidak valid (negatif). Data lama dipertahankan.',
          );
        }
        totalCompActualBefore += amt;
      }

      if (!await _hasColumn('portfolio_components', 'mechanism')) {
        await customStatement(
          "ALTER TABLE portfolio_components ADD COLUMN mechanism TEXT NOT NULL DEFAULT 'nominal'",
        );
      }
      if (!await _hasColumn('portfolio_components', 'legacy_opening_amount')) {
        await customStatement(
          'ALTER TABLE portfolio_components ADD COLUMN legacy_opening_amount INTEGER NOT NULL DEFAULT 0',
        );
      }
      if (!await _hasColumn('contributions', 'stock_transaction_id')) {
        await customStatement(
          'ALTER TABLE contributions ADD COLUMN stock_transaction_id TEXT',
        );
      }
      if (!await _hasColumn('contributions', 'source')) {
        await customStatement(
          "ALTER TABLE contributions ADD COLUMN source TEXT NOT NULL DEFAULT 'manual'",
        );
      }

      if (!await _hasTable('stock_transactions')) {
        if (m != null) {
          await m.createTable(stockTransactions);
        } else {
          await customStatement(
            '''
            CREATE TABLE IF NOT EXISTS stock_transactions (
              id TEXT NOT NULL PRIMARY KEY,
              owner_id TEXT NOT NULL REFERENCES user_profiles(id),
              component_id TEXT NOT NULL REFERENCES portfolio_components(id) ON DELETE CASCADE,
              portfolio_id TEXT NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
              ticker TEXT NOT NULL,
              side TEXT NOT NULL,
              lots INTEGER NOT NULL,
              shares INTEGER NOT NULL,
              price_per_share INTEGER NOT NULL,
              total_amount INTEGER NOT NULL,
              transaction_date TEXT NOT NULL,
              note TEXT,
              created_at TEXT NOT NULL,
              updated_at TEXT NOT NULL,
              sync_status TEXT NOT NULL DEFAULT 'local_only',
              remote_id TEXT,
              deleted_at TEXT
            )
            ''',
          );
        }
      }

      final compRows = await customSelect(
        'SELECT id, instrument_type, actual_amount, mechanism, legacy_opening_amount FROM portfolio_components',
      ).get();

      for (final row in compRows) {
        final id = row.data['id'] as String;
        final instrument = (row.data['instrument_type'] as String?) ?? '';
        final actual = (row.data['actual_amount'] as num?)?.toInt() ?? 0;
        final existingLegacy =
            (row.data['legacy_opening_amount'] as num?)?.toInt() ?? 0;
        final isDirectStock = StockLotCalc.isDirectStockInstrument(instrument);
        final mechanism = isDirectStock
            ? StockLotCalc.mechanismLotBased
            : StockLotCalc.mechanismNominal;

        if (isDirectStock) {
          final txRows = await customSelect(
            'SELECT id, ticker, side, lots, shares, price_per_share, total_amount, transaction_date, created_at FROM stock_transactions WHERE component_id = ? AND deleted_at IS NULL',
            variables: [Variable.withString(id)],
          ).get();

          final ledger = StockLotCalc.computeLedger(
            txRows.map(
              (t) => StockTxRecord(
                id: t.data['id'] as String,
                ticker: t.data['ticker'] as String,
                side: t.data['side'] as String,
                lots: (t.data['lots'] as num).toInt(),
                shares: (t.data['shares'] as num).toInt(),
                pricePerShare: (t.data['price_per_share'] as num).toInt(),
                totalAmount: (t.data['total_amount'] as num).toInt(),
                transactionDate: t.data['transaction_date'] as String,
                createdAt: t.data['created_at'] as String,
              ),
            ),
          );

          final expectedLegacy =
              (actual - ledger.totalPositionsModal).clamp(0, actual);
          final nextLegacy = existingLegacy > 0 &&
                  (ledger.totalPositionsModal + existingLegacy == actual)
              ? existingLegacy
              : expectedLegacy;

          await customStatement(
            'UPDATE portfolio_components SET mechanism = ?, legacy_opening_amount = ? WHERE id = ?',
            [mechanism, nextLegacy, id],
          );
        } else {
          await customStatement(
            'UPDATE portfolio_components SET mechanism = ?, legacy_opening_amount = 0 WHERE id = ?',
            [mechanism, id],
          );
        }
      }

      final afterContribRow = await customSelect(
        'SELECT COALESCE(SUM(amount), 0) AS total FROM contributions',
      ).getSingle();
      final totalContribAfter =
          (afterContribRow.data['total'] as num?)?.toInt() ?? 0;

      final afterCompRows = await customSelect(
        'SELECT id, actual_amount, mechanism, legacy_opening_amount FROM portfolio_components',
      ).get();
      var totalCompActualAfter = 0;
      for (final row in afterCompRows) {
        final actual = (row.data['actual_amount'] as num?)?.toInt() ?? 0;
        final legacy =
            (row.data['legacy_opening_amount'] as num?)?.toInt() ?? 0;
        if (actual < 0 || legacy < 0) {
          throw MigrationValidationException(
            'Migrasi v2.3 dibatalkan: ditemukan saldo negatif setelah migrasi.',
          );
        }
        totalCompActualAfter += actual;
      }

      if (totalContribAfter != totalContribBefore ||
          totalCompActualAfter != totalCompActualBefore) {
        throw MigrationValidationException(
          'Migrasi v2.3 dibatalkan: total saldo tidak cocok setelah migrasi (sebelum: $totalContribBefore/$totalCompActualBefore, sesudah: $totalContribAfter/$totalCompActualAfter).',
        );
      }
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }

  Future<void> migrateToV31PlanPercent([Migrator? m]) async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      if (!await _hasColumn('settings', 'plan_limit_enabled')) {
        await customStatement(
          'ALTER TABLE settings ADD COLUMN plan_limit_enabled INTEGER NOT NULL DEFAULT 0',
        );
        if (await _hasColumn('settings', 'phase_limit_enabled')) {
          await customStatement(
            'UPDATE settings SET plan_limit_enabled = phase_limit_enabled',
          );
        }
      }
      if (!await _hasColumn('settings', 'plan_limit_amount')) {
        await customStatement(
          'ALTER TABLE settings ADD COLUMN plan_limit_amount INTEGER',
        );
        if (await _hasColumn('settings', 'phase_limit_amount')) {
          await customStatement(
            'UPDATE settings SET plan_limit_amount = phase_limit_amount',
          );
        }
      }
      final reminderCols = <String, String>{
        'reminder_monthly_enabled': 'INTEGER NOT NULL DEFAULT 0',
        'reminder_monthly_day': 'INTEGER NOT NULL DEFAULT 1',
        'reminder_monthly_hour': 'INTEGER NOT NULL DEFAULT 9',
        'reminder_monthly_minute': 'INTEGER NOT NULL DEFAULT 0',
        'reminder_expense_enabled': 'INTEGER NOT NULL DEFAULT 0',
        'reminder_expense_hour': 'INTEGER NOT NULL DEFAULT 9',
        'reminder_expense_minute': 'INTEGER NOT NULL DEFAULT 0',
        'reminder_milestone_enabled': 'INTEGER NOT NULL DEFAULT 0',
      };
      for (final entry in reminderCols.entries) {
        if (!await _hasColumn('settings', entry.key)) {
          await customStatement(
            'ALTER TABLE settings ADD COLUMN ${entry.key} ${entry.value}',
          );
        }
      }

      final hasOldPhases = await _hasTable('phases');
      final hasNewPlans = await _hasTable('plans');

      if (!hasNewPlans) {
        if (m != null) {
          await m.createTable(plans);
          await m.createTable(planAllocations);
        } else {
          await customStatement('''
            CREATE TABLE IF NOT EXISTS plans (
              id TEXT NOT NULL PRIMARY KEY,
              owner_id TEXT NOT NULL REFERENCES user_profiles(id),
              name TEXT NOT NULL,
              description TEXT,
              total_amount INTEGER NOT NULL DEFAULT 0,
              is_active INTEGER NOT NULL DEFAULT 0,
              sort_order INTEGER NOT NULL DEFAULT 0,
              created_at TEXT NOT NULL,
              updated_at TEXT NOT NULL,
              sync_status TEXT NOT NULL DEFAULT 'local',
              remote_id TEXT,
              deleted_at TEXT
            )
          ''');
          await customStatement('''
            CREATE TABLE IF NOT EXISTS plan_allocations (
              id TEXT NOT NULL PRIMARY KEY,
              plan_id TEXT NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
              portfolio_id TEXT NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
              owner_id TEXT NOT NULL REFERENCES user_profiles(id),
              share_percent_x100 INTEGER NOT NULL DEFAULT 0,
              created_at TEXT NOT NULL,
              updated_at TEXT NOT NULL,
              sync_status TEXT NOT NULL DEFAULT 'local',
              remote_id TEXT,
              deleted_at TEXT,
              UNIQUE(plan_id, portfolio_id)
            )
          ''');
        }
      }

      if (hasOldPhases) {
        final existingPortfolios = await customSelect(
          'SELECT id FROM portfolios',
        ).get();
        final validPortfolioIds = {
          for (final r in existingPortfolios) r.data['id'] as String,
        };

        final oldPhases = await customSelect('SELECT * FROM phases').get();
        final hasOldAllocs = await _hasTable('phase_allocations');
        final oldAllocs = hasOldAllocs
            ? await customSelect('SELECT * FROM phase_allocations').get()
            : const <QueryRow>[];

        final allocsByPhase = <String, Map<String, int>>{};
        final allocMetaByKey = <String, Map<String, dynamic>>{};
        for (final row in oldAllocs) {
          final phId = row.data['phase_id'] as String;
          final portoId = row.data['portfolio_id'] as String;
          if (!validPortfolioIds.contains(portoId)) continue;
          final amt = (row.data['monthly_amount'] as num?)?.toInt() ?? 0;
          allocsByPhase.putIfAbsent(phId, () => {})[portoId] = amt;
          allocMetaByKey['$phId::$portoId'] = row.data;
        }

        const uuid = Uuid();
        final nowIso = DateTime.now().toUtc().toIso8601String();

        for (final ph in oldPhases) {
          final d = ph.data;
          final phId = d['id'] as String;
          final ownerId = d['owner_id'] as String;
          final amountsByPorto = allocsByPhase[phId] ?? const <String, int>{};
          final migrated = PlanPercentCalc.migrateNominalAmountsToPlanPercents(
            amountsByPorto,
          );

          await customStatement(
            '''
            INSERT OR REPLACE INTO plans
              (id, owner_id, name, description, total_amount, is_active, sort_order, created_at, updated_at, sync_status, remote_id, deleted_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
            [
              phId,
              ownerId,
              d['name'],
              d['description'],
              migrated.totalAmount,
              d['is_active'] ?? 0,
              d['sort_order'] ?? 0,
              d['created_at'] ?? nowIso,
              d['updated_at'] ?? nowIso,
              d['sync_status'] ?? 'local',
              d['remote_id'],
              d['deleted_at'],
            ],
          );

          for (final entry in migrated.sharePercentX100ById.entries) {
            final meta = allocMetaByKey['$phId::${entry.key}'];
            await customStatement(
              '''
              INSERT OR REPLACE INTO plan_allocations
                (id, plan_id, portfolio_id, owner_id, share_percent_x100, created_at, updated_at, sync_status, remote_id, deleted_at)
              VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
              ''',
              [
                meta?['id'] ?? uuid.v4(),
                phId,
                entry.key,
                ownerId,
                entry.value,
                meta?['created_at'] ?? nowIso,
                meta?['updated_at'] ?? nowIso,
                meta?['sync_status'] ?? 'local',
                meta?['remote_id'],
                meta?['deleted_at'],
              ],
            );
          }
        }

        await customStatement('DROP TABLE IF EXISTS phase_allocations');
        await customStatement('DROP TABLE IF EXISTS phases');
      }
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }

  Future<void> migrateToV33CashFlow([Migrator? m]) async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      if (!await _hasTable('cash_flow_categories')) {
        if (m != null) {
          await m.createTable(cashFlowCategories);
        } else {
          await customStatement(
            '''
            CREATE TABLE IF NOT EXISTS cash_flow_categories (
              id TEXT NOT NULL PRIMARY KEY,
              owner_id TEXT NOT NULL REFERENCES user_profiles(id),
              type TEXT NOT NULL,
              name TEXT NOT NULL,
              icon TEXT NOT NULL DEFAULT 'category',
              color INTEGER NOT NULL DEFAULT 4279139430,
              is_default INTEGER NOT NULL DEFAULT 0,
              sort_order INTEGER NOT NULL DEFAULT 0,
              is_hidden INTEGER NOT NULL DEFAULT 0,
              created_at TEXT NOT NULL,
              updated_at TEXT NOT NULL,
              sync_status TEXT NOT NULL DEFAULT 'local',
              remote_id TEXT,
              deleted_at TEXT
            )
            ''',
          );
        }
      }

      if (!await _hasTable('cash_flow_transactions')) {
        if (m != null) {
          await m.createTable(cashFlowTransactions);
        } else {
          await customStatement(
            '''
            CREATE TABLE IF NOT EXISTS cash_flow_transactions (
              id TEXT NOT NULL PRIMARY KEY,
              owner_id TEXT NOT NULL REFERENCES user_profiles(id),
              type TEXT NOT NULL,
              transaction_date TEXT NOT NULL,
              amount INTEGER NOT NULL,
              category_id TEXT NOT NULL REFERENCES cash_flow_categories(id),
              note TEXT,
              created_at TEXT NOT NULL,
              updated_at TEXT NOT NULL,
              sync_status TEXT NOT NULL DEFAULT 'local',
              remote_id TEXT,
              deleted_at TEXT
            )
            ''',
          );
        }
      }

      final profiles = await select(userProfiles).get();
      if (profiles.isNotEmpty) {
        await ensureDefaultCashFlowCategories(
          this,
          ownerId: profiles.first.id,
        );
      }
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }

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
      await delete(cashFlowTransactions).go();
      await delete(cashFlowCategories).go();
      await delete(stockTransactions).go();
      await delete(planAllocations).go();
      await delete(portfolioComponents).go();
      await delete(contributions).go();
      await delete(plans).go();
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

