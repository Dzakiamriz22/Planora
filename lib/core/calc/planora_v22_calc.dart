import 'dart:math' as math;

class MigrationValidationException implements Exception {
  MigrationValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

enum PortfolioTrackStatusV22 {
  achieved, // Tercapai: saldo >= target
  notStarted, // Belum Mulai: belum ada setoran sama sekali
  onTrack, // On Track: tanpa tanggal target, atau proyeksi <= tanggal target
  offTrack, // Off Track: ada tanggal target dan proyeksi melewati tanggal target
}

class PortfolioProjectionV22 {
  const PortfolioProjectionV22({
    required this.status,
    required this.averageRate3m,
    required this.requiredMonthly,
    required this.monthsNeeded,
    required this.projectedDate,
    this.rateEmptyMessage,
    this.monthlyGapToOnTrack = 0,
  });

  final PortfolioTrackStatusV22 status;
  final int averageRate3m;
  final int? requiredMonthly;
  final int? monthsNeeded;
  final DateTime? projectedDate;
  final String? rateEmptyMessage;
  final int monthlyGapToOnTrack;
}

class ComponentPercentItem {
  const ComponentPercentItem({
    required this.key,
    required this.instrumentType,
    required this.targetPercent,
    this.actualAmount = 0,
  });

  final String key;
  final String instrumentType;
  final double targetPercent;
  final int actualAmount;

  ComponentPercentItem copyWith({
    String? key,
    String? instrumentType,
    double? targetPercent,
    int? actualAmount,
  }) {
    return ComponentPercentItem(
      key: key ?? this.key,
      instrumentType: instrumentType ?? this.instrumentType,
      targetPercent: targetPercent ?? this.targetPercent,
      actualAmount: actualAmount ?? this.actualAmount,
    );
  }
}

enum DashboardInsightKind {
  offTrack,
  noDepositAfterDay10,
  allocationDeviation,
  emptyComponent,
  milestone,
  streak,
}

class DashboardInsight {
  const DashboardInsight({
    required this.kind,
    required this.title,
    required this.message,
    this.portfolioId,
  });

  final DashboardInsightKind kind;
  final String title;
  final String message;
  final String? portfolioId;
}

class MonthlyBalancePoint {
  const MonthlyBalancePoint({
    required this.month,
    required this.cumulativeBalance,
    required this.monthlyDeposit,
  });

  final DateTime month;
  final int cumulativeBalance;
  final int monthlyDeposit;
}

class PlanoraV22Calc {
  PlanoraV22Calc._();

  static double round2(double value) {
    if (value.isNaN || value.isInfinite) return 0.0;
    return (value * 100).round() / 100.0;
  }

  static String formatPercent(double value, {bool forceTwoDecimals = false}) {
    final r = round2(value);
    if (!forceTwoDecimals && (r - r.roundToDouble()).abs() < 0.005) {
      return '${r.round()}%';
    }
    return '${r.toStringAsFixed(2).replaceAll('.', ',')}%';
  }

  static int targetAmountFromPercent({
    required double targetPercent,
    required int portfolioTargetTotal,
  }) {
    if (portfolioTargetTotal <= 0 || targetPercent <= 0) return 0;
    return ((targetPercent / 100.0) * portfolioTargetTotal).round();
  }

  static Map<String, int> splitDepositByTargetPercent({
    required int depositAmount,
    required List<({String id, double targetPercent})> components,
  }) {
    if (depositAmount == 0 || components.isEmpty) return const {};
    final totalPct = components.fold<double>(
      0.0,
      (sum, c) => sum + math.max(0.0, c.targetPercent),
    );
    if (totalPct <= 0) return const {};

    final result = <String, int>{};
    var allocated = 0;
    var largestId = components.first.id;
    var largestPct = -1.0;

    for (final c in components) {
      final pct = math.max(0.0, c.targetPercent);
      if (pct > largestPct) {
        largestPct = pct;
        largestId = c.id;
      }
      final share = (depositAmount * (pct / totalPct)).round();
      result[c.id] = share;
      allocated += share;
    }

    final diff = depositAmount - allocated;
    if (diff != 0) {
      result[largestId] = (result[largestId] ?? 0) + diff;
    }
    return result;
  }

  static double actualPercent({
    required int actualAmount,
    required int totalActualPortfolio,
  }) {
    if (totalActualPortfolio <= 0 || actualAmount <= 0) return 0.0;
    return round2((actualAmount / totalActualPortfolio) * 100.0);
  }

  static double percentFromNominal({
    required int nominal,
    required int portfolioTargetTotal,
  }) {
    if (portfolioTargetTotal <= 0 || nominal <= 0) return 0.0;
    return round2((nominal / portfolioTargetTotal) * 100.0);
  }

  static double totalTargetPercent(Iterable<double> percents) {
    var sum = 0.0;
    for (final p in percents) {
      sum += p;
    }
    return round2(sum);
  }

  static bool isExact100(Iterable<double> percents) {
    final total = totalTargetPercent(percents);
    return (total - 100.0).abs() <= 0.001;
  }

  static List<ComponentPercentItem> autoBalanceTo100(
    List<ComponentPercentItem> items, {
    String? lastEditedKey,
  }) {
    if (items.isEmpty) return const [];
    if (items.length == 1) {
      return [items.first.copyWith(targetPercent: 100.0)];
    }

    final normalized = items
        .map((e) => e.copyWith(targetPercent: round2(math.max(0.0, e.targetPercent))))
        .toList();

    final currentTotal = totalTargetPercent(normalized.map((e) => e.targetPercent));
    final diff = round2(100.0 - currentTotal);
    if (diff.abs() <= 0.001) return normalized;

    var targetIdx = -1;
    if (lastEditedKey != null) {
      targetIdx = normalized.indexWhere((e) => e.key == lastEditedKey);
    }
    if (targetIdx == -1) {
      targetIdx = 0;
      for (var i = 1; i < normalized.length; i++) {
        if (normalized[i].targetPercent > normalized[targetIdx].targetPercent) {
          targetIdx = i;
        }
      }
    }

    final candidate = round2(normalized[targetIdx].targetPercent + diff);
    if (candidate >= 0) {
      normalized[targetIdx] = normalized[targetIdx].copyWith(
        targetPercent: candidate,
      );
      return normalized;
    }

    var remainingCut = round2(-candidate);
    normalized[targetIdx] = normalized[targetIdx].copyWith(targetPercent: 0.0);
    final indices = List.generate(normalized.length, (i) => i)
      ..sort(
        (a, b) =>
            normalized[b].targetPercent.compareTo(normalized[a].targetPercent),
      );
    for (final idx in indices) {
      if (remainingCut <= 0.001) break;
      final avail = normalized[idx].targetPercent;
      final cut = math.min(avail, remainingCut);
      normalized[idx] = normalized[idx].copyWith(
        targetPercent: round2(avail - cut),
      );
      remainingCut = round2(remainingCut - cut);
    }
    return normalized;
  }

  static List<ComponentPercentItem> applyQuickPreset(
    List<ComponentPercentItem> items, {
    required double primaryPercent,
    String? activeKey,
  }) {
    if (items.isEmpty) return const [];
    if (items.length == 1) {
      return [items.first.copyWith(targetPercent: 100.0)];
    }
    final activeIdx = activeKey == null
        ? 0
        : math.max(0, items.indexWhere((e) => e.key == activeKey));
    final clampedPrimary = round2(primaryPercent.clamp(0.0, 100.0));
    final remainder = round2(100.0 - clampedPrimary);
    final otherCount = items.length - 1;
    final perOther = round2(remainder / otherCount);

    final out = <ComponentPercentItem>[];
    var assignedOthers = 0.0;
    var lastOtherIdx = -1;
    for (var i = 0; i < items.length; i++) {
      if (i == activeIdx) {
        out.add(items[i].copyWith(targetPercent: clampedPrimary));
      } else {
        out.add(items[i].copyWith(targetPercent: perOther));
        assignedOthers = round2(assignedOthers + perOther);
        lastOtherIdx = i;
      }
    }
    final roundingDiff = round2(remainder - assignedOthers);
    if (lastOtherIdx >= 0 && roundingDiff.abs() > 0.0001) {
      out[lastOtherIdx] = out[lastOtherIdx].copyWith(
        targetPercent: round2(out[lastOtherIdx].targetPercent + roundingDiff),
      );
    }
    return out;
  }

  static List<double> migrateAmountsToPercents({
    required List<int> amounts,
    required int portfolioTotalTarget,
  }) {
    if (amounts.isEmpty) return const [];
    if (portfolioTotalTarget <= 0) {
      throw MigrationValidationException(
        'Migrasi dibatalkan: total target porto tidak valid (Rp 0). Data lama dipertahankan.',
      );
    }
    if (amounts.length == 1) {
      if (amounts.first < 0) {
        throw MigrationValidationException(
          'Migrasi dibatalkan: nominal komponen negatif.',
        );
      }
      return const [100.0];
    }

    final sumAmounts = amounts.fold<int>(0, (s, a) => s + a);
    if (sumAmounts <= 0) {
      throw MigrationValidationException(
        'Migrasi dibatalkan: total nominal komponen tidak valid (Rp 0). Data lama dipertahankan.',
      );
    }

    final base = sumAmounts;
    final percents = <double>[];
    var largestIdx = 0;
    for (var i = 0; i < amounts.length; i++) {
      if (amounts[i] < 0) {
        throw MigrationValidationException(
          'Migrasi dibatalkan: nominal komponen negatif.',
        );
      }
      if (amounts[i] > amounts[largestIdx]) {
        largestIdx = i;
      }
      percents.add(round2((amounts[i] / base) * 100.0));
    }

    final currentSum = totalTargetPercent(percents);
    final diff = round2(100.0 - currentSum);
    percents[largestIdx] = round2(percents[largestIdx] + diff);

    if (!isExact100(percents) || percents.any((p) => p < 0)) {
      throw MigrationValidationException(
        'Migrasi dibatalkan: gagal verifikasi total 100% setelah konversi.',
      );
    }
    return percents;
  }

  static int averageMonthlyDeposit3m({
    required Iterable<({DateTime date, int amount})> deposits,
    required DateTime now,
  }) {
    final startMonth = DateTime(now.year, now.month - 2, 1);
    final endMonth = DateTime(now.year, now.month + 1, 1);
    var total = 0;
    for (final d in deposits) {
      if (!d.date.isBefore(startMonth) && d.date.isBefore(endMonth)) {
        total += d.amount;
      }
    }
    return (total / 3.0).round();
  }

  static PortfolioProjectionV22 evaluateStatusAndProjection({
    required int? targetTotal,
    required int actualBalance,
    required bool hasAnyDeposit,
    required DateTime? targetDate,
    required int averageRate3m,
    required DateTime now,
  }) {
    final remaining =
        targetTotal != null ? math.max(0, targetTotal - actualBalance) : 0;

    if (targetTotal != null && targetTotal > 0 && actualBalance >= targetTotal) {
      return PortfolioProjectionV22(
        status: PortfolioTrackStatusV22.achieved,
        averageRate3m: averageRate3m,
        requiredMonthly: 0,
        monthsNeeded: 0,
        projectedDate: DateTime(now.year, now.month, 1),
      );
    }

    if (!hasAnyDeposit && actualBalance <= 0) {
      return PortfolioProjectionV22(
        status: PortfolioTrackStatusV22.notStarted,
        averageRate3m: averageRate3m,
        requiredMonthly: _linearRequiredMonthly(
          remaining: remaining,
          targetDate: targetDate,
          now: now,
        ),
        monthsNeeded: null,
        projectedDate: null,
      );
    }

    final reqMonthly = _linearRequiredMonthly(
      remaining: remaining,
      targetDate: targetDate,
      now: now,
    );

    if (targetTotal == null || targetTotal <= 0 || targetDate == null) {
      final months = (targetTotal != null && targetTotal > 0 && averageRate3m > 0)
          ? (remaining / averageRate3m).ceil()
          : null;
      return PortfolioProjectionV22(
        status: PortfolioTrackStatusV22.onTrack,
        averageRate3m: averageRate3m,
        requiredMonthly: reqMonthly,
        monthsNeeded: months,
        projectedDate:
            months != null ? DateTime(now.year, now.month + months, 1) : null,
        rateEmptyMessage: averageRate3m <= 0
            ? 'Belum ada setoran dalam 3 bulan terakhir'
            : null,
      );
    }

    final targetMonth = DateTime(targetDate.year, targetDate.month, 1);
    final nowMonth = DateTime(now.year, now.month, 1);

    if (averageRate3m <= 0) {
      return PortfolioProjectionV22(
        status: PortfolioTrackStatusV22.offTrack,
        averageRate3m: 0,
        requiredMonthly: reqMonthly,
        monthsNeeded: null,
        projectedDate: null,
        rateEmptyMessage: 'Belum ada setoran dalam 3 bulan terakhir',
        monthlyGapToOnTrack: reqMonthly ?? remaining,
      );
    }

    final monthsNeeded = (remaining / averageRate3m).ceil();
    final projectedDate = DateTime(nowMonth.year, nowMonth.month + monthsNeeded, 1);

    final rateBelowBy10Pct =
        reqMonthly != null && reqMonthly > 0 && averageRate3m < (reqMonthly * 0.9);
    final projectedPastTarget = projectedDate.isAfter(targetMonth);

    final isOnTrack =
        !projectedPastTarget &&
            !rateBelowBy10Pct ||
        (reqMonthly != null && averageRate3m >= reqMonthly && !projectedPastTarget);

    final gap = reqMonthly != null && reqMonthly > averageRate3m
        ? reqMonthly - averageRate3m
        : 0;

    return PortfolioProjectionV22(
      status: isOnTrack
          ? PortfolioTrackStatusV22.onTrack
          : PortfolioTrackStatusV22.offTrack,
      averageRate3m: averageRate3m,
      requiredMonthly: reqMonthly,
      monthsNeeded: monthsNeeded,
      projectedDate: projectedDate,
      monthlyGapToOnTrack: isOnTrack ? 0 : gap,
    );
  }

  static int? _linearRequiredMonthly({
    required int remaining,
    required DateTime? targetDate,
    required DateTime now,
  }) {
    if (targetDate == null || remaining <= 0) return null;
    final monthsLeft =
        (targetDate.year - now.year) * 12 + (targetDate.month - now.month);
    if (monthsLeft <= 0) return remaining;
    return (remaining / monthsLeft).ceil();
  }

  static int calculateMonthlyStreak({
    required Iterable<DateTime> depositDates,
    required DateTime now,
  }) {
    final monthsWithDeposits = <(int, int)>{
      for (final d in depositDates) (d.year, d.month),
    };
    if (monthsWithDeposits.isEmpty) return 0;

    var cursor = DateTime(now.year, now.month, 1);
    if (!monthsWithDeposits.contains((cursor.year, cursor.month))) {
      cursor = DateTime(cursor.year, cursor.month - 1, 1);
    }

    var streak = 0;
    while (monthsWithDeposits.contains((cursor.year, cursor.month))) {
      streak++;
      cursor = DateTime(cursor.year, cursor.month - 1, 1);
      if (streak >= 600) break;
    }
    return streak;
  }

  static List<MonthlyBalancePoint> buildMonthlyBalanceSeries({
    required Iterable<({DateTime date, int amount})> deposits,
    required int months,
    required DateTime now,
  }) {
    final count = math.max(1, months);
    final startMonth = DateTime(now.year, now.month - (count - 1), 1);

    var priorBalance = 0;
    final byMonth = <(int, int), int>{};
    for (final d in deposits) {
      final m = DateTime(d.date.year, d.date.month, 1);
      if (m.isBefore(startMonth)) {
        priorBalance += d.amount;
      } else if (!m.isAfter(DateTime(now.year, now.month, 1))) {
        final key = (m.year, m.month);
        byMonth[key] = (byMonth[key] ?? 0) + d.amount;
      }
    }

    final result = <MonthlyBalancePoint>[];
    var running = priorBalance;
    for (var i = 0; i < count; i++) {
      final m = DateTime(startMonth.year, startMonth.month + i, 1);
      final dep = byMonth[(m.year, m.month)] ?? 0;
      running += dep;
      result.add(
        MonthlyBalancePoint(
          month: m,
          cumulativeBalance: running,
          monthlyDeposit: dep,
        ),
      );
    }
    return result;
  }

  static int dailyQuoteIndex(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(startOfYear).inDays + 1;
    return dayOfYear % 24;
  }

  static String dailyQuote(DateTime date) => neutralQuotes[dailyQuoteIndex(date)];

  static const List<String> neutralQuotes = [
    'Setoran rutin yang kecil lebih efektif daripada rencana besar yang tidak jalan.',
    'Tahu batas nabung bulanan membuat pembagian tujuan lebih masuk akal.',
    'Pisahkan dana darurat supaya tujuan lain tidak terganggu saat ada kebutuhan mendadak.',
    'Target yang jelas memudahkan kamu mengukur seberapa dekat tujuanmu.',
    'Prioritas boleh berubah; cukup sesuaikan fase alokasi tanpa rombak semua porto.',
    'Catat setiap setoran supaya progres dan estimasi waktu tetap akurat.',
    'Sisihkan tabungan di awal bulan agar tidak terpakai untuk belanja impulsif.',
    'Jaga biaya hidup tetap terkendali supaya ruang nabung lebih lega.',
    'Untuk pembelian besar, fokuskan target awal ke DP dan biaya transaksi.',
    'Cek perbandingan alokasi aktual dan target untuk tahu instrumen mana yang perlu ditambah.',
    'Mulai dari nominal yang sanggup kamu jalankan setiap bulan.',
    'Evaluasi lima menit tiap akhir bulan cukup untuk menjaga semua tujuan tetap sesuai jalur.',
    'Cadangkan data ke file JSON secara berkala agar catatanmu aman.',
    'Bandingkan progres bulan ini dengan bulan lalu, bukan dengan orang lain.',
    'Kenaikan gaji adalah waktu yang tepat untuk menaikkan porsi tabungan.',
    'Dana kebutuhan dekat lebih aman di instrumen yang mudah dicairkan.',
    'Kalau pengeluaran bulan ini tinggi, kurangi setoran sementara daripada berhenti total.',
    'Melihat sisa kebutuhan dengan jelas membantu mengambil keputusan belanja lebih bijak.',
    'Tujuan tanpa tenggat tetap berjalan selama setoran rutinnya terjaga.',
    'Satu sistem sederhana yang dipakai rutin lebih berguna daripada rencana rumit yang ditinggalkan.',
    'Beri nama tujuan secara spesifik agar lebih mudah menjaga fokus menabung.',
    'Periksa rincian instrumen sebelum menambah setoran baru.',
    'Disiplin mencatat adalah langkah paling mudah untuk memahami arus tabungan sendiri.',
    'Rencana keuangan yang baik selalu bisa menyesuaikan perubahan kondisi hidup.',
  ];

  static List<DashboardInsight> generateInsights({
    required List<
        ({
          String id,
          String name,
          int balance,
          int? targetTotal,
          double progressPct,
          PortfolioProjectionV22 projection,
          List<({String instrument, double targetPct, int actualAmount})>
              components,
        })> portfolios,
    required bool hasDepositThisMonth,
    required String? activePhaseName,
    required int activePhaseTotal,
    required int streakMonths,
    required DateTime now,
    required String Function(int) formatRupiah,
  }) {
    if (portfolios.isEmpty) return const [];

    final candidates = <DashboardInsight>[];

    for (final p in portfolios) {
      if (p.projection.status == PortfolioTrackStatusV22.offTrack) {
        final gapText = p.projection.monthlyGapToOnTrack > 0
            ? 'perlu ±${formatRupiah(p.projection.monthlyGapToOnTrack)}/bulan untuk kembali On Track.'
            : 'belum ada setoran dalam 3 bulan terakhir.';
        candidates.add(
          DashboardInsight(
            kind: DashboardInsightKind.offTrack,
            title: '${p.name} berisiko terlambat',
            message: '${p.name} berisiko terlambat — $gapText',
            portfolioId: p.id,
          ),
        );
      }
    }

    if (!hasDepositThisMonth && now.day > 10) {
      final phaseHint = activePhaseName != null && activePhaseTotal > 0
          ? '$activePhaseName menyarankan ${formatRupiah(activePhaseTotal)}.'
          : 'Catat setoran pertama bulan ini agar progres tetap terjaga.';
      candidates.add(
        DashboardInsight(
          kind: DashboardInsightKind.noDepositAfterDay10,
          title: 'Belum ada setoran bulan ini',
          message: 'Belum ada setoran bulan ini. $phaseHint',
        ),
      );
    }

    for (final p in portfolios) {
      final totalCompActual =
          p.components.fold<int>(0, (s, c) => s + c.actualAmount);
      for (final c in p.components) {
        if (c.targetPct <= 0) continue;
        if (c.actualAmount == 0 && p.balance > 0) {
          candidates.add(
            DashboardInsight(
              kind: DashboardInsightKind.emptyComponent,
              title: 'Komponen belum terisi',
              message: '${c.instrument} di ${p.name} belum terisi sama sekali.',
              portfolioId: p.id,
            ),
          );
          continue;
        }
        if (totalCompActual > 0) {
          final actualPct = actualPercent(
            actualAmount: c.actualAmount,
            totalActualPortfolio: totalCompActual,
          );
          if ((actualPct - c.targetPct).abs() > 10.0) {
            candidates.add(
              DashboardInsight(
                kind: DashboardInsightKind.allocationDeviation,
                title: 'Deviasi alokasi ${p.name}',
                message:
                    'Alokasi ${c.instrument} di ${p.name} ${formatPercent(actualPct)} dari target ${formatPercent(c.targetPct)} — pertimbangkan setoran berikutnya ke sana.',
                portfolioId: p.id,
              ),
            );
          }
        }
      }
    }

    for (final p in portfolios) {
      if (p.targetTotal == null || p.targetTotal! <= 0) continue;
      final pct = p.progressPct;
      int? hit;
      if (pct >= 100) {
        hit = 100;
      } else if (pct >= 75) {
        hit = 75;
      } else if (pct >= 50) {
        hit = 50;
      } else if (pct >= 25) {
        hit = 25;
      }
      if (hit != null) {
        candidates.add(
          DashboardInsight(
            kind: DashboardInsightKind.milestone,
            title: 'Milestone ${p.name}',
            message: 'Milestone: ${p.name} mencapai $hit% dari target.',
            portfolioId: p.id,
          ),
        );
      }
    }

    if (streakMonths >= 2) {
      candidates.add(
        DashboardInsight(
          kind: DashboardInsightKind.streak,
          title: 'Streak $streakMonths bulan',
          message: 'Sudah $streakMonths bulan berturut-turut mencatat setoran.',
        ),
      );
    }

    return candidates.take(3).toList();
  }
}

