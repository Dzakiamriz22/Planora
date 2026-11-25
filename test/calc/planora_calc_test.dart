import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/planora_calc.dart';

void main() {
  // Fixture uji sesuai DS-PLN-2026-001 Lampiran L.2 (hanya hidup di test, bukan seed).
  final refNow = DateTime(2026, 11, 25);
  final targetOkt2033 = DateTime(2033, 10, 31);

  group('Lampiran L.2 — 10 Skenario Uji Angka (v2.1 FINAL)', () {
    test('1. Plafon dari gaji Rp 4.500.000 dan biaya hidup minimum Rp 1.000.000', () {
      expect(
        PlanoraCalc.ceiling(
          monthlySalary: 4500000,
          minimumLivingCost: 1000000,
        ),
        3500000,
      );
      // Plafon NULL bila salah satu NULL (FR-05)
      expect(
        PlanoraCalc.ceiling(monthlySalary: null, minimumLivingCost: 1000000),
        isNull,
      );
    });

    test('2. Porto tunai: target Rp 150 jt, saldo Rp 0, target Okt 2033, return 5%', () {
      final res = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 150000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 5.0,
        now: refNow,
      );
      expect(res.isAchieved, isFalse);
      expect(res.amount, closeTo(1516468, 1000));
    });

    test('3. Porto DP + biaya: target ditabung Rp 140 jt, saldo Rp 0, Okt 2033, return 5%', () {
      final res = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 140000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 5.0,
        now: refNow,
      );
      expect(res.amount, closeTo(1416000, 1000));
    });

    test('4. Porto DP + biaya: target ditabung Rp 55 jt, saldo Rp 0, Okt 2033, return 5%', () {
      final res = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 55000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 5.0,
        now: refNow,
      );
      expect(res.amount, closeTo(556000, 1000));
    });

    test('5. Gabungan skenario 2 + 3 + 4 + satu porto tanpa target Rp 1.000.000/bln melebihi plafon', () {
      final p2 = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 150000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 5.0,
        now: refNow,
      ).amount;
      final p3 = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 140000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 5.0,
        now: refNow,
      ).amount;
      final p4 = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 55000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 5.0,
        now: refNow,
      ).amount;
      final total = p2 + p3 + p4 + 1000000;

      expect(total, greaterThan(3500000));
      expect(
        PlanoraCalc.isWithinCeiling(totalPlan: total, ceilingAmount: 3500000),
        isFalse,
      );
    });

    test('6. Porto bersaldo Rp 750.000 dari setoran, target Rp 10.000.000 -> sisa Rp 9.250.000', () {
      expect(
        PlanoraCalc.remainingNeed(savedTarget: 10000000, balance: 750000),
        9250000,
      );
    });

    test('7. Gaji diubah menjadi Rp 5.000.000 -> plafon menjadi Rp 4.000.000', () {
      expect(
        PlanoraCalc.ceiling(
          monthlySalary: 5000000,
          minimumLivingCost: 1000000,
        ),
        4000000,
      );
    });

    test('8. Return 0% pada skenario 2 -> perlu per bulan = sisa / jumlah bulan (linear)', () {
      final n = PlanoraCalc.monthsRemaining(refNow, targetOkt2033);
      final res = PlanoraCalc.requiredMonthlyDeposit(
        savedTarget: 150000000,
        balance: 0,
        targetDate: targetOkt2033,
        annualReturnPct: 0.0,
        now: refNow,
      );
      expect(res.amount, (150000000 / n).round());
    });

    test('9. Fase seimbang: plafon Rp 3.500.000, 4 porto -> Rp 875.000/porto, total tepat Rp 3.500.000', () {
      final allocs = PlanoraCalc.balancedPhaseAllocations(
        portfolioIds: const ['p1', 'p2', 'p3', 'p4'],
        ceilingAmount: 3500000,
      );
      expect(allocs['p1'], 875000);
      expect(allocs['p2'], 875000);
      expect(allocs['p3'], 875000);
      expect(allocs['p4'], 875000);
      expect(allocs.values.fold<int>(0, (a, b) => a + b), 3500000);
    });

    test('10. Ilustrasi cicilan: sisa kredit Rp 360.000.000, tenor 240 bulan, bunga 0% -> Rp 1.500.000/bln', () {
      final installment = PlanoraCalc.annuityInstallment(
        principal: 360000000,
        tenorMonths: 240,
        annualInterestPct: 0.0,
      );
      expect(installment, 1500000);
    });
  });

  group('Kasus tepi mesin hitung v2.1', () {
    test('Komponen summary menghitung total komponen dan sisa belum dirinci', () {
      final ok = PlanoraCalc.componentsSummary(
        balance: 5000000,
        componentAmounts: const [2000000, 1500000, 500000],
      );
      expect(ok.totalComponents, 4000000);
      expect(ok.unallocated, 1000000);
      expect(ok.isValid, isTrue);

      final invalid = PlanoraCalc.componentsSummary(
        balance: 3000000,
        componentAmounts: const [2000000, 1500000],
      );
      expect(invalid.isValid, isFalse);
    });

    test('Validasi batas per porto opsional berlaku untuk semua porto saat aktif', () {
      const inputs = [
        PhaseAllocationInput(
          portfolioId: 'p1',
          portfolioName: 'Porto A',
          monthlyAmount: 950000,
        ),
      ];

      final whenOff = PlanoraCalc.validatePhaseAllocations(
        allocations: inputs,
        ceilingAmount: 3500000,
        phaseLimitEnabled: false,
      );
      expect(whenOff.isValid, isTrue);

      final whenOn = PlanoraCalc.validatePhaseAllocations(
        allocations: inputs,
        ceilingAmount: 3500000,
        phaseLimitEnabled: true,
        phaseLimitAmount: 900000,
      );
      expect(whenOn.isValid, isFalse);
      expect(whenOn.errorMessage, contains('Porto A'));
    });

    test('Penyeimbangan proporsional menjaga total <= plafon tanpa nilai negatif', () {
      const items = [
        RebalanceItem(id: 'a', name: 'A', currentAmount: 1000000),
        RebalanceItem(id: 'b', name: 'B', currentAmount: 1500000),
        RebalanceItem(id: 'c', name: 'C', currentAmount: 500000),
      ];
      final res = PlanoraCalc.rebalanceProportionally(
        items: items,
        editedId: 'c',
        newEditedAmount: 1500000,
        ceilingAmount: 3500000,
      );
      expect(res.success, isTrue);
      expect(res.needsRebalance, isTrue);
      final map = {for (final i in items) i.id: i.currentAmount};
      for (final ch in res.changes) {
        expect(ch.newAmount, greaterThanOrEqualTo(0));
        map[ch.id] = ch.newAmount;
      }
      expect(map.values.fold<int>(0, (a, b) => a + b), lessThanOrEqualTo(3500000));
    });
  });
}
