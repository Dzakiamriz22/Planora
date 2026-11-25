import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';

void main() {
  group('Bab 11.1 — Unit Test Perhitungan v2.2 (U-01 s.d. U-14)', () {
    test('U-01: target_amount dari 20% x Rp 140.000.000 = Rp 28.000.000', () {
      expect(
        PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: 20,
          portfolioTargetTotal: 140000000,
        ),
        28000000,
      );
      expect(
        PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: 70,
          portfolioTargetTotal: 140000000,
        ),
        98000000,
      );
      expect(
        PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: 10,
          portfolioTargetTotal: 140000000,
        ),
        14000000,
      );
    });

    test('U-02: actual_percent Rp 280.000 dari total Rp 400.000 = 70%', () {
      expect(
        PlanoraV22Calc.actualPercent(
          actualAmount: 280000,
          totalActualPortfolio: 400000,
        ),
        70.0,
      );
    });

    test('U-03: actual_percent saat total aktual 0 = 0 tanpa NaN/divide-by-zero', () {
      final result = PlanoraV22Calc.actualPercent(
        actualAmount: 0,
        totalActualPortfolio: 0,
      );
      expect(result, 0.0);
      expect(result.isNaN, isFalse);
    });

    test('U-04: Konversi nominal Rp 28.000.000 / target Rp 140.000.000 = 20%', () {
      expect(
        PlanoraV22Calc.percentFromNominal(
          nominal: 28000000,
          portfolioTargetTotal: 140000000,
        ),
        20.0,
      );
    });

    test('U-05: Konversi nominal 1/3 menghasilkan 33,33%', () {
      expect(
        PlanoraV22Calc.percentFromNominal(
          nominal: 1000000,
          portfolioTargetTotal: 3000000,
        ),
        33.33,
      );
    });

    test('U-06: Auto-balance total 85%, komponen terakhir diubah X -> X naik 15 poin', () {
      final items = [
        const ComponentPercentItem(
          key: 'a',
          instrumentType: 'RDPU',
          targetPercent: 50,
        ),
        const ComponentPercentItem(
          key: 'b',
          instrumentType: 'RD Obligasi',
          targetPercent: 35,
        ),
      ];
      final res = PlanoraV22Calc.autoBalanceTo100(items, lastEditedKey: 'b');
      expect(res.firstWhere((e) => e.key == 'b').targetPercent, 50.0);
      expect(PlanoraV22Calc.isExact100(res.map((e) => e.targetPercent)), isTrue);
    });

    test('U-07: Auto-balance saat belum ada yang diubah -> komponen terbesar disesuaikan', () {
      final items = [
        const ComponentPercentItem(
          key: 'a',
          instrumentType: 'RDPU',
          targetPercent: 25,
        ),
        const ComponentPercentItem(
          key: 'b',
          instrumentType: 'RD Obligasi',
          targetPercent: 60,
        ),
      ];
      final res = PlanoraV22Calc.autoBalanceTo100(items);
      expect(res.firstWhere((e) => e.key == 'b').targetPercent, 75.0);
      expect(PlanoraV22Calc.isExact100(res.map((e) => e.targetPercent)), isTrue);
    });

    test('U-08: Validasi total 99,99% karena pembulatan -> tidak valid, auto-balance memperbaiki', () {
      final percents = [33.33, 33.33, 33.33];
      expect(PlanoraV22Calc.isExact100(percents), isFalse);
      final fixed = PlanoraV22Calc.autoBalanceTo100(
        [
          const ComponentPercentItem(key: '1', instrumentType: 'A', targetPercent: 33.33),
          const ComponentPercentItem(key: '2', instrumentType: 'B', targetPercent: 33.33),
          const ComponentPercentItem(key: '3', instrumentType: 'C', targetPercent: 33.33),
        ],
        lastEditedKey: '3',
      );
      expect(fixed.last.targetPercent, 33.34);
      expect(PlanoraV22Calc.isExact100(fixed.map((e) => e.targetPercent)), isTrue);
    });

    test('U-09: Proyeksi sisa Rp 9.000.000, laju Rp 1.500.000/bln = 6 bulan dari bulan berjalan', () {
      final now = DateTime(2026, 11, 25);
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 1000000,
        hasAnyDeposit: true,
        targetDate: DateTime(2027, 6, 30),
        averageRate3m: 1500000,
        now: now,
      );
      expect(proj.monthsNeeded, 6);
      expect(proj.projectedDate, DateTime(2027, 5, 1));
      expect(proj.status, PortfolioTrackStatusV22.onTrack);
    });

    test('U-10: Status tanpa tanggal target tidak pernah Off Track', () {
      final now = DateTime(2026, 11, 25);
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 140000000,
        actualBalance: 400000,
        hasAnyDeposit: true,
        targetDate: null,
        averageRate3m: 0,
        now: now,
      );
      expect(proj.status, PortfolioTrackStatusV22.onTrack);
    });

    test('U-11: Status proyeksi melewati tanggal target -> Off Track', () {
      final now = DateTime(2026, 11, 25);
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 1000000,
        hasAnyDeposit: true,
        targetDate: DateTime(2027, 1, 31), // 2 bulan lagi
        averageRate3m: 500000, // butuh 18 bulan
        now: now,
      );
      expect(proj.status, PortfolioTrackStatusV22.offTrack);
      expect(proj.monthlyGapToOnTrack, greaterThan(0));
    });

    test('U-12: Status saldo >= target -> Tercapai', () {
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 10500000,
        hasAnyDeposit: true,
        targetDate: DateTime(2027, 1, 31),
        averageRate3m: 0,
        now: DateTime(2026, 11, 25),
      );
      expect(proj.status, PortfolioTrackStatusV22.achieved);
    });

    test('U-13: Pemilihan quote hari-dalam-tahun 25 -> indeks 1 (25 mod 24)', () {
      final jan25 = DateTime(2026, 1, 25);
      expect(PlanoraV22Calc.dailyQuoteIndex(jan25), 1);
      expect(PlanoraV22Calc.neutralQuotes.length, 24);
    });

    test('U-14: Streak 3 bulan berurutan lalu 1 bulan kosong berhenti di bulan kosong', () {
      final now = DateTime(2026, 11, 25);
      final streak = PlanoraV22Calc.calculateMonthlyStreak(
        depositDates: [
          DateTime(2026, 11, 5),
          DateTime(2026, 10, 10),
          DateTime(2026, 9, 12),
          // Agustus kosong!
          DateTime(2026, 7, 15),
        ],
        now: now,
      );
      expect(streak, 3);
    });
  });

  group('Bab 11.4 — Skenario Angka Ujung ke Ujung', () {
    test('Skenario 1: Uji Rumah 20/70/10 saldo 400k -> setoran 600k ke Pasar Uang -> 68% + insight deviasi', () {
      final now = DateTime(2026, 11, 25);
      // Awal: 80k / 280k / 40k (total 400k -> 20% / 70% / 10%)
      expect(
        PlanoraV22Calc.actualPercent(actualAmount: 80000, totalActualPortfolio: 400000),
        20.0,
      );
      expect(
        PlanoraV22Calc.actualPercent(actualAmount: 280000, totalActualPortfolio: 400000),
        70.0,
      );
      expect(
        PlanoraV22Calc.actualPercent(actualAmount: 40000, totalActualPortfolio: 400000),
        10.0,
      );
      // Persen tercapai: 400.000 / 140.000.000 = 0.29%
      expect(
        PlanoraV22Calc.round2((400000 / 140000000) * 100),
        0.29,
      );

      // Tambah setoran 600.000 ke Pasar Uang -> Pasar Uang = 680.000 / 1.000.000 = 68%
      final rdpuAfter = PlanoraV22Calc.actualPercent(
        actualAmount: 680000,
        totalActualPortfolio: 1000000,
      );
      expect(rdpuAfter, 68.0);

      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 140000000,
        actualBalance: 1000000,
        hasAnyDeposit: true,
        targetDate: null,
        averageRate3m: 333333,
        now: now,
      );
      expect(proj.status, PortfolioTrackStatusV22.onTrack);

      final insights = PlanoraV22Calc.generateInsights(
        portfolios: [
          (
            id: 'uji-rumah',
            name: 'Uji Rumah',
            balance: 1000000,
            targetTotal: 140000000,
            progressPct: 0.71,
            projection: proj,
            components: const [
              (instrument: 'RDPU', targetPct: 20.0, actualAmount: 680000),
              (instrument: 'RD Obligasi', targetPct: 70.0, actualAmount: 280000),
              (instrument: 'Saham langsung', targetPct: 10.0, actualAmount: 40000),
            ],
          ),
        ],
        hasDepositThisMonth: true,
        activePhaseName: null,
        activePhaseTotal: 0,
        streakMonths: 1,
        now: now,
        formatRupiah: AppFormatters.rupiah,
      );

      expect(
        insights.any((i) => i.kind == DashboardInsightKind.allocationDeviation),
        isTrue,
      );
    });

    test('Skenario 2: Target 10 jt, 100% RDPU, saldo 750k, target 2 bln lagi, laju 0 -> Off Track + pesan laju kosong', () {
      final now = DateTime(2026, 11, 25);
      final proj = PlanoraV22Calc.evaluateStatusAndProjection(
        targetTotal: 10000000,
        actualBalance: 750000,
        hasAnyDeposit: true,
        targetDate: DateTime(2027, 1, 25),
        averageRate3m: 0,
        now: now,
      );
      expect(PlanoraV22Calc.round2((750000 / 10000000) * 100), 7.5);
      expect(proj.status, PortfolioTrackStatusV22.offTrack);
      expect(proj.projectedDate, isNull);
      expect(proj.rateEmptyMessage, contains('3 bulan terakhir'));
    });
  });
}
