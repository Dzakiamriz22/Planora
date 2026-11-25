import 'dart:math' as math;

/// Status pelacakan tujuan keuangan.
enum GoalTrackStatus {
  achieved,
  overdue,
  onTrack,
  behind,
  flexible,
  noTarget,
}

class RequiredMonthlyResult {
  const RequiredMonthlyResult({
    required this.amount,
    required this.isAchieved,
    required this.isOverdue,
    required this.monthsLeft,
  });

  final int amount;
  final bool isAchieved;
  final bool isOverdue;
  final int? monthsLeft;
}

class TargetDateEstimate {
  const TargetDateEstimate({
    required this.estimatedDate,
    required this.monthsNeeded,
    required this.isAchieved,
    required this.isUnreachable,
  });

  final DateTime? estimatedDate;
  final int? monthsNeeded;
  final bool isAchieved;
  final bool isUnreachable;
}

class RebalanceItem {
  const RebalanceItem({
    required this.id,
    required this.name,
    required this.currentAmount,
  });

  final String id;
  final String name;
  final int currentAmount;
}

class RebalanceChange {
  const RebalanceChange({
    required this.id,
    required this.name,
    required this.oldAmount,
    required this.newAmount,
  });

  final String id;
  final String name;
  final int oldAmount;
  final int newAmount;

  int get delta => newAmount - oldAmount;
}

class RebalanceResult {
  const RebalanceResult({
    required this.success,
    required this.needsRebalance,
    required this.excess,
    required this.changes,
    this.errorMessage,
  });

  final bool success;
  final bool needsRebalance;
  final int excess;
  final List<RebalanceChange> changes;
  final String? errorMessage;
}

class PhaseAllocationInput {
  const PhaseAllocationInput({
    required this.portfolioId,
    required this.portfolioName,
    required this.monthlyAmount,
  });

  final String portfolioId;
  final String portfolioName;
  final int monthlyAmount;
}

class PhaseValidationResult {
  const PhaseValidationResult({
    required this.isValid,
    required this.totalAmount,
    this.errorMessage,
  });

  final bool isValid;
  final int totalAmount;
  final String? errorMessage;
}

class ComponentsSummary {
  const ComponentsSummary({
    required this.totalComponents,
    required this.unallocated,
    required this.isValid,
  });

  final int totalComponents;
  final int unallocated;
  final bool isValid;
}

/// Mesin perhitungan murni Planora v2.1 — tanpa dependensi Flutter/UI (NFR-08).
class PlanoraCalc {
  PlanoraCalc._();

  static const int maxSimulationMonths = 600;

  /// Plafon menabung = gaji − biaya hidup minimum; NULL bila salah satu NULL (FR-05).
  static int? ceiling({
    required int? monthlySalary,
    required int? minimumLivingCost,
  }) {
    if (monthlySalary == null || minimumLivingCost == null) {
      return null;
    }
    return math.max(0, monthlySalary - minimumLivingCost);
  }

  /// Total rencana setoran bulanan seluruh porto.
  static int totalMonthlyPlan(Iterable<int> plans) {
    var sum = 0;
    for (final p in plans) {
      sum += p;
    }
    return sum;
  }

  /// Apakah total rencana masih dalam batas plafon (selalu true bila plafon NULL).
  static bool isWithinCeiling({
    required int totalPlan,
    required int? ceilingAmount,
  }) {
    if (ceilingAmount == null) return true;
    return totalPlan <= ceilingAmount;
  }

  /// Sisa kebutuhan = maks(0, T − S).
  static int remainingNeed({
    required int savedTarget,
    required int balance,
  }) {
    return math.max(0, savedTarget - balance);
  }

  /// Persentase progres 0..100.
  static double progressPercent({
    required int? savedTarget,
    required int balance,
  }) {
    if (savedTarget == null || savedTarget <= 0) return 0.0;
    if (balance >= savedTarget) return 100.0;
    if (balance <= 0) return 0.0;
    return (balance / savedTarget) * 100.0;
  }

  /// Jumlah bulan dari tanggal berjalan ke tanggal target.
  static int monthsRemaining(DateTime from, DateTime target) {
    final fromDay = DateTime(from.year, from.month, from.day);
    final targetDay = DateTime(target.year, target.month, target.day);
    if (targetDay.isBefore(fromDay)) {
      return 0;
    }
    final diff = (target.year - from.year) * 12 + (target.month - from.month);
    return diff <= 0 ? 1 : diff;
  }

  /// Perlu per bulan agar tepat waktu dengan pertumbuhan majemuk bulanan (Bab B.3).
  static RequiredMonthlyResult requiredMonthlyDeposit({
    required int savedTarget,
    required int balance,
    required DateTime? targetDate,
    required double annualReturnPct,
    required DateTime now,
  }) {
    final sisa = remainingNeed(savedTarget: savedTarget, balance: balance);
    if (sisa == 0) {
      return const RequiredMonthlyResult(
        amount: 0,
        isAchieved: true,
        isOverdue: false,
        monthsLeft: 0,
      );
    }

    if (targetDate == null) {
      return const RequiredMonthlyResult(
        amount: 0,
        isAchieved: false,
        isOverdue: false,
        monthsLeft: null,
      );
    }

    final n = monthsRemaining(now, targetDate);
    if (n <= 0) {
      return RequiredMonthlyResult(
        amount: sisa,
        isAchieved: false,
        isOverdue: true,
        monthsLeft: 0,
      );
    }

    final r = annualReturnPct / 100.0 / 12.0;
    double raw;
    if (r <= 0) {
      raw = sisa / n;
    } else {
      final compound = math.pow(1.0 + r, n).toDouble();
      raw = (savedTarget - balance * compound) * r / (compound - 1.0);
    }

    final amount = raw <= 0 ? 0 : raw.round();
    return RequiredMonthlyResult(
      amount: amount,
      isAchieved: false,
      isOverdue: false,
      monthsLeft: n,
    );
  }

  /// Estimasi tanggal tercapai lewat simulasi bulanan hingga maksimal 600 bulan.
  static TargetDateEstimate estimateTargetDate({
    required int savedTarget,
    required int balance,
    required int monthlyPlan,
    required double annualReturnPct,
    required DateTime now,
    int maxMonths = maxSimulationMonths,
  }) {
    if (balance >= savedTarget) {
      return TargetDateEstimate(
        estimatedDate: DateTime(now.year, now.month, now.day),
        monthsNeeded: 0,
        isAchieved: true,
        isUnreachable: false,
      );
    }

    if (monthlyPlan <= 0) {
      return const TargetDateEstimate(
        estimatedDate: null,
        monthsNeeded: null,
        isAchieved: false,
        isUnreachable: true,
      );
    }

    final r = annualReturnPct / 100.0 / 12.0;
    var current = balance.toDouble();

    for (var m = 1; m <= maxMonths; m++) {
      current = (current + monthlyPlan) * (1.0 + r);
      if (current >= savedTarget) {
        final estimated = DateTime(now.year, now.month + m + 1, 0);
        return TargetDateEstimate(
          estimatedDate: estimated,
          monthsNeeded: m,
          isAchieved: false,
          isUnreachable: false,
        );
      }
    }

    return const TargetDateEstimate(
      estimatedDate: null,
      monthsNeeded: null,
      isAchieved: false,
      isUnreachable: true,
    );
  }

  /// Status pelacakan tujuan.
  static GoalTrackStatus trackStatus({
    required int? savedTarget,
    required int balance,
    required int monthlyPlan,
    required DateTime? targetDate,
    required double annualReturnPct,
    required DateTime now,
  }) {
    if (savedTarget == null || savedTarget <= 0) {
      return GoalTrackStatus.noTarget;
    }
    if (balance >= savedTarget) {
      return GoalTrackStatus.achieved;
    }
    if (targetDate == null) {
      return GoalTrackStatus.flexible;
    }
    final req = requiredMonthlyDeposit(
      savedTarget: savedTarget,
      balance: balance,
      targetDate: targetDate,
      annualReturnPct: annualReturnPct,
      now: now,
    );
    if (req.isOverdue) {
      return GoalTrackStatus.overdue;
    }
    return monthlyPlan >= req.amount
        ? GoalTrackStatus.onTrack
        : GoalTrackStatus.behind;
  }

  /// Ringkasan komponen instrumen terhadap saldo porto (BR-02 / FR-10).
  static ComponentsSummary componentsSummary({
    required int balance,
    required Iterable<int> componentAmounts,
  }) {
    var total = 0;
    for (final a in componentAmounts) {
      total += a;
    }
    final unallocated = balance - total;
    return ComponentsSummary(
      totalComponents: total,
      unallocated: unallocated,
      isValid: total <= balance,
    );
  }

  /// Ilustrasi cicilan anuitas (Bab B.3, FR-27, Lampiran L.2 #10).
  /// Bunga 0% = pembagian linear `sisa_kredit / tenorMonths`.
  static int annuityInstallment({
    required int principal,
    required int tenorMonths,
    required double annualInterestPct,
  }) {
    if (principal <= 0 || tenorMonths <= 0) return 0;
    if (annualInterestPct <= 0) {
      return (principal / tenorMonths).round();
    }
    final i = annualInterestPct / 100.0 / 12.0;
    final denom = 1.0 - math.pow(1.0 + i, -tenorMonths).toDouble();
    if (denom <= 0) return (principal / tenorMonths).round();
    return (principal * i / denom).round();
  }

  /// Buat fase seimbang (Bab B.3, FR-23, Lampiran L.2 #9):
  /// `bagi = plafon / jumlah porto` (ribuan ke bawah), sisa ke porto pertama;
  /// bila batas per porto aktif dan `bagi` melampauinya, setiap alokasi = batas.
  static Map<String, int> balancedPhaseAllocations({
    required List<String> portfolioIds,
    required int ceilingAmount,
    bool phaseLimitEnabled = false,
    int? phaseLimitAmount,
  }) {
    if (portfolioIds.isEmpty || ceilingAmount <= 0) {
      return {for (final id in portfolioIds) id: 0};
    }

    final count = portfolioIds.length;
    final rawShare = ceilingAmount ~/ count;
    final flooredShare = (rawShare ~/ 1000) * 1000;

    if (phaseLimitEnabled &&
        phaseLimitAmount != null &&
        phaseLimitAmount >= 0 &&
        flooredShare >= phaseLimitAmount) {
      return {for (final id in portfolioIds) id: phaseLimitAmount};
    }

    final remainder = ceilingAmount - (flooredShare * count);
    final result = <String, int>{};

    for (var i = 0; i < count; i++) {
      var amt = flooredShare;
      if (i == 0) {
        amt += remainder;
        if (phaseLimitEnabled &&
            phaseLimitAmount != null &&
            amt > phaseLimitAmount) {
          amt = phaseLimitAmount;
        }
      }
      result[portfolioIds[i]] = amt;
    }

    return result;
  }

  /// Penyeimbangan proporsional saat satu porto dinaikkan melewati plafon (FR-17).
  /// Bila `ceilingAmount == null` (profil belum diisi), tidak perlu penyeimbangan.
  static RebalanceResult rebalanceProportionally({
    required List<RebalanceItem> items,
    required String editedId,
    required int newEditedAmount,
    required int? ceilingAmount,
  }) {
    if (newEditedAmount < 0) {
      return const RebalanceResult(
        success: false,
        needsRebalance: false,
        excess: 0,
        changes: [],
        errorMessage: 'Rencana setoran tidak boleh bernilai negatif.',
      );
    }

    if (ceilingAmount == null) {
      return const RebalanceResult(
        success: true,
        needsRebalance: false,
        excess: 0,
        changes: [],
      );
    }

    final others = items.where((i) => i.id != editedId).toList();
    final totalOthers = others.fold<int>(0, (sum, i) => sum + i.currentAmount);
    final newTotal = totalOthers + newEditedAmount;

    if (newTotal <= ceilingAmount) {
      return const RebalanceResult(
        success: true,
        needsRebalance: false,
        excess: 0,
        changes: [],
      );
    }

    final excess = newTotal - ceilingAmount;
    if (newEditedAmount > ceilingAmount || totalOthers < excess) {
      return RebalanceResult(
        success: false,
        needsRebalance: true,
        excess: excess,
        changes: const [],
        errorMessage:
            'Rencana setoran (${_rupiah(newEditedAmount)}) melebihi plafon (${_rupiah(ceilingAmount)}) meskipun seluruh porto lain diturunkan ke Rp 0.',
      );
    }

    final eligible = others.where((i) => i.currentAmount > 0).toList();
    final eligibleTotal =
        eligible.fold<int>(0, (sum, i) => sum + i.currentAmount);

    final reductions = <String, int>{};
    var allocatedReduction = 0;

    for (final item in eligible) {
      final raw = excess * (item.currentAmount / eligibleTotal);
      var rounded = ((raw / 1000).round()) * 1000;
      if (rounded > item.currentAmount) rounded = item.currentAmount;
      if (rounded < 0) rounded = 0;
      reductions[item.id] = rounded;
      allocatedReduction += rounded;
    }

    var diff = excess - allocatedReduction;
    final byLargest = List<RebalanceItem>.from(eligible)
      ..sort((a, b) => b.currentAmount.compareTo(a.currentAmount));

    if (diff > 0) {
      for (final item in byLargest) {
        if (diff <= 0) break;
        final currentRed = reductions[item.id] ?? 0;
        final headroom = item.currentAmount - currentRed;
        if (headroom <= 0) continue;
        final add = math.min(diff, headroom);
        reductions[item.id] = currentRed + add;
        diff -= add;
      }
    } else if (diff < 0) {
      var surplus = -diff;
      for (final item in byLargest) {
        if (surplus <= 0) break;
        final currentRed = reductions[item.id] ?? 0;
        if (currentRed <= 0) continue;
        final sub = math.min(surplus, currentRed);
        reductions[item.id] = currentRed - sub;
        surplus -= sub;
      }
      diff = -surplus;
    }

    if (diff > 0) {
      return RebalanceResult(
        success: false,
        needsRebalance: true,
        excess: excess,
        changes: const [],
        errorMessage: 'Sisa plafon tidak mencukupi setelah penyeimbangan.',
      );
    }

    final editedOld = items
            .where((i) => i.id == editedId)
            .map((i) => i.currentAmount)
            .firstOrNull ??
        0;
    final editedName = items
            .where((i) => i.id == editedId)
            .map((i) => i.name)
            .firstOrNull ??
        'Porto Baru';

    final changes = <RebalanceChange>[
      RebalanceChange(
        id: editedId,
        name: editedName,
        oldAmount: editedOld,
        newAmount: newEditedAmount,
      ),
      for (final item in others)
        if ((reductions[item.id] ?? 0) > 0)
          RebalanceChange(
            id: item.id,
            name: item.name,
            oldAmount: item.currentAmount,
            newAmount: item.currentAmount - (reductions[item.id] ?? 0),
          ),
    ];

    return RebalanceResult(
      success: true,
      needsRebalance: true,
      excess: excess,
      changes: changes,
    );
  }

  /// Skalakan seluruh porto turun proporsional agar total <= plafon (FR-18).
  static RebalanceResult scaleAllToCeiling({
    required List<RebalanceItem> items,
    required int ceilingAmount,
  }) {
    final total = items.fold<int>(0, (sum, i) => sum + i.currentAmount);
    if (total <= ceilingAmount) {
      return const RebalanceResult(
        success: true,
        needsRebalance: false,
        excess: 0,
        changes: [],
      );
    }

    final excess = total - ceilingAmount;
    final eligible = items.where((i) => i.currentAmount > 0).toList();
    if (eligible.isEmpty) {
      return RebalanceResult(
        success: false,
        needsRebalance: true,
        excess: excess,
        changes: const [],
        errorMessage: 'Tidak ada rencana setoran yang bisa diturunkan.',
      );
    }

    final reductions = <String, int>{};
    var allocated = 0;

    for (final item in eligible) {
      final raw = excess * (item.currentAmount / total);
      var rounded = ((raw / 1000).round()) * 1000;
      if (rounded > item.currentAmount) rounded = item.currentAmount;
      if (rounded < 0) rounded = 0;
      reductions[item.id] = rounded;
      allocated += rounded;
    }

    var diff = excess - allocated;
    final byLargest = List<RebalanceItem>.from(eligible)
      ..sort((a, b) => b.currentAmount.compareTo(a.currentAmount));

    if (diff > 0) {
      for (final item in byLargest) {
        if (diff <= 0) break;
        final currentRed = reductions[item.id] ?? 0;
        final headroom = item.currentAmount - currentRed;
        if (headroom <= 0) continue;
        final add = math.min(diff, headroom);
        reductions[item.id] = currentRed + add;
        diff -= add;
      }
    } else if (diff < 0) {
      var surplus = -diff;
      for (final item in byLargest) {
        if (surplus <= 0) break;
        final currentRed = reductions[item.id] ?? 0;
        if (currentRed <= 0) continue;
        final sub = math.min(surplus, currentRed);
        reductions[item.id] = currentRed - sub;
        surplus -= sub;
      }
    }

    final changes = <RebalanceChange>[
      for (final item in eligible)
        if ((reductions[item.id] ?? 0) > 0)
          RebalanceChange(
            id: item.id,
            name: item.name,
            oldAmount: item.currentAmount,
            newAmount: item.currentAmount - (reductions[item.id] ?? 0),
          ),
    ];

    return RebalanceResult(
      success: true,
      needsRebalance: true,
      excess: excess,
      changes: changes,
    );
  }

  /// Validasi fase v2.1 (FR-20 & FR-21):
  /// - Total alokasi <= plafon (bila plafon diatur).
  /// - Batas per porto opsional (`phaseLimitEnabled`), berlaku untuk SEMUA porto
  ///   tanpa memandang platform/instrumen.
  static PhaseValidationResult validatePhaseAllocations({
    required List<PhaseAllocationInput> allocations,
    required int? ceilingAmount,
    bool phaseLimitEnabled = false,
    int? phaseLimitAmount,
  }) {
    var total = 0;
    for (final alloc in allocations) {
      if (alloc.monthlyAmount < 0) {
        return PhaseValidationResult(
          isValid: false,
          totalAmount: total,
          errorMessage:
              'Alokasi ${alloc.portfolioName} tidak boleh bernilai negatif.',
        );
      }
      if (phaseLimitEnabled &&
          phaseLimitAmount != null &&
          alloc.monthlyAmount > phaseLimitAmount) {
        return PhaseValidationResult(
          isValid: false,
          totalAmount: total + alloc.monthlyAmount,
          errorMessage:
              'Alokasi "${alloc.portfolioName}" (${_rupiah(alloc.monthlyAmount)}) melebihi batas per porto (${_rupiah(phaseLimitAmount)}/bln).',
        );
      }
      total += alloc.monthlyAmount;
    }

    if (ceilingAmount != null && total > ceilingAmount) {
      return PhaseValidationResult(
        isValid: false,
        totalAmount: total,
        errorMessage:
            'Total alokasi fase (${_rupiah(total)}) melebihi plafon menabung (${_rupiah(ceilingAmount)}).',
      );
    }

    return PhaseValidationResult(
      isValid: true,
      totalAmount: total,
    );
  }

  static String _rupiah(int value) {
    final s = value.abs().toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return value < 0 ? '-Rp $buf' : 'Rp $buf';
  }
}
