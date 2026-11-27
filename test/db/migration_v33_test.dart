import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:planora/core/calc/cash_flow_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/cash_flow_repository.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void _createSchema5Db(File dbFile) {
  final raw = sqlite.sqlite3.open(dbFile.path);
  try {
    raw.execute('PRAGMA user_version = 5;');
    raw.execute('''
      CREATE TABLE user_profiles (
        id TEXT NOT NULL PRIMARY KEY,
        display_name_full TEXT, display_name TEXT, email_local TEXT, phone_local TEXT,
        birth_date TEXT, avatar_path TEXT,
        theme_pref TEXT NOT NULL DEFAULT 'ikut_sistem',
        currency TEXT NOT NULL DEFAULT 'IDR',
        locale TEXT NOT NULL DEFAULT 'id_ID',
        is_local_only INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE settings (
        id TEXT NOT NULL PRIMARY KEY, owner_id TEXT NOT NULL,
        monthly_salary INTEGER, minimum_living_cost INTEGER, current_living_cost INTEGER,
        default_annual_return_pct REAL NOT NULL DEFAULT 5.0,
        plan_limit_enabled INTEGER NOT NULL DEFAULT 0, plan_limit_amount INTEGER,
        onboarding_done INTEGER NOT NULL DEFAULT 1, seed_version INTEGER NOT NULL DEFAULT 3,
        component_input_mode TEXT NOT NULL DEFAULT 'percent',
        quote_card_dismissed_month TEXT,
        reminder_monthly_enabled INTEGER NOT NULL DEFAULT 0,
        reminder_monthly_day INTEGER NOT NULL DEFAULT 1,
        reminder_monthly_hour INTEGER NOT NULL DEFAULT 9,
        reminder_monthly_minute INTEGER NOT NULL DEFAULT 0,
        reminder_expense_enabled INTEGER NOT NULL DEFAULT 0,
        reminder_expense_hour INTEGER NOT NULL DEFAULT 9,
        reminder_expense_minute INTEGER NOT NULL DEFAULT 0,
        reminder_milestone_enabled INTEGER NOT NULL DEFAULT 0,
        hide_amounts INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE portfolios (
        id TEXT NOT NULL PRIMARY KEY, owner_id TEXT NOT NULL, name TEXT NOT NULL,
        category TEXT NOT NULL, platform_preset TEXT, platform_name TEXT,
        full_price INTEGER, down_payment INTEGER, fees INTEGER, saved_target INTEGER,
        target_date TEXT, monthly_plan INTEGER NOT NULL DEFAULT 0,
        annual_return_pct REAL NOT NULL DEFAULT 5.0,
        calc_mode TEXT NOT NULL DEFAULT 'deposit_driven',
        icon TEXT NOT NULL DEFAULT 'savings', color INTEGER NOT NULL DEFAULT 4279139430,
        note TEXT, sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE portfolio_components (
        id TEXT NOT NULL PRIMARY KEY, portfolio_id TEXT NOT NULL, owner_id TEXT NOT NULL,
        instrument_type TEXT NOT NULL, name TEXT,
        target_percent REAL NOT NULL DEFAULT 0.0, actual_amount INTEGER NOT NULL DEFAULT 0,
        mechanism TEXT NOT NULL DEFAULT 'nominal', legacy_opening_amount INTEGER NOT NULL DEFAULT 0,
        code_note TEXT, sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE contributions (
        id TEXT NOT NULL PRIMARY KEY, portfolio_id TEXT NOT NULL, owner_id TEXT NOT NULL,
        amount INTEGER NOT NULL, date TEXT NOT NULL, note TEXT, component_id TEXT,
        stock_transaction_id TEXT, source TEXT NOT NULL DEFAULT 'manual',
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE stock_transactions (
        id TEXT NOT NULL PRIMARY KEY, owner_id TEXT NOT NULL,
        component_id TEXT NOT NULL, portfolio_id TEXT NOT NULL,
        ticker TEXT NOT NULL, side TEXT NOT NULL, lots INTEGER NOT NULL,
        shares INTEGER NOT NULL, price_per_share INTEGER NOT NULL,
        total_amount INTEGER NOT NULL, transaction_date TEXT NOT NULL, note TEXT,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local_only', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE plans (
        id TEXT NOT NULL PRIMARY KEY, owner_id TEXT NOT NULL, name TEXT NOT NULL,
        description TEXT, total_amount INTEGER NOT NULL DEFAULT 0,
        is_active INTEGER NOT NULL DEFAULT 0, sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE plan_allocations (
        id TEXT NOT NULL PRIMARY KEY, plan_id TEXT NOT NULL, portfolio_id TEXT NOT NULL,
        owner_id TEXT NOT NULL, share_percent_x100 INTEGER NOT NULL DEFAULT 0,
        fixed_amount INTEGER,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE price_references (
        id TEXT NOT NULL PRIMARY KEY, owner_id TEXT NOT NULL, name TEXT NOT NULL,
        full_price INTEGER NOT NULL, down_payment INTEGER NOT NULL, fees INTEGER NOT NULL,
        note TEXT, sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
    ''');
    const now = '2026-11-01T00:00:00Z';
    raw.execute("INSERT INTO user_profiles (id, created_at, updated_at) VALUES ('u1', '$now', '$now');");
    raw.execute("INSERT INTO settings (id, owner_id, monthly_salary, minimum_living_cost, created_at, updated_at) VALUES ('s1', 'u1', 7000000, 3000000, '$now', '$now');");
    raw.execute("INSERT INTO portfolios (id, owner_id, name, category, saved_target, monthly_plan, created_at, updated_at) VALUES ('p1', 'u1', 'Rumah', 'cash', 100000000, 2000000, '$now', '$now');");
    raw.execute("INSERT INTO portfolio_components (id, portfolio_id, owner_id, instrument_type, target_percent, actual_amount, created_at, updated_at) VALUES ('c1', 'p1', 'u1', 'RDPU', 100.0, 5000000, '$now', '$now');");
    raw.execute("INSERT INTO contributions (id, portfolio_id, owner_id, amount, date, created_at, updated_at) VALUES ('ct1', 'p1', 'u1', 5000000, '2026-11-01', '$now', '$now');");
    raw.execute("INSERT INTO plans (id, owner_id, name, total_amount, is_active, created_at, updated_at) VALUES ('pl1', 'u1', 'Plan Utama', 2000000, 1, '$now', '$now');");
    raw.execute("INSERT INTO plan_allocations (id, plan_id, portfolio_id, owner_id, share_percent_x100, created_at, updated_at) VALUES ('pa1', 'pl1', 'p1', 'u1', 10000, '$now', '$now');");
  } finally {
    raw.close();
  }
}

void main() {
  group('v3.3 — Migrasi Skema 5 -> 6, Anti Dobel, Kategori, & Ekspor/Impor/Reset', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('planora_v33_mig_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Migrasi 5 -> 6 idempotent, data lama utuh, seed tepat 5 pemasukan + 10 pengeluaran', () async {
      final dbFile = File(p.join(tempDir.path, 'v32_to_v33.sqlite'));
      _createSchema5Db(dbFile);

      final db = AppDatabase(NativeDatabase(dbFile));
      addTearDown(db.close);

      final cats = await db.select(db.cashFlowCategories).get();
      final incomeCats = cats.where((c) => c.type == CashFlowCalc.typeIncome).toList();
      final expenseCats = cats.where((c) => c.type == CashFlowCalc.typeExpense).toList();
      expect(incomeCats.length, 5);
      expect(expenseCats.length, 10);

      // Idempotent bila dipanggil ulang
      await db.migrateToV33CashFlow();
      final catsAgain = await db.select(db.cashFlowCategories).get();
      expect(catsAgain.length, 15);

      // Data lama (saldo, komponen, Plan) tidak berubah
      final contribs = await db.select(db.contributions).get();
      final comps = await db.select(db.portfolioComponents).get();
      final plans = await db.select(db.plans).get();
      expect(contribs.single.amount, 5000000);
      expect(comps.single.actualAmount, 5000000);
      expect(plans.single.totalAmount, 2000000);
    });

    test('Anti dobel: catat pemasukan Gaji tidak ubah gaji rencana, plafon, Plan, atau setoran', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final settingsRepo = SettingsRepository(db);
      final portoRepo = PortfolioRepository(db);
      final planRepo = PlanRepository(db);
      final cfRepo = CashFlowRepository(db);

      await settingsRepo.updateFinancialProfile(
        monthlySalary: 6000000,
        minimumLivingCost: 2500000,
      );
      final pid = await portoRepo.createPortfolio(
        name: 'Dana Darurat',
        category: 'cash',
        savedTarget: 20000000,
        monthlyPlan: 1500000,
        annualReturnPct: 4,
        icon: 'shield',
        color: 0xFF0E7C66,
      );
      await planRepo.savePlan(
        name: 'Plan Utama',
        totalAmount: 1500000,
        sharePercentX100ByPortfolioId: {pid: 10000},
      );

      final gajiCat = (await db.select(db.cashFlowCategories).get())
          .firstWhere((c) => c.type == CashFlowCalc.typeIncome && c.name == 'Gaji');
      await cfRepo.addTransaction(
        type: CashFlowCalc.typeIncome,
        amount: 9500000,
        categoryId: gajiCat.id,
        transactionDate: DateTime(2026, 11, 25),
        now: DateTime(2026, 11, 27),
      );

      final settingAfter = await settingsRepo.getSettings();
      final planAfter = (await db.select(db.plans).get()).single;
      final contribsAfter = await db.select(db.contributions).get();
      expect(settingAfter.monthlySalary, 6000000);
      expect(planAfter.totalAmount, 1500000);
      expect(contribsAfter, isEmpty);
    });

    test('Aturan kategori terpakai disembunyikan (bukan dihapus), kategori kosong dihapus, ekspor/impor/reset', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final cfRepo = CashFlowRepository(db);
      final settingsRepo = SettingsRepository(db);

      final customUsedId = await cfRepo.createCategory(
        type: CashFlowCalc.typeExpense,
        name: 'Kopi Spesial',
      );
      final customEmptyId = await cfRepo.createCategory(
        type: CashFlowCalc.typeExpense,
        name: 'Hobi Sementara',
      );
      await cfRepo.addTransaction(
        type: CashFlowCalc.typeExpense,
        amount: 45000,
        categoryId: customUsedId,
        transactionDate: DateTime(2026, 11, 20),
        now: DateTime(2026, 11, 27),
      );

      // Terpakai -> disembunyikan (false), transaksi lama tetap terhubung
      final deletedUsed = await cfRepo.deleteOrHideCategory(customUsedId);
      expect(deletedUsed, isFalse);
      final usedRow = (await db.select(db.cashFlowCategories).get())
          .firstWhere((c) => c.id == customUsedId);
      expect(usedRow.isHidden, isTrue);

      // Kosong -> dihapus permanen (true)
      final deletedEmpty = await cfRepo.deleteOrHideCategory(customEmptyId);
      expect(deletedEmpty, isTrue);

      // Ekspor JSON menyertakan arus kas
      final exported = await settingsRepo.exportAllToJson();
      final decoded = jsonDecode(exported) as Map<String, dynamic>;
      expect((decoded['cash_flow_categories'] as List).isNotEmpty, isTrue);
      expect((decoded['cash_flow_transactions'] as List).length, 1);

      // Impor file lama tanpa kunci arus kas jalan tanpa error & seed 5+10 kategori
      decoded.remove('cash_flow_categories');
      decoded.remove('cash_flow_transactions');
      await settingsRepo.importAllFromJson(jsonEncode(decoded));
      final afterOldImportCats = await db.select(db.cashFlowCategories).get();
      expect(
        afterOldImportCats.where((c) => c.type == CashFlowCalc.typeIncome).length,
        5,
      );
      expect(
        afterOldImportCats.where((c) => c.type == CashFlowCalc.typeExpense).length,
        10,
      );

      // Reset menghapus transaksi & kategori kustom, mengembalikan 5 + 10 bawaan
      await cfRepo.createCategory(
        type: CashFlowCalc.typeIncome,
        name: 'Royalti',
      );
      await settingsRepo.resetToEmpty();
      final afterResetTxs = await db.select(db.cashFlowTransactions).get();
      final afterResetCats = await db.select(db.cashFlowCategories).get();
      expect(afterResetTxs, isEmpty);
      expect(
        afterResetCats.where((c) => c.type == CashFlowCalc.typeIncome).length,
        5,
      );
      expect(
        afterResetCats.where((c) => c.type == CashFlowCalc.typeExpense).length,
        10,
      );
    });
  });
}
