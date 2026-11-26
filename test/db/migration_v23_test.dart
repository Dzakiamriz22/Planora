import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path/path.dart' as p;
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/data/repositories/stock_repository.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void _createV22SchemaAndSeed(
  File dbFile, {
  int sahamActual = 40000,
  int rdSahamActual = 60000,
  int rdpuActual = 100000,
}) {
  final raw = sqlite.sqlite3.open(dbFile.path);
  try {
    raw.execute('PRAGMA user_version = 3;');
    raw.execute('''
      CREATE TABLE user_profiles (
        id TEXT NOT NULL PRIMARY KEY,
        display_name_full TEXT,
        display_name TEXT,
        email_local TEXT,
        phone_local TEXT,
        birth_date TEXT,
        avatar_path TEXT,
        theme_pref TEXT NOT NULL DEFAULT 'ikut_sistem',
        currency TEXT NOT NULL DEFAULT 'IDR',
        locale TEXT NOT NULL DEFAULT 'id_ID',
        is_local_only INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE settings (
        id TEXT NOT NULL PRIMARY KEY,
        owner_id TEXT NOT NULL,
        monthly_salary INTEGER,
        minimum_living_cost INTEGER,
        current_living_cost INTEGER,
        default_annual_return_pct REAL NOT NULL DEFAULT 5.0,
        phase_limit_enabled INTEGER NOT NULL DEFAULT 0,
        phase_limit_amount INTEGER,
        onboarding_done INTEGER NOT NULL DEFAULT 1,
        seed_version INTEGER NOT NULL DEFAULT 3,
        component_input_mode TEXT NOT NULL DEFAULT 'percent',
        quote_card_dismissed_month TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE portfolios (
        id TEXT NOT NULL PRIMARY KEY,
        owner_id TEXT NOT NULL,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        platform_preset TEXT,
        platform_name TEXT,
        full_price INTEGER,
        down_payment INTEGER,
        fees INTEGER,
        saved_target INTEGER,
        target_date TEXT,
        monthly_plan INTEGER NOT NULL DEFAULT 0,
        annual_return_pct REAL NOT NULL DEFAULT 5.0,
        calc_mode TEXT NOT NULL DEFAULT 'deposit_driven',
        icon TEXT NOT NULL DEFAULT 'savings',
        color INTEGER NOT NULL DEFAULT 4279139430,
        note TEXT,
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE portfolio_components (
        id TEXT NOT NULL PRIMARY KEY,
        portfolio_id TEXT NOT NULL,
        owner_id TEXT NOT NULL,
        instrument_type TEXT NOT NULL,
        name TEXT,
        target_percent REAL NOT NULL DEFAULT 0.0,
        actual_amount INTEGER NOT NULL DEFAULT 0,
        code_note TEXT,
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE contributions (
        id TEXT NOT NULL PRIMARY KEY,
        portfolio_id TEXT NOT NULL,
        owner_id TEXT NOT NULL,
        amount INTEGER NOT NULL,
        date TEXT NOT NULL,
        note TEXT,
        component_id TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE phases (
        id TEXT NOT NULL PRIMARY KEY,
        owner_id TEXT NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        is_active INTEGER NOT NULL DEFAULT 0,
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE phase_allocations (
        id TEXT NOT NULL PRIMARY KEY,
        phase_id TEXT NOT NULL,
        portfolio_id TEXT NOT NULL,
        owner_id TEXT NOT NULL,
        monthly_amount INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
      CREATE TABLE price_references (
        id TEXT NOT NULL PRIMARY KEY,
        owner_id TEXT NOT NULL,
        name TEXT NOT NULL,
        full_price INTEGER NOT NULL,
        down_payment INTEGER NOT NULL,
        fees INTEGER NOT NULL,
        note TEXT,
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'local',
        remote_id TEXT,
        deleted_at TEXT
      );
    ''');

    const now = '2026-01-01T00:00:00Z';
    raw.execute(
      "INSERT INTO user_profiles (id, created_at, updated_at) VALUES ('u1', '$now', '$now');",
    );
    raw.execute(
      "INSERT INTO settings (id, owner_id, created_at, updated_at) VALUES ('s1', 'u1', '$now', '$now');",
    );
    raw.execute(
      "INSERT INTO portfolios (id, owner_id, name, category, saved_target, created_at, updated_at) VALUES ('p1', 'u1', 'Rumah', 'cash', 100000000, '$now', '$now');",
    );
    raw.execute(
      "INSERT INTO portfolio_components (id, portfolio_id, owner_id, instrument_type, target_percent, actual_amount, sort_order, created_at, updated_at) VALUES ('c_saham', 'p1', 'u1', 'Saham langsung', 20.0, $sahamActual, 0, '$now', '$now');",
    );
    raw.execute(
      "INSERT INTO portfolio_components (id, portfolio_id, owner_id, instrument_type, target_percent, actual_amount, sort_order, created_at, updated_at) VALUES ('c_rdsaham', 'p1', 'u1', 'RD Saham', 30.0, $rdSahamActual, 1, '$now', '$now');",
    );
    raw.execute(
      "INSERT INTO portfolio_components (id, portfolio_id, owner_id, instrument_type, target_percent, actual_amount, sort_order, created_at, updated_at) VALUES ('c_rdpu', 'p1', 'u1', 'RDPU', 50.0, $rdpuActual, 2, '$now', '$now');",
    );
    final total = sahamActual + rdSahamActual + rdpuActual;
    raw.execute(
      "INSERT INTO contributions (id, portfolio_id, owner_id, amount, date, created_at, updated_at) VALUES ('ct1', 'p1', 'u1', $total, '2026-01-01', '$now', '$now');",
    );
  } finally {
    raw.close();
  }
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Bab 10.3 — Migrasi v2.2 -> v2.3 dan Ekspor/Impor JSON v5 (M-01..M-08)', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('planora_v23_mig_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('M-01, M-02, M-03: Migrasi aman, RD Saham nominal, idempotent', () async {
      final dbFile = File(p.join(tempDir.path, 'v22.sqlite'));
      _createV22SchemaAndSeed(dbFile);

      final db = AppDatabase(NativeDatabase(dbFile));
      addTearDown(db.close);

      final comps = await db.select(db.portfolioComponents).get();
      final stockTxs = await db.select(db.stockTransactions).get();
      final contribs = await db.select(db.contributions).get();

      final saham = comps.firstWhere((c) => c.id == 'c_saham');
      final rdSaham = comps.firstWhere((c) => c.id == 'c_rdsaham');
      final rdpu = comps.firstWhere((c) => c.id == 'c_rdpu');

      // M-01
      expect(saham.mechanism, StockLotCalc.mechanismLotBased);
      expect(saham.legacyOpeningAmount, 40000);
      expect(saham.actualAmount, 40000);
      expect(stockTxs, isEmpty);
      expect(contribs.fold<int>(0, (s, c) => s + c.amount), 200000);

      // M-02
      expect(rdSaham.mechanism, StockLotCalc.mechanismNominal);
      expect(rdSaham.legacyOpeningAmount, 0);
      expect(rdSaham.actualAmount, 60000);
      expect(rdpu.mechanism, StockLotCalc.mechanismNominal);
      expect(rdpu.legacyOpeningAmount, 0);
      expect(rdpu.actualAmount, 100000);

      // M-03: Jalankan migrasi kedua kalinya -> identik
      await db.migrateToV23LotMechanism();
      final comps2 = await db.select(db.portfolioComponents).get();
      final saham2 = comps2.firstWhere((c) => c.id == 'c_saham');
      expect(saham2.legacyOpeningAmount, 40000);
      expect(saham2.actualAmount, 40000);
      expect((await db.select(db.stockTransactions).get()), isEmpty);
    });

    test('M-04 & M-05: Rinci saldo awal penuh dan parsial menjaga total tetap Rp 40.000', () async {
      final dbFile = File(p.join(tempDir.path, 'v22_convert.sqlite'));
      _createV22SchemaAndSeed(dbFile);

      final db = AppDatabase(NativeDatabase(dbFile));
      addTearDown(db.close);
      final stockRepo = StockRepository(db);

      // M-05: Rinci parsial Rp 25.000 (1 lot @ Rp 250) dari Rp 40.000
      await stockRepo.convertLegacyOpeningToLot(
        componentId: 'c_saham',
        ticker: 'ADRO',
        lots: 1,
        pricePerShare: 250,
        transactionDate: DateTime(2026, 1, 10),
        now: DateTime(2026, 1, 15),
      );

      var saham = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == 'c_saham');
      expect(saham.legacyOpeningAmount, 15000);
      expect(saham.actualAmount, 40000);

      // M-04: Rinci sisa Rp 15.000 (1 lot @ Rp 150) -> legacy jadi 0, total tetap Rp 40.000
      await stockRepo.convertLegacyOpeningToLot(
        componentId: 'c_saham',
        ticker: 'BBCA',
        lots: 1,
        pricePerShare: 150,
        transactionDate: DateTime(2026, 1, 12),
        now: DateTime(2026, 1, 15),
      );

      saham = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == 'c_saham');
      final contribs = await db.select(db.contributions).get();
      expect(saham.legacyOpeningAmount, 0);
      expect(saham.actualAmount, 40000);
      expect(contribs.fold<int>(0, (s, c) => s + c.amount), 200000);
    });

    test('M-06: Ekspor JSON v2.3 (schema_version 5) lalu impor kembali identik', () async {
      final dbFile = File(p.join(tempDir.path, 'v23_roundtrip.sqlite'));
      _createV22SchemaAndSeed(dbFile);

      final db = AppDatabase(NativeDatabase(dbFile));
      addTearDown(db.close);
      final stockRepo = StockRepository(db);
      final settingsRepo = SettingsRepository(db);

      await stockRepo.buyStock(
        componentId: 'c_saham',
        ticker: 'ADRO',
        lots: 10,
        pricePerShare: 2000,
        transactionDate: DateTime(2026, 1, 10),
        now: DateTime(2026, 1, 15),
      );

      final exported = await settingsRepo.exportAllToJson();
      final decoded = jsonDecode(exported) as Map<String, dynamic>;
      expect(decoded['schema_version'], 7);
      expect((decoded['stock_transactions'] as List).length, 1);

      await settingsRepo.resetToEmpty();
      expect(await db.select(db.stockTransactions).get(), isEmpty);

      await settingsRepo.importAllFromJson(exported);
      final restoredTxs = await db.select(db.stockTransactions).get();
      final restoredSaham = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == 'c_saham');

      expect(restoredTxs.length, 1);
      expect(restoredTxs.single.ticker, 'ADRO');
      expect(restoredTxs.single.lots, 10);
      expect(restoredTxs.single.shares, 1000);
      expect(restoredTxs.single.totalAmount, 2000000);
      expect(restoredSaham.legacyOpeningAmount, 40000);
      expect(restoredSaham.actualAmount, 2040000);
    });

    test('M-07: Impor JSON v4 mengonversi Saham langsung ke legacy_opening_amount', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();
      final settingsRepo = SettingsRepository(db);

      final v4Json = jsonEncode({
        'app': 'planora',
        'schema_version': 4,
        'profile': {'id': 'u1'},
        'settings': {'onboarding_done': true},
        'portfolios': [
          {
            'id': 'p1',
            'name': 'Rumah',
            'category': 'cash',
            'saved_target': 100000000,
            'components': [
              {
                'id': 'c1',
                'instrument_type': 'Saham langsung',
                'target_percent': 20.0,
                'actual_amount': 40000,
              },
              {
                'id': 'c2',
                'instrument_type': 'RD Saham',
                'target_percent': 80.0,
                'actual_amount': 160000,
              },
            ],
            'contributions': [
              {'id': 'ct1', 'amount': 200000, 'date': '2026-01-01'},
            ],
          },
        ],
      });

      await settingsRepo.importAllFromJson(v4Json);
      final comps = await db.select(db.portfolioComponents).get();
      final saham = comps.firstWhere((c) => c.id == 'c1');
      final rdSaham = comps.firstWhere((c) => c.id == 'c2');

      expect(saham.mechanism, StockLotCalc.mechanismLotBased);
      expect(saham.legacyOpeningAmount, 40000);
      expect(saham.actualAmount, 40000);
      expect(rdSaham.mechanism, StockLotCalc.mechanismNominal);
      expect(rdSaham.legacyOpeningAmount, 0);
    });

    test('M-08: Migrasi dengan data rusak (actual negatif) dibatalkan & data lama utuh', () async {
      final dbFile = File(p.join(tempDir.path, 'v22_corrupt.sqlite'));
      _createV22SchemaAndSeed(dbFile, sahamActual: -5000);

      final db = AppDatabase(NativeDatabase(dbFile));
      addTearDown(db.close);

      await expectLater(
        () => db.select(db.portfolioComponents).get(),
        throwsA(isA<MigrationValidationException>()),
      );

      final raw = sqlite.sqlite3.open(dbFile.path);
      try {
        final ver = raw.select('PRAGMA user_version;').first['user_version'];
        expect(ver, 3);
      } finally {
        raw.close();
      }
    });
  });
}
