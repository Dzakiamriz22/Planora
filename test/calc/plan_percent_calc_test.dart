import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';

void main() {
  group('Bab 11.1 — Perhitungan Plan Berbasis Persentase v3.1', () {
    test('Contoh A: Rp 3.500.000 dengan 50/30/20 -> 1.750k / 1.050k / 700k', () {
      final res = PlanPercentCalc.computeAmountsFromPercents(
        totalAmount: 3500000,
        sharePercentX100ById: const {
          'rumah': 5000,
          'nikah': 3000,
          'darurat': 2000,
        },
      );
      expect(res['rumah'], 1750000);
      expect(res['nikah'], 1050000);
      expect(res['darurat'], 700000);
      expect(res.values.fold<int>(0, (s, v) => s + v), 3500000);
    });

    test('Contoh B: 33,33 / 33,33 / 33,34 dari Rp 3.500.000 -> jumlah tepat Rp 3.500.000', () {
      final res = PlanPercentCalc.computeAmountsFromPercents(
        totalAmount: 3500000,
        sharePercentX100ById: const {
          'a': 3333,
          'b': 3333,
          'c': 3334,
        },
      );
      expect(res['a'], 1166550);
      expect(res['b'], 1166550);
      expect(res['c'], 1166900);
      expect(res.values.fold<int>(0, (s, v) => s + v), 3500000);
    });

    test('Contoh D: ganti total jadi Rp 4.000.000 tanpa ubah persen -> 2jt / 1,2jt / 800k', () {
      final res = PlanPercentCalc.computeAmountsFromPercents(
        totalAmount: 4000000,
        sharePercentX100ById: const {
          'rumah': 5000,
          'nikah': 3000,
          'darurat': 2000,
        },
      );
      expect(res['rumah'], 2000000);
      expect(res['nikah'], 1200000);
      expect(res['darurat'], 800000);
    });

    test('Pas-kan ke 100% dari total 85% dan dari 112% sama-sama tepat 100%', () {
      final from85 = PlanPercentCalc.autoBalanceTo100(const {
        'a': 5000,
        'b': 3500,
      });
      expect(PlanPercentCalc.isExact100(from85.values), isTrue);
      expect(from85['a'], 6500);

      final from112 = PlanPercentCalc.autoBalanceTo100(const {
        'a': 7000,
        'b': 4200,
      });
      expect(PlanPercentCalc.isExact100(from112.values), isTrue);
      expect(from112['a'], 5800);
    });

    test('Mode Nominal: ketik nominal setara 40% tersimpan sebagai 4000 (40%)', () {
      final x100 = PlanPercentCalc.nominalMapToX100(
        totalAmount: 5000000,
        nominalById: const {'rumah': 2000000, 'darurat': 3000000},
      );
      expect(x100['rumah'], 4000);
      expect(x100['darurat'], 6000);
    });

    test('Validasi plafon, porto 0%, dan batas per porto dengan pesan berisi angka', () {
      final overCeiling = PlanPercentCalc.validateForApply(
        totalAmount: 4000000,
        sharePercentX100ById: const {'a': 10000, 'b': 0},
        portfolioNamesById: const {'a': 'Rumah', 'b': 'Liburan'},
        ceilingAmount: 3500000,
        planLimitEnabled: false,
        planLimitAmount: null,
      );
      expect(overCeiling.isValid, isFalse);
      expect(overCeiling.errorMessage, contains('4.000.000'));
      expect(overCeiling.errorMessage, contains('3.500.000'));

      final exactCeiling = PlanPercentCalc.validateForApply(
        totalAmount: 3500000,
        sharePercentX100ById: const {'a': 10000, 'b': 0},
        portfolioNamesById: const {'a': 'Rumah', 'b': 'Liburan'},
        ceilingAmount: 3500000,
        planLimitEnabled: false,
        planLimitAmount: null,
      );
      expect(exactCeiling.isValid, isTrue);
      expect(exactCeiling.derivedAmountsById['b'], 0);

      final overLimit = PlanPercentCalc.validateForApply(
        totalAmount: 3500000,
        sharePercentX100ById: const {'a': 5000, 'b': 5000},
        portfolioNamesById: const {'a': 'Rumah', 'b': 'Darurat'},
        ceilingAmount: 3500000,
        planLimitEnabled: true,
        planLimitAmount: 1500000,
      );
      expect(overLimit.isValid, isFalse);
      expect(overLimit.errorMessage, contains('Rumah'));
      expect(overLimit.errorMessage, contains('1.750.000'));
      expect(overLimit.errorMessage, contains('50%'));
      expect(overLimit.errorMessage, contains('1.500.000'));
    });

    test('Preset Seimbang, Fokus utama, dan Dua besar selalu berjumlah 100%', () {
      final ids = ['p1', 'p2', 'p3', 'p4'];
      expect(PlanPercentCalc.isExact100(PlanPercentCalc.presetBalanced(ids).values), isTrue);
      final focus = PlanPercentCalc.presetFocusPrimary(ids);
      expect(focus['p1'], 6000);
      expect(PlanPercentCalc.isExact100(focus.values), isTrue);
      final twoMajor = PlanPercentCalc.presetTwoMajor(ids);
      expect(twoMajor['p1'], 5000);
      expect(twoMajor['p2'], 3000);
      expect(PlanPercentCalc.isExact100(twoMajor.values), isTrue);
    });
  });
}
