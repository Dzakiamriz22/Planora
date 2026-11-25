import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/profile_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';

void main() {
  group('Bab 11.2 — Unit Test Migrasi v2.2 (M-01 s.d. M-05)', () {
    late AppDatabase db;
    late PortfolioRepository portfolioRepo;
    late SettingsRepository settingsRepo;
    late ProfileRepository profileRepo;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      await db.ensureInitialized(now: DateTime(2026, 11, 25));
      portfolioRepo = PortfolioRepository(db);
      settingsRepo = SettingsRepository(db);
      profileRepo = ProfileRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('M-01: Porto v2.1 komponen 80.000 / 280.000 / 40.000 -> persen tepat 100%', () {
      final percents = PlanoraV22Calc.migrateAmountsToPercents(
        amounts: [80000, 280000, 40000],
        portfolioTotalTarget: 140000000,
      );
      expect(percents, [20.0, 70.0, 10.0]);
      expect(PlanoraV22Calc.isExact100(percents), isTrue);

      // Uji kasus pembulatan ganjil (1/3, 1/3, 1/3) -> terbesar mendapat koreksi 0.01
      final uneven = PlanoraV22Calc.migrateAmountsToPercents(
        amounts: [100000, 100000, 100000],
        portfolioTotalTarget: 300000,
      );
      expect(PlanoraV22Calc.isExact100(uneven), isTrue);
    });

    test('M-02: Porto satu komponen v2.1 -> 100%', () {
      final percents = PlanoraV22Calc.migrateAmountsToPercents(
        amounts: [750000],
        portfolioTotalTarget: 10000000,
      );
      expect(percents, [100.0]);
    });

    test('M-03: Impor JSON v2/v3 terkonversi ke model v2.2 dan data lain utuh', () async {
      final v2Backup = jsonEncode({
        'app': 'planora',
        'schema_version': 2,
        'profile': {'id': 'prof-v2', 'display_name': 'Sinta'},
        'settings': {
          'monthly_salary': 6000000,
          'minimum_living_cost': 2000000,
          'default_annual_return_pct': 5.0,
          'onboarding_done': true,
        },
        'portfolios': [
          {
            'id': 'p-rumah',
            'name': 'Rumah',
            'category': 'down_payment',
            'platform_preset': 'aperd',
            'platform_name': 'Reksa Dana',
            'full_price': 500000000,
            'saved_target': 140000000,
            'monthly_plan': 1000000,
            'annual_return_pct': 5.0,
            'components': [
              {'id': 'c1', 'instrument_type': 'RDPU', 'amount': 80000},
              {'id': 'c2', 'instrument_type': 'RD Obligasi', 'amount': 280000},
              {'id': 'c3', 'instrument_type': 'Saham langsung', 'amount': 40000},
            ],
            'contributions': [
              {'id': 'd1', 'amount': 400000, 'date': '2026-11-01'},
            ],
          },
        ],
        'phases': [],
        'phase_allocations': [],
        'price_references': [],
      });

      await settingsRepo.importAllFromJson(v2Backup);
      expect((await profileRepo.getProfile()).displayName, 'Sinta');
      final comps = await db.select(db.portfolioComponents).get();
      expect(comps.length, 3);
      expect(
        PlanoraV22Calc.isExact100(comps.map((c) => c.targetPercent)),
        isTrue,
      );
      expect(
        comps.firstWhere((c) => c.instrumentType == 'RD Obligasi').targetPercent,
        70.0,
      );
      expect(
        comps.firstWhere((c) => c.instrumentType == 'RD Obligasi').actualAmount,
        280000,
      );
    });

    test('M-04: Ekspor v2.2 (schema_version: 4) lalu reset lalu impor -> identik', () async {
      await settingsRepo.updateComponentInputMode('nominal');
      await settingsRepo.dismissQuoteForMonth('2026-11');

      final pid = await portfolioRepo.createPortfolio(
        name: 'Uji Rumah',
        category: 'down_payment',
        platformPreset: 'aperd',
        platformName: 'Tempat Uji',
        fullPrice: 500000000,
        savedTarget: 140000000,
        monthlyPlan: 1000000,
        annualReturnPct: 5.0,
        icon: 'home',
        color: 0xFF2F6DB3,
        initialComponents: const [
          ComponentDraft(instrumentType: 'RDPU', targetPercent: 20),
          ComponentDraft(instrumentType: 'RD Obligasi', targetPercent: 70),
          ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 10),
        ],
      );

      final compsBefore = await (db.select(db.portfolioComponents)
            ..where((t) => t.portfolioId.equals(pid)))
          .get();
      final rdpuId = compsBefore.firstWhere((c) => c.instrumentType == 'RDPU').id;
      await portfolioRepo.addContribution(
        portfolioId: pid,
        amount: 80000,
        dateIso: '2026-11-25',
        componentId: rdpuId,
      );

      final exported = await settingsRepo.exportAllToJson();
      final decoded = jsonDecode(exported) as Map<String, dynamic>;
      expect(decoded['schema_version'], 4);
      final exportedComps =
          (decoded['portfolios'] as List).first['components'] as List;
      expect(exportedComps.first['target_percent'], 20.0);
      expect(exportedComps.first['target_amount_calculated'], 28000000);
      expect(exportedComps.first.containsKey('target_amount'), isFalse);

      await settingsRepo.resetToEmpty();
      expect(await db.select(db.portfolios).get(), isEmpty);

      await settingsRepo.importAllFromJson(exported);
      final restoredSettings = await settingsRepo.getSettings();
      expect(restoredSettings.componentInputMode, 'nominal');
      expect(restoredSettings.quoteCardDismissedMonth, '2026-11');

      final restoredComps = await db.select(db.portfolioComponents).get();
      expect(restoredComps.length, 3);
      expect(
        restoredComps.firstWhere((c) => c.instrumentType == 'RDPU').actualAmount,
        80000,
      );
      expect(
        PlanoraV22Calc.isExact100(restoredComps.map((c) => c.targetPercent)),
        isTrue,
      );
    });

    test('M-05: Migrasi dengan data rusak (total target 0) dibatalkan & data lama utuh', () async {
      // Seed 1 porto lama yang sah dulu
      await portfolioRepo.createPortfolio(
        name: 'Porto Aman',
        category: 'cash',
        savedTarget: 5000000,
        monthlyPlan: 500000,
        annualReturnPct: 5.0,
        icon: 'savings',
        color: 0xFF0E7C66,
      );

      // 1. Uji langsung fungsi migrasi
      expect(
        () => PlanoraV22Calc.migrateAmountsToPercents(
          amounts: [80000, 280000],
          portfolioTotalTarget: 0,
        ),
        throwsA(isA<MigrationValidationException>()),
      );

      // 2. Uji impor JSON v2 dengan komponen rusak (amount 0 & saved_target 0) -> transaksi batal, Porto Aman utuh!
      final corruptV2 = jsonEncode({
        'app': 'planora',
        'schema_version': 2,
        'portfolios': [
          {
            'id': 'p-bad',
            'name': 'Rusak',
            'category': 'cash',
            'saved_target': 0,
            'monthly_plan': 0,
            'components': [
              {'id': 'c1', 'instrument_type': 'RDPU', 'amount': 0},
              {'id': 'c2', 'instrument_type': 'Emas', 'amount': 0},
            ],
          },
        ],
      });

      await expectLater(
        () => settingsRepo.importAllFromJson(corruptV2),
        throwsA(isA<MigrationValidationException>()),
      );

      final stillThere = await portfolioRepo.getAllPortfolios();
      expect(stillThere.length, 1);
      expect(stillThere.first.name, 'Porto Aman');
    });
  });
}
