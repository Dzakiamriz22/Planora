import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void _createV23SchemaWithPhases(File dbFile) {
  final raw = sqlite.sqlite3.open(dbFile.path);
  try {
    raw.execute('PRAGMA user_version = 4;');
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
        phase_limit_enabled INTEGER NOT NULL DEFAULT 0,
        phase_limit_amount INTEGER,
        onboarding_done INTEGER NOT NULL DEFAULT 1,
        seed_version INTEGER NOT NULL DEFAULT 3,
        component_input_mode TEXT NOT NULL DEFAULT 'percent',
        quote_card_dismissed_month TEXT,
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
        icon TEXT NOT NULL DEFAULT 'savings',
        color INTEGER NOT NULL DEFAULT 4279139430,
        note TEXT, sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE portfolio_components (
        id TEXT NOT NULL PRIMARY KEY, portfolio_id TEXT NOT NULL, owner_id TEXT NOT NULL,
        instrument_type TEXT NOT NULL, name TEXT,
        target_percent REAL NOT NULL DEFAULT 0.0,
        actual_amount INTEGER NOT NULL DEFAULT 0,
        mechanism TEXT NOT NULL DEFAULT 'nominal',
        legacy_opening_amount INTEGER NOT NULL DEFAULT 0,
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
      CREATE TABLE phases (
        id TEXT NOT NULL PRIMARY KEY, owner_id TEXT NOT NULL, name TEXT NOT NULL,
        description TEXT, is_active INTEGER NOT NULL DEFAULT 0,
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL, updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local', remote_id TEXT, deleted_at TEXT
      );
      CREATE TABLE phase_allocations (
        id TEXT NOT NULL PRIMARY KEY, phase_id TEXT NOT NULL, portfolio_id TEXT NOT NULL,
        owner_id TEXT NOT NULL, monthly_amount INTEGER NOT NULL DEFAULT 0,
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

    const now = '2026-01-01T00:00:00Z';
    raw.execute("INSERT INTO user_profiles (id, created_at, updated_at) VALUES ('u1', '$now', '$now');");
    raw.execute("INSERT INTO settings (id, owner_id, monthly_salary, minimum_living_cost, phase_limit_enabled, phase_limit_amount, created_at, updated_at) VALUES ('s1', 'u1', 6000000, 1500000, 1, 2000000, '$now', '$now');");
    raw.execute("INSERT INTO portfolios (id, owner_id, name, category, monthly_plan, created_at, updated_at) VALUES ('p1', 'u1', 'Rumah', 'cash', 1500000, '$now', '$now');");
    raw.execute("INSERT INTO portfolios (id, owner_id, name, category, monthly_plan, created_at, updated_at) VALUES ('p2', 'u1', 'Nikah', 'cash', 900000, '$now', '$now');");
    raw.execute("INSERT INTO portfolios (id, owner_id, name, category, monthly_plan, created_at, updated_at) VALUES ('p3', 'u1', 'Darurat', 'cash', 600000, '$now', '$now');");

    // Fase aktif Rp 1.500k / 900k / 600k = 3.000k (50/30/20), nama mengandung "Fase"
    raw.execute("INSERT INTO phases (id, owner_id, name, is_active, sort_order, created_at, updated_at) VALUES ('ph1', 'u1', 'Fase Hemat', 1, 0, '$now', '$now');");
    raw.execute("INSERT INTO phase_allocations (id, phase_id, portfolio_id, owner_id, monthly_amount, created_at, updated_at) VALUES ('a1', 'ph1', 'p1', 'u1', 1500000, '$now', '$now');");
    raw.execute("INSERT INTO phase_allocations (id, phase_id, portfolio_id, owner_id, monthly_amount, created_at, updated_at) VALUES ('a2', 'ph1', 'p2', 'u1', 900000, '$now', '$now');");
    raw.execute("INSERT INTO phase_allocations (id, phase_id, portfolio_id, owner_id, monthly_amount, created_at, updated_at) VALUES ('a3', 'ph1', 'p3', 'u1', 600000, '$now', '$now');");

    // Fase total Rp 0 -> Plan draf 0%
    raw.execute("INSERT INTO phases (id, owner_id, name, is_active, sort_order, created_at, updated_at) VALUES ('ph2', 'u1', 'Kosong', 0, 1, '$now', '$now');");
    raw.execute("INSERT INTO phase_allocations (id, phase_id, portfolio_id, owner_id, monthly_amount, created_at, updated_at) VALUES ('a4', 'ph2', 'p1', 'u1', 0, '$now', '$now');");
  } finally {
    raw.close();
  }
}

void main() {
  group('Bab 11.2 — Migrasi Fase -> Plan %, Ekspor/Impor schema 7, & Skala Turun', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('planora_v31_mig_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Migrasi Fase 1.5jt/900k/600k -> Plan 50/30/20, Fase 0 -> Draf 0%, nama buatan pengguna utuh', () async {
      final dbFile = File(p.join(tempDir.path, 'v23_to_v31.sqlite'));
      _createV23SchemaWithPhases(dbFile);

      final db = AppDatabase(NativeDatabase(dbFile));
      addTearDown(db.close);

      final plans = await db.select(db.plans).get();
      final allocs = await db.select(db.planAllocations).get();
      final setting = await db.select(db.settings).getSingle();

      expect(setting.planLimitEnabled, isTrue);
      expect(setting.planLimitAmount, 2000000);
      expect(plans.length, 2);

      final p1 = plans.firstWhere((pl) => pl.id == 'ph1');
      expect(p1.name, 'Fase Hemat'); // tidak ditulis ulang diam-diam
      expect(p1.isActive, isTrue);
      expect(p1.totalAmount, 3000000);

      final p1Allocs = allocs.where((a) => a.planId == 'ph1').toList();
      final map1 = {for (final a in p1Allocs) a.portfolioId: a.sharePercentX100};
      expect(map1['p1'], 5000);
      expect(map1['p2'], 3000);
      expect(map1['p3'], 2000);

      final p2 = plans.firstWhere((pl) => pl.id == 'ph2');
      expect(p2.totalAmount, 0);
      final p2Allocs = allocs.where((a) => a.planId == 'ph2').toList();
      expect(p2Allocs.every((a) => a.sharePercentX100 == 0), isTrue);

      // Skala turun proporsional mengubah total_amount tanpa mengubah persen
      final planRepo = PlanRepository(db);
      await planRepo.scaleActivePlanToCeiling(2000000);
      final scaledPlan = (await db.select(db.plans).get())
          .firstWhere((pl) => pl.id == 'ph1');
      final scaledAllocs = (await db.select(db.planAllocations).get())
          .where((a) => a.planId == 'ph1')
          .toList();
      expect(scaledPlan.totalAmount, 2000000);
      expect(
        {for (final a in scaledAllocs) a.portfolioId: a.sharePercentX100},
        {'p1': 5000, 'p2': 3000, 'p3': 2000},
      );
    });

    test('Ekspor JSON schema_version 7 memakai kunci plans & impor JSON lama berkunci phases berhasil', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final settingsRepo = SettingsRepository(db);
      final portoRepo = PortfolioRepository(db);
      final planRepo = PlanRepository(db);

      final p1 = await portoRepo.createPortfolio(
        name: 'Rumah',
        category: 'cash',
        savedTarget: 100000000,
        monthlyPlan: 0,
        annualReturnPct: 5,
        icon: 'home',
        color: 0xFF0E7C66,
      );
      final p2 = await portoRepo.createPortfolio(
        name: 'Darurat',
        category: 'cash',
        savedTarget: 20000000,
        monthlyPlan: 0,
        annualReturnPct: 5,
        icon: 'shield',
        color: 0xFF2F6DB3,
      );

      await planRepo.savePlan(
        name: 'Plan Utama',
        totalAmount: 3500000,
        sharePercentX100ByPortfolioId: {p1: 7000, p2: 3000},
      );

      final exported = await settingsRepo.exportAllToJson();
      final decoded = jsonDecode(exported) as Map<String, dynamic>;
      expect(decoded['schema_version'], 7);
      expect(decoded.containsKey('plans'), isTrue);
      expect(decoded.containsKey('phases'), isFalse);

      // Reset -> nol Plan
      await settingsRepo.resetToEmpty();
      expect(await db.select(db.plans).get(), isEmpty);

      // Impor schema 7 kembali
      await settingsRepo.importAllFromJson(exported);
      final restored = await db.select(db.plans).get();
      expect(restored.single.name, 'Plan Utama');
      expect(restored.single.totalAmount, 3500000);

      // Impor JSON lama berkunci "phases" (schema 5)
      final legacyJson = jsonEncode({
        'app': 'planora',
        'schema_version': 5,
        'profile': {'id': 'u1'},
        'settings': {'onboarding_done': true},
        'portfolios': [
          {'id': 'lp1', 'name': 'A', 'category': 'no_target'},
          {'id': 'lp2', 'name': 'B', 'category': 'no_target'},
        ],
        'phases': [
          {'id': 'lph1', 'name': 'Fase Lama', 'is_active': true},
        ],
        'phase_allocations': [
          {'id': 'la1', 'phase_id': 'lph1', 'portfolio_id': 'lp1', 'monthly_amount': 600000},
          {'id': 'la2', 'phase_id': 'lph1', 'portfolio_id': 'lp2', 'monthly_amount': 400000},
        ],
      });
      await settingsRepo.importAllFromJson(legacyJson);
      final migratedPlan = (await db.select(db.plans).get()).single;
      final migratedAllocs = await db.select(db.planAllocations).get();
      expect(migratedPlan.name, 'Fase Lama');
      expect(migratedPlan.totalAmount, 1000000);
      expect(
        PlanPercentCalc.isExact100(migratedAllocs.map((a) => a.sharePercentX100)),
        isTrue,
      );
    });
  });
}
