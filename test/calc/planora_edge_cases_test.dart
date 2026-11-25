import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';

void main() {
  group('Edge cases — Perhitungan Persen, Auto-Balance & Auto-Split', () {
    test('round2 menangani NaN, Infinity, dan angka negatif dengan aman', () {
      expect(PlanoraV22Calc.round2(double.nan), 0.0);
      expect(PlanoraV22Calc.round2(double.infinity), 0.0);
      expect(PlanoraV22Calc.round2(double.negativeInfinity), 0.0);
      expect(PlanoraV22Calc.round2(33.335), 33.34);
    });

    test('targetAmountFromPercent & percentFromNominal saat target 0 atau negatif', () {
      expect(
        PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: 50,
          portfolioTargetTotal: 0,
        ),
        0,
      );
      expect(
        PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: -10,
          portfolioTargetTotal: 10000000,
        ),
        0,
      );
      expect(
        PlanoraV22Calc.percentFromNominal(
          nominal: 500000,
          portfolioTargetTotal: 0,
        ),
        0.0,
      );
      expect(
        PlanoraV22Calc.percentFromNominal(
          nominal: -500000,
          portfolioTargetTotal: 10000000,
        ),
        0.0,
      );
    });

    test('autoBalanceTo100 pada daftar kosong, 1 item, dan total melebihi 100% (140%)', () {
      expect(PlanoraV22Calc.autoBalanceTo100(const []), isEmpty);

      final single = PlanoraV22Calc.autoBalanceTo100(const [
        ComponentPercentItem(key: 'a', instrumentType: 'RDPU', targetPercent: 12),
      ]);
      expect(single.first.targetPercent, 100.0);

      // Total 140% dengan lastEditedKey kecil (20%) -> memotong ke 0 lalu lanjut ke komponen terbesar
      final over = PlanoraV22Calc.autoBalanceTo100(
        const [
          ComponentPercentItem(key: 'a', instrumentType: 'RDPU', targetPercent: 20),
          ComponentPercentItem(key: 'b', instrumentType: 'Obligasi', targetPercent: 70),
          ComponentPercentItem(key: 'c', instrumentType: 'Saham', targetPercent: 50),
        ],
        lastEditedKey: 'a',
      );
      expect(over.every((e) => e.targetPercent >= 0), isTrue);
      expect(PlanoraV22Calc.isExact100(over.map((e) => e.targetPercent)), isTrue);
    });

    test('splitDepositByTargetPercent pada nominal Rp 1, Rp 3, negatif (hapus), dan kosong', () {
      expect(
        PlanoraV22Calc.splitDepositByTargetPercent(
          depositAmount: 0,
          components: const [(id: 'a', targetPercent: 100)],
        ),
        isEmpty,
      );
      expect(
        PlanoraV22Calc.splitDepositByTargetPercent(
          depositAmount: 500000,
          components: const [],
        ),
        isEmpty,
      );

      // Rp 1 pada 50/50 -> masuk ke salah satu, total tepat Rp 1
      final oneRp = PlanoraV22Calc.splitDepositByTargetPercent(
        depositAmount: 1,
        components: const [
          (id: 'a', targetPercent: 50),
          (id: 'b', targetPercent: 50),
        ],
      );
      expect(oneRp.values.fold<int>(0, (s, v) => s + v), 1);

      // Delta negatif (pengurangan saat hapus setoran) -> jumlah persis -500.000
      final neg = PlanoraV22Calc.splitDepositByTargetPercent(
        depositAmount: -500000,
        components: const [
          (id: 'a', targetPercent: 20),
          (id: 'b', targetPercent: 70),
          (id: 'c', targetPercent: 10),
        ],
      );
      expect(neg['a'], -100000);
      expect(neg['b'], -350000);
      expect(neg['c'], -50000);
    });
  });

  group('Edge cases — Status, Streak, Deret Saldo & Insight', () {
    test('Status: Belum Mulai saat belum ada setoran & saldo 0', () {
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 0,
        hasAnyDeposit: false,
        targetDate: DateTime(2028, 12, 31),
        averageRate3m: 0,
        now: DateTime(2026, 11, 25),
      );
      expect(proj.status, PortfolioTrackStatusV22.notStarted);
    });

    test('Status: targetDate sudah lewat di masa lalu -> Off Track', () {
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 2000000,
        hasAnyDeposit: true,
        targetDate: DateTime(2026, 5, 1),
        averageRate3m: 500000,
        now: DateTime(2026, 11, 25),
      );
      expect(proj.status, PortfolioTrackStatusV22.offTrack);
    });

    test('Streak: lintas pergantian tahun (Des -> Jan) dan beberapa setoran di bulan sama', () {
      final streak = PlanoraV22Calc.calculateMonthlyStreak(
        depositDates: [
          DateTime(2026, 2, 1),
          DateTime(2026, 2, 15), // bulan sama tidak dihitung ganda
          DateTime(2026, 1, 10),
          DateTime(2025, 12, 20),
          DateTime(2025, 11, 5),
        ],
        now: DateTime(2026, 2, 25),
      );
      expect(streak, 4);

      // Bulan berjalan belum setor, tapi bulan lalu ada streak -> masih terhitung
      final streakPrev = PlanoraV22Calc.calculateMonthlyStreak(
        depositDates: [
          DateTime(2026, 10, 5),
          DateTime(2026, 9, 5),
        ],
        now: DateTime(2026, 11, 3),
      );
      expect(streakPrev, 2);
    });

    test('buildMonthlyBalanceSeries: setoran lama terakumulasi & setoran masa depan diabaikan', () {
      final series = PlanoraV22Calc.buildMonthlyBalanceSeries(
        deposits: [
          (date: DateTime(2025, 1, 10), amount: 5000000), // sebelum 6 bln
          (date: DateTime(2026, 11, 5), amount: 1000000), // bulan berjalan
          (date: DateTime(2027, 3, 1), amount: 9000000), // masa depan
        ],
        months: 6,
        now: DateTime(2026, 11, 25),
      );
      expect(series.length, 6);
      expect(series.first.cumulativeBalance, 5000000);
      expect(series.last.cumulativeBalance, 6000000);
    });

    test('generateInsights: maksimal 3 kartu & prioritas Off Track selalu di urutan pertama', () {
      final now = DateTime(2026, 11, 20); // > tanggal 10
      final offProj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 5000000,
        hasAnyDeposit: true,
        targetDate: DateTime(2026, 12, 31),
        averageRate3m: 500000,
        now: now,
      );
      final insights = PlanoraV22Calc.generateInsights(
        portfolios: [
          (
            id: 'p1',
            name: 'Target A',
            balance: 5000000,
            targetTotal: 10000000,
            progressPct: 50.0,
            projection: offProj,
            components: const [
              (instrument: 'RDPU', targetPct: 20, actualAmount: 4500000),
              (instrument: 'Emas', targetPct: 80, actualAmount: 500000),
            ],
          ),
        ],
        hasDepositThisMonth: false,
        activePhaseName: 'Fase 1',
        activePhaseTotal: 2000000,
        streakMonths: 4,
        now: now,
        formatRupiah: AppFormatters.rupiah,
      );
      expect(insights.length, 3);
      expect(insights[0].kind, DashboardInsightKind.offTrack);
      expect(insights[1].kind, DashboardInsightKind.noDepositAfterDay10);
    });
  });

  group('Edge cases — Migrasi & Impor JSON Tidak Valid', () {
    late AppDatabase db;
    late PortfolioRepository portfolioRepo;
    late SettingsRepository settingsRepo;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      await db.ensureInitialized(now: DateTime(2026, 11, 25));
      portfolioRepo = PortfolioRepository(db);
      settingsRepo = SettingsRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Impor JSON rusak atau bukan milik Planora ditolak & data lama utuh', () async {
      await portfolioRepo.createPortfolio(
        name: 'Dana Tetap Aman',
        category: 'cash',
        savedTarget: 10000000,
        monthlyPlan: 500000,
        annualReturnPct: 5.0,
        icon: 'shield',
        color: 0xFF0E7C66,
      );

      await expectLater(
        () => settingsRepo.importAllFromJson('not valid json {{{'),
        throwsA(isA<FormatException>()),
      );
      await expectLater(
        () => settingsRepo.importAllFromJson(jsonEncode({'app': 'other_app'})),
        throwsA(isA<FormatException>()),
      );

      // JSON v4 dengan total persen komponen != 100% ditolak, data lama utuh
      final badV4 = jsonEncode({
        'app': 'planora',
        'schema_version': 4,
        'portfolios': [
          {
            'id': 'p-x',
            'name': 'Porto Tidak Pas',
            'category': 'cash',
            'saved_target': 10000000,
            'monthly_plan': 0,
            'components': [
              {'id': 'c1', 'instrument_type': 'RDPU', 'target_percent': 60, 'actual_amount': 0},
              {'id': 'c2', 'instrument_type': 'Emas', 'target_percent': 25, 'actual_amount': 0},
            ],
          },
        ],
      });
      await expectLater(
        () => settingsRepo.importAllFromJson(badV4),
        throwsA(isA<MigrationValidationException>()),
      );

      final all = await portfolioRepo.getAllPortfolios();
      expect(all.length, 1);
      expect(all.first.name, 'Dana Tetap Aman');
    });

    test('migrateAmountsToPercents menolak komponen negatif', () {
      expect(
        () => PlanoraV22Calc.migrateAmountsToPercents(
          amounts: [-10000, 50000],
          portfolioTotalTarget: 100000,
        ),
        throwsA(isA<MigrationValidationException>()),
      );
    });
  });
}
