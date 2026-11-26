import 'dart:math' as math;

import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';

class PlanValidationResult {
  const PlanValidationResult({
    required this.isValid,
    required this.totalX100,
    required this.derivedAmountsById,
    this.errorMessage,
  });

  final bool isValid;
  final int totalX100;
  final Map<String, int> derivedAmountsById;
  final String? errorMessage;

  bool get isDraft => totalX100 != PlanPercentCalc.exact100X100;
}

class PlanPercentCalc {
  PlanPercentCalc._();

  static const int exact100X100 = 10000;

  static int percentToX100(double percent) {
    if (percent.isNaN || percent.isInfinite) return 0;
    final clamped = PlanoraV22Calc.round2(percent.clamp(0.0, 100.0));
    return (clamped * 100).round();
  }

  static double x100ToPercent(int x100) => x100 / 100.0;

  static String formatX100(int x100) {
    final pct = x100 / 100.0;
    if (x100 % 100 == 0) {
      return '${x100 ~/ 100}%';
    }
    if (x100 % 10 == 0) {
      return '${pct.toStringAsFixed(1).replaceAll('.', ',')}%';
    }
    return '${pct.toStringAsFixed(2).replaceAll('.', ',')}%';
  }

  static int totalX100(Iterable<int> values) {
    var sum = 0;
    for (final v in values) {
      sum += v;
    }
    return sum;
  }

  static bool isExact100(Iterable<int> values) {
    return totalX100(values) == exact100X100;
  }

  static Map<String, int> computeAmountsFromPercents({
    required int totalAmount,
    required Map<String, int> sharePercentX100ById,
  }) {
    if (sharePercentX100ById.isEmpty) return const {};
    if (totalAmount <= 0) {
      return {for (final k in sharePercentX100ById.keys) k: 0};
    }

    final result = <String, int>{};
    var sumAllocated = 0;
    String? largestId;
    var largestAmt = -1;
    var largestX100 = -1;

    for (final entry in sharePercentX100ById.entries) {
      final x100 = math.max(0, entry.value);
      final amt = ((totalAmount * x100) / exact100X100).round();
      result[entry.key] = amt;
      sumAllocated += amt;
      if (amt > largestAmt || (amt == largestAmt && x100 > largestX100)) {
        largestAmt = amt;
        largestX100 = x100;
        largestId = entry.key;
      }
    }

    if (isExact100(sharePercentX100ById.values) && largestId != null) {
      final diff = totalAmount - sumAllocated;
      if (diff != 0) {
        result[largestId] = math.max(0, (result[largestId] ?? 0) + diff);
      }
    }

    return result;
  }

  static ({
    int totalAmount,
    Map<String, int> sharePercentX100ById,
  }) migrateNominalAmountsToPlanPercents(Map<String, int> amountsById) {
    if (amountsById.isEmpty) {
      return (totalAmount: 0, sharePercentX100ById: const {});
    }
    var total = 0;
    for (final amt in amountsById.values) {
      if (amt < 0) {
        throw MigrationValidationException(
          'Migrasi Plan dibatalkan: ditemukan alokasi negatif ($amt).',
        );
      }
      total += amt;
    }

    if (total == 0) {
      return (
        totalAmount: 0,
        sharePercentX100ById: {for (final k in amountsById.keys) k: 0},
      );
    }

    final percents = <String, int>{};
    String largestId = amountsById.keys.first;
    var largestAmt = -1;
    var sumX100 = 0;

    for (final entry in amountsById.entries) {
      if (entry.value > largestAmt) {
        largestAmt = entry.value;
        largestId = entry.key;
      }
      final x100 = ((entry.value / total) * exact100X100).round();
      percents[entry.key] = x100;
      sumX100 += x100;
    }

    final diffX100 = exact100X100 - sumX100;
    if (diffX100 != 0) {
      percents[largestId] = math.max(0, (percents[largestId] ?? 0) + diffX100);
    }

    if (!isExact100(percents.values)) {
      throw MigrationValidationException(
        'Migrasi Plan dibatalkan: hasil konversi persen tidak tepat 100%.',
      );
    }

    final recomputed = computeAmountsFromPercents(
      totalAmount: total,
      sharePercentX100ById: percents,
    );
    final recomputedTotal = recomputed.values.fold<int>(0, (s, v) => s + v);
    if (recomputedTotal != total) {
      throw MigrationValidationException(
        'Migrasi Plan dibatalkan: jumlah nominal hitung ulang ($recomputedTotal) tidak sama dengan total lama ($total).',
      );
    }

    return (totalAmount: total, sharePercentX100ById: percents);
  }

  static Map<String, int> autoBalanceTo100(Map<String, int> currentX100) {
    if (currentX100.isEmpty) return const {};
    if (currentX100.length == 1) {
      return {currentX100.keys.first: exact100X100};
    }

    final out = <String, int>{
      for (final e in currentX100.entries) e.key: math.max(0, e.value),
    };
    final currentTotal = totalX100(out.values);
    final diff = exact100X100 - currentTotal;
    if (diff == 0) return out;

    final sortedKeys = out.keys.toList()
      ..sort((a, b) => (out[b] ?? 0).compareTo(out[a] ?? 0));

    if (diff > 0) {
      final target = sortedKeys.first;
      out[target] = (out[target] ?? 0) + diff;
      return out;
    }

    var remainingCut = -diff;
    for (final key in sortedKeys) {
      if (remainingCut <= 0) break;
      final avail = out[key] ?? 0;
      final cut = math.min(avail, remainingCut);
      out[key] = avail - cut;
      remainingCut -= cut;
    }
    return out;
  }

  static Map<String, int> presetBalanced(List<String> portfolioIds) {
    if (portfolioIds.isEmpty) return const {};
    final base = exact100X100 ~/ portfolioIds.length;
    final rem = exact100X100 - (base * portfolioIds.length);
    final out = <String, int>{};
    for (var i = 0; i < portfolioIds.length; i++) {
      out[portfolioIds[i]] = base + (i == portfolioIds.length - 1 ? rem : 0);
    }
    return out;
  }

  static Map<String, int> presetFocusPrimary(List<String> portfolioIds) {
    if (portfolioIds.isEmpty) return const {};
    if (portfolioIds.length == 1) {
      return {portfolioIds.first: exact100X100};
    }
    final out = <String, int>{portfolioIds.first: 6000};
    final rest = portfolioIds.sublist(1);
    final perRest = 4000 ~/ rest.length;
    final rem = 4000 - (perRest * rest.length);
    for (var i = 0; i < rest.length; i++) {
      out[rest[i]] = perRest + (i == rest.length - 1 ? rem : 0);
    }
    return out;
  }

  static Map<String, int> presetTwoMajor(List<String> portfolioIds) {
    if (portfolioIds.length < 3) {
      return presetFocusPrimary(portfolioIds);
    }
    final out = <String, int>{
      portfolioIds[0]: 5000,
      portfolioIds[1]: 3000,
    };
    final rest = portfolioIds.sublist(2);
    final perRest = 2000 ~/ rest.length;
    final rem = 2000 - (perRest * rest.length);
    for (var i = 0; i < rest.length; i++) {
      out[rest[i]] = perRest + (i == rest.length - 1 ? rem : 0);
    }
    return out;
  }

  static Map<String, int> nominalMapToX100({
    required int totalAmount,
    required Map<String, int> nominalById,
  }) {
    if (nominalById.isEmpty) return const {};
    if (totalAmount <= 0) {
      return {for (final k in nominalById.keys) k: 0};
    }
    return {
      for (final e in nominalById.entries)
        e.key: ((math.max(0, e.value) / totalAmount) * exact100X100)
            .round()
            .clamp(0, exact100X100),
    };
  }

  static PlanValidationResult validateForApply({
    required int totalAmount,
    required Map<String, int> sharePercentX100ById,
    required Map<String, String> portfolioNamesById,
    required int? ceilingAmount,
    required bool planLimitEnabled,
    required int? planLimitAmount,
  }) {
    final sumX100 = totalX100(sharePercentX100ById.values);
    final derived = computeAmountsFromPercents(
      totalAmount: totalAmount,
      sharePercentX100ById: sharePercentX100ById,
    );

    if (totalAmount < 0) {
      return PlanValidationResult(
        isValid: false,
        totalX100: sumX100,
        derivedAmountsById: derived,
        errorMessage: 'Total Plan tidak boleh negatif. Masukkan angka Rp 0 atau lebih.',
      );
    }

    if (sumX100 != exact100X100) {
      final diff = (exact100X100 - sumX100).abs();
      final msg = sumX100 < exact100X100
          ? 'Total bagian baru ${formatX100(sumX100)} — kurang ${formatX100(diff)} untuk penuh 100%. Tambah bagian atau tekan "Pas-kan ke 100%".'
          : 'Total bagian sudah ${formatX100(sumX100)} — lebih ${formatX100(diff)} dari 100%. Kurangi bagian atau tekan "Pas-kan ke 100%".';
      return PlanValidationResult(
        isValid: false,
        totalX100: sumX100,
        derivedAmountsById: derived,
        errorMessage: msg,
      );
    }

    if (ceilingAmount != null && totalAmount > ceilingAmount) {
      return PlanValidationResult(
        isValid: false,
        totalX100: sumX100,
        derivedAmountsById: derived,
        errorMessage:
            'Total Plan ${AppFormatters.rupiah(totalAmount)} — di atas batas aman ${AppFormatters.rupiah(ceilingAmount)}. Turunkan total Plan atau naikkan gaji di Pengaturan.',
      );
    }

    if (planLimitEnabled && planLimitAmount != null && planLimitAmount > 0) {
      for (final entry in derived.entries) {
        if (entry.value > planLimitAmount) {
          final name = portfolioNamesById[entry.key] ?? 'Porto';
          final pct = formatX100(sharePercentX100ById[entry.key] ?? 0);
          return PlanValidationResult(
            isValid: false,
            totalX100: sumX100,
            derivedAmountsById: derived,
            errorMessage:
                '$name kebagian ${AppFormatters.rupiah(entry.value)} ($pct) — di atas batas per porto ${AppFormatters.rupiah(planLimitAmount)}. Kurangi persennya atau ubah batas di Pengaturan.',
          );
        }
      }
    }

    return PlanValidationResult(
      isValid: true,
      totalX100: sumX100,
      derivedAmountsById: derived,
    );
  }
}
