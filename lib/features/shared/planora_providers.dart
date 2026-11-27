import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/global_composition_calc.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/profile_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/data/repositories/stock_repository.dart';
import 'package:planora/widgets/planora_charts.dart';

final userProfileStreamProvider = StreamProvider<UserProfile>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});

final settingsStreamProvider = StreamProvider<Setting>((ref) {
  return ref.watch(settingsRepositoryProvider).watchSettings();
});

final portfoliosStreamProvider = StreamProvider<List<Portfolio>>((ref) {
  return ref.watch(portfolioRepositoryProvider).watchAllPortfolios();
});

final contributionsStreamProvider = StreamProvider<List<Contribution>>((ref) {
  return ref.watch(portfolioRepositoryProvider).watchAllContributions();
});

final portfolioContributionsProvider =
    StreamProvider.family<List<Contribution>, String>((ref, portfolioId) {
  return ref
      .watch(portfolioRepositoryProvider)
      .watchContributionsForPortfolio(portfolioId);
});

final allComponentsStreamProvider =
    StreamProvider<List<PortfolioComponent>>((ref) {
  return ref.watch(portfolioRepositoryProvider).watchAllComponents();
});

final portfolioComponentsProvider =
    StreamProvider.family<List<PortfolioComponent>, String>((ref, portfolioId) {
  return ref
      .watch(portfolioRepositoryProvider)
      .watchComponentsForPortfolio(portfolioId);
});

final plansStreamProvider = StreamProvider<List<Plan>>((ref) {
  return ref.watch(planRepositoryProvider).watchPlans();
});

final planAllocationsStreamProvider =
    StreamProvider<List<PlanAllocation>>((ref) {
  return ref.watch(planRepositoryProvider).watchAllAllocations();
});

final priceReferencesStreamProvider =
    StreamProvider<List<PriceReference>>((ref) {
  return ref.watch(settingsRepositoryProvider).watchPriceReferences();
});

final allStockTransactionsStreamProvider =
    StreamProvider<List<StockTransaction>>((ref) {
  return ref.watch(stockRepositoryProvider).watchAllTransactions();
});

final componentStockTransactionsProvider =
    StreamProvider.family<List<StockTransaction>, String>((ref, componentId) {
  return ref
      .watch(stockRepositoryProvider)
      .watchTransactionsForComponent(componentId);
});

final knownStockTickersProvider = StreamProvider<List<String>>((ref) {
  return ref.watch(stockRepositoryProvider).watchKnownTickers();
});

final componentStockLedgerProvider =
    Provider.family<StockLedgerComputation, String>((ref, componentId) {
  final txs =
      ref.watch(componentStockTransactionsProvider(componentId)).value ??
          const <StockTransaction>[];
  return StockLotCalc.computeLedger(
    txs.map(
      (tx) => StockTxRecord(
        id: tx.id,
        ticker: tx.ticker,
        side: tx.side,
        lots: tx.lots,
        shares: tx.shares,
        pricePerShare: tx.pricePerShare,
        totalAmount: tx.totalAmount,
        transactionDate: tx.transactionDate,
        createdAt: tx.createdAt,
      ),
    ),
    validateStrict: false,
  );
});

class PortfolioSnapshot {
  const PortfolioSnapshot({
    required this.portfolio,
    required this.balance,
    required this.components,
    required this.totalComponentsActual,
    required this.unallocatedBalance,
    required this.remaining,
    required this.progressPct,
    required this.requiredMonthly,
    required this.estimatedDate,
    required this.status,
    required this.projectionV22,
    required this.sparkline6m,
    required this.balanceSeries6m,
  });

  final Portfolio portfolio;
  final int balance;
  final List<PortfolioComponent> components;
  final int totalComponentsActual;
  final int unallocatedBalance;
  final int remaining;
  final double progressPct;
  final RequiredMonthlyResult? requiredMonthly;
  final TargetDateEstimate? estimatedDate;
  final GoalTrackStatus status;

  final PortfolioProjectionV22 projectionV22;

  final List<int> sparkline6m;

  final List<MonthlyBalancePoint> balanceSeries6m;

  DateTime? get targetDate => AppFormatters.parseIsoDate(portfolio.targetDate);
  bool get hasTarget =>
      portfolio.savedTarget != null && portfolio.savedTarget! > 0;
}

final portfolioSnapshotsProvider = Provider<List<PortfolioSnapshot>>((ref) {
  final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
  final contributions =
      ref.watch(contributionsStreamProvider).value ?? const [];
  final components = ref.watch(allComponentsStreamProvider).value ?? const [];
  final now = DateTime.now();

  final balanceByPortfolio = <String, int>{};
  final depositsByPortfolio = <String, List<({DateTime date, int amount})>>{};
  for (final c in contributions) {
    balanceByPortfolio[c.portfolioId] =
        (balanceByPortfolio[c.portfolioId] ?? 0) + c.amount;
    final dt = AppFormatters.parseIsoDate(c.date);
    if (dt != null) {
      depositsByPortfolio
          .putIfAbsent(c.portfolioId, () => [])
          .add((date: dt, amount: c.amount));
    }
  }

  final compsByPortfolio = <String, List<PortfolioComponent>>{};
  for (final comp in components) {
    compsByPortfolio.putIfAbsent(comp.portfolioId, () => []).add(comp);
  }

  return portfolios.map((p) {
    final balance = balanceByPortfolio[p.id] ?? 0;
    final pDeps = depositsByPortfolio[p.id] ?? const [];
    final pComps = compsByPortfolio[p.id] ?? const <PortfolioComponent>[];
    final compSummary = PlanoraCalc.componentsSummary(
      balance: balance,
      componentAmounts: pComps.map((c) => c.actualAmount),
    );
    final targetDate = AppFormatters.parseIsoDate(p.targetDate);
    final savedTarget = p.savedTarget;

    final remaining = savedTarget != null
        ? PlanoraCalc.remainingNeed(savedTarget: savedTarget, balance: balance)
        : 0;
    final progressPct = PlanoraCalc.progressPercent(
      savedTarget: savedTarget,
      balance: balance,
    );

    final req = savedTarget != null
        ? PlanoraCalc.requiredMonthlyDeposit(
            savedTarget: savedTarget,
            balance: balance,
            targetDate: targetDate,
            annualReturnPct: p.annualReturnPct,
            now: now,
          )
        : null;

    final est = savedTarget != null
        ? PlanoraCalc.estimateTargetDate(
            savedTarget: savedTarget,
            balance: balance,
            monthlyPlan: p.monthlyPlan,
            annualReturnPct: p.annualReturnPct,
            now: now,
          )
        : null;

    final status = PlanoraCalc.trackStatus(
      savedTarget: savedTarget,
      balance: balance,
      monthlyPlan: p.monthlyPlan,
      targetDate: targetDate,
      annualReturnPct: p.annualReturnPct,
      now: now,
    );

    final avgRate3m = PlanoraV22Calc.averageMonthlyDeposit3m(
      deposits: pDeps,
      now: now,
    );
    final projV22 = PlanoraV22Calc.evaluateStatusAndProjection(
      targetTotal: savedTarget,
      actualBalance: balance,
      hasAnyDeposit: pDeps.isNotEmpty,
      targetDate: targetDate,
      averageRate3m: avgRate3m,
      now: now,
    );

    final series6m = PlanoraV22Calc.buildMonthlyBalanceSeries(
      deposits: pDeps,
      months: 6,
      now: now,
    );

    return PortfolioSnapshot(
      portfolio: p,
      balance: balance,
      components: pComps,
      totalComponentsActual: compSummary.totalComponents,
      unallocatedBalance: compSummary.unallocated,
      remaining: remaining,
      progressPct: progressPct,
      requiredMonthly: req,
      estimatedDate: est,
      status: status,
      projectionV22: projV22,
      sparkline6m: series6m.map((e) => e.cumulativeBalance).toList(),
      balanceSeries6m: series6m,
    );
  }).toList();
});

class FinancialSummary {
  const FinancialSummary({
    required this.totalBalance,
    required this.totalTarget,
    required this.combinedProgressPct,
    required this.instrumentSubtotals,
    required this.monthlySalary,
    required this.minimumLivingCost,
    required this.currentLivingCost,
    required this.ceiling,
    required this.totalMonthlyPlan,
    required this.defaultAnnualReturnPct,
    required this.planLimitEnabled,
    required this.planLimitAmount,
    required this.componentInputMode,
    required this.quoteCardDismissedMonth,
  });

  final int totalBalance;
  final int totalTarget;
  final double combinedProgressPct;

  final Map<String, int> instrumentSubtotals;
  final int? monthlySalary;
  final int? minimumLivingCost;
  final int? currentLivingCost;
  final int? ceiling;
  final int totalMonthlyPlan;
  final double defaultAnnualReturnPct;
  final bool planLimitEnabled;
  final int? planLimitAmount;
  final String componentInputMode;
  final String? quoteCardDismissedMonth;

  bool get hasCeiling => ceiling != null;
  int? get remainingCeiling =>
      ceiling == null ? null : ceiling! - totalMonthlyPlan;
  bool get isOverCeiling => ceiling != null && totalMonthlyPlan > ceiling!;
  int get overCeilingBy => isOverCeiling ? totalMonthlyPlan - ceiling! : 0;
  int? get remainingSalaryAfterPlan =>
      monthlySalary == null ? null : monthlySalary! - totalMonthlyPlan;
}

final financialSummaryProvider = Provider<FinancialSummary>((ref) {
  final settings = ref.watch(settingsStreamProvider).value;
  final snapshots = ref.watch(portfolioSnapshotsProvider);
  final components = ref.watch(allComponentsStreamProvider).value ?? const [];

  final salary = settings?.monthlySalary;
  final minLiving = settings?.minimumLivingCost;
  final curLiving = settings?.currentLivingCost;
  final defaultReturn = settings?.defaultAnnualReturnPct ?? 5.0;
  final ceiling = PlanoraCalc.ceiling(
    monthlySalary: salary,
    minimumLivingCost: minLiving,
  );

  var totalBalance = 0;
  var totalTarget = 0;
  var totalPlan = 0;
  for (final snap in snapshots) {
    totalBalance += snap.balance;
    totalPlan += snap.portfolio.monthlyPlan;
    if (snap.hasTarget) {
      totalTarget += snap.portfolio.savedTarget!;
    }
  }
  final combinedPct = totalTarget > 0
      ? ((totalBalance / totalTarget) * 100.0).clamp(0.0, 100.0)
      : 0.0;

  final subtotals = <String, int>{};
  for (final comp in components) {
    if (comp.actualAmount <= 0) continue;
    final key = comp.instrumentType.trim();
    if (key.isEmpty) continue;
    subtotals[key] = (subtotals[key] ?? 0) + comp.actualAmount;
  }

  return FinancialSummary(
    totalBalance: totalBalance,
    totalTarget: totalTarget,
    combinedProgressPct: combinedPct,
    instrumentSubtotals: subtotals,
    monthlySalary: salary,
    minimumLivingCost: minLiving,
    currentLivingCost: curLiving,
    ceiling: ceiling,
    totalMonthlyPlan: totalPlan,
    defaultAnnualReturnPct: defaultReturn,
    planLimitEnabled: settings?.planLimitEnabled ?? false,
    planLimitAmount: settings?.planLimitAmount,
    componentInputMode: settings?.componentInputMode ?? 'percent',
    quoteCardDismissedMonth: settings?.quoteCardDismissedMonth,
  );
});

class DashboardDataV22 {
  const DashboardDataV22({
    required this.thisMonthDeposit,
    required this.lastMonthDeposit,
    required this.momDeltaAmount,
    required this.momDeltaPercent,
    required this.avg3MonthsDeposit,
    required this.streakMonths,
    required this.daysRemainingInMonth,
    required this.activePlanName,
    required this.activePlanTotal,
    required this.balanceSeries6m,
    required this.balanceSeries12m,
    required this.stackedBars6m,
    required this.insights,
    required this.recentActivities,
    required this.dailyQuote,
    required this.isQuoteDismissedThisMonth,
  });

  final int thisMonthDeposit;
  final int lastMonthDeposit;
  final int momDeltaAmount;
  final double? momDeltaPercent;
  final int avg3MonthsDeposit;
  final int streakMonths;
  final int daysRemainingInMonth;
  final String? activePlanName;
  final int activePlanTotal;
  final List<MonthlyBalancePoint> balanceSeries6m;
  final List<MonthlyBalancePoint> balanceSeries12m;
  final List<MonthlyStackedBarData> stackedBars6m;
  final List<DashboardInsight> insights;
  final List<({Contribution contribution, Portfolio? portfolio})>
      recentActivities;
  final String dailyQuote;
  final bool isQuoteDismissedThisMonth;
}

final dashboardDataProvider = Provider<DashboardDataV22>((ref) {
  final snapshots = ref.watch(portfolioSnapshotsProvider);
  final contributions =
      ref.watch(contributionsStreamProvider).value ?? const [];
  final plans = ref.watch(plansWithAllocationsProvider);
  final summary = ref.watch(financialSummaryProvider);
  final now = DateTime.now();

  final portoById = {for (final s in snapshots) s.portfolio.id: s.portfolio};
  final parsedDeposits = <({DateTime date, int amount, String portfolioId})>[];
  for (final c in contributions) {
    final dt = AppFormatters.parseIsoDate(c.date);
    if (dt != null) {
      parsedDeposits.add((date: dt, amount: c.amount, portfolioId: c.portfolioId));
    }
  }

  final thisMonthStart = DateTime(now.year, now.month, 1);
  final lastMonthStart = DateTime(now.year, now.month - 1, 1);
  var thisMonthDeposit = 0;
  var lastMonthDeposit = 0;
  for (final d in parsedDeposits) {
    if (d.amount <= 0) continue;
    if (d.date.year == thisMonthStart.year &&
        d.date.month == thisMonthStart.month) {
      thisMonthDeposit += d.amount;
    } else if (d.date.year == lastMonthStart.year &&
        d.date.month == lastMonthStart.month) {
      lastMonthDeposit += d.amount;
    }
  }

  final momDeltaAmount = thisMonthDeposit - lastMonthDeposit;
  final momDeltaPercent = lastMonthDeposit > 0
      ? PlanoraV22Calc.round2((momDeltaAmount / lastMonthDeposit) * 100.0)
      : null;

  final avg3m = PlanoraV22Calc.averageMonthlyDeposit3m(
    deposits: parsedDeposits.map((e) => (date: e.date, amount: e.amount)),
    now: now,
  );
  final streak = PlanoraV22Calc.calculateMonthlyStreak(
    depositDates:
        parsedDeposits.where((e) => e.amount > 0).map((e) => e.date),
    now: now,
  );

  final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
  final daysRemaining = (lastDayOfMonth - now.day).clamp(0, 31);

  final activePlan = plans.where((p) => p.plan.isActive).firstOrNull;
  final activePlanTotal = activePlan != null
      ? activePlan.totalMonthly
      : summary.totalMonthlyPlan;

  final series6m = PlanoraV22Calc.buildMonthlyBalanceSeries(
    deposits: parsedDeposits.map((e) => (date: e.date, amount: e.amount)),
    months: 6,
    now: now,
  );
  final series12m = PlanoraV22Calc.buildMonthlyBalanceSeries(
    deposits: parsedDeposits.map((e) => (date: e.date, amount: e.amount)),
    months: 12,
    now: now,
  );

  final stackedBars = <MonthlyStackedBarData>[];
  for (var i = 5; i >= 0; i--) {
    final m = DateTime(now.year, now.month - i, 1);
    final byPorto = <String, int>{};
    for (final d in parsedDeposits) {
      if (d.amount <= 0) continue;
      if (d.date.year == m.year && d.date.month == m.month) {
        byPorto[d.portfolioId] = (byPorto[d.portfolioId] ?? 0) + d.amount;
      }
    }
    final segs = byPorto.entries.map((e) {
      final p = portoById[e.key];
      return (
        label: p?.name ?? 'Porto',
        amount: e.value,
        color: Color(p?.color ?? 0xFF0E7C66),
      );
    }).toList();
    stackedBars.add(MonthlyStackedBarData(month: m, segments: segs));
  }

  final insights = PlanoraV22Calc.generateInsights(
    portfolios: snapshots
        .map(
          (s) => (
            id: s.portfolio.id,
            name: s.portfolio.name,
            balance: s.balance,
            targetTotal: s.portfolio.savedTarget,
            progressPct: s.progressPct,
            projection: s.projectionV22,
            components: s.components
                .map(
                  (c) => (
                    instrument: c.instrumentType,
                    targetPct: c.targetPercent,
                    actualAmount: c.actualAmount,
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
    hasDepositThisMonth: thisMonthDeposit > 0,
    activePhaseName: activePlan?.plan.name,
    activePhaseTotal: activePlanTotal,
    streakMonths: streak,
    now: now,
    formatRupiah: AppFormatters.rupiah,
  );

  final recent = contributions
      .take(5)
      .map((c) => (contribution: c, portfolio: portoById[c.portfolioId]))
      .toList();

  final currentYm = AppFormatters.toYearMonth(now);
  final quoteDismissed = summary.quoteCardDismissedMonth == currentYm;

  return DashboardDataV22(
    thisMonthDeposit: thisMonthDeposit,
    lastMonthDeposit: lastMonthDeposit,
    momDeltaAmount: momDeltaAmount,
    momDeltaPercent: momDeltaPercent,
    avg3MonthsDeposit: avg3m,
    streakMonths: streak,
    daysRemainingInMonth: daysRemaining,
    activePlanName: activePlan?.plan.name,
    activePlanTotal: activePlanTotal,
    balanceSeries6m: series6m,
    balanceSeries12m: series12m,
    stackedBars6m: stackedBars,
    insights: insights,
    recentActivities: recent,
    dailyQuote: PlanoraV22Calc.dailyQuote(now),
    isQuoteDismissedThisMonth: quoteDismissed,
  );
});

class ChecklistRow {
  const ChecklistRow({
    required this.portfolio,
    required this.monthlyPlan,
    required this.deposited,
  });

  final Portfolio portfolio;
  final int monthlyPlan;
  final int deposited;

  bool get isCompleted => monthlyPlan > 0 && deposited >= monthlyPlan;
  bool get isPartial => deposited > 0 && deposited < monthlyPlan;
}

final monthlyChecklistProvider =
    Provider.family<List<ChecklistRow>, DateTime>((ref, month) {
  final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
  final contributions =
      ref.watch(contributionsStreamProvider).value ?? const [];

  final depositedByPortfolio = <String, int>{};
  for (final c in contributions) {
    if (c.amount <= 0) continue;
    final dt = AppFormatters.parseIsoDate(c.date);
    if (dt == null) continue;
    if (dt.year == month.year && dt.month == month.month) {
      depositedByPortfolio[c.portfolioId] =
          (depositedByPortfolio[c.portfolioId] ?? 0) + c.amount;
    }
  }

  return portfolios
      .where((p) => p.monthlyPlan > 0)
      .map(
        (p) => ChecklistRow(
          portfolio: p,
          monthlyPlan: p.monthlyPlan,
          deposited: depositedByPortfolio[p.id] ?? 0,
        ),
      )
      .toList();
});

final plansWithAllocationsProvider =
    Provider<List<PlanWithAllocations>>((ref) {
  final plans = ref.watch(plansStreamProvider).value ?? const [];
  final allocations =
      ref.watch(planAllocationsStreamProvider).value ?? const [];

  final byPlan = <String, Map<String, int>>{};
  final fixedByPlan = <String, Map<String, int>>{};
  for (final a in allocations) {
    byPlan.putIfAbsent(a.planId, () => <String, int>{})[a.portfolioId] =
        a.sharePercentX100;
    if (a.fixedAmount != null) {
      fixedByPlan.putIfAbsent(a.planId, () => <String, int>{})[a.portfolioId] =
          a.fixedAmount!;
    }
  }

  return plans.map((pl) {
    final shareMap = byPlan[pl.id] ?? const <String, int>{};
    final fixedMap = fixedByPlan[pl.id];
    final fixedSum =
        fixedMap?.values.fold<int>(0, (sum, v) => sum + v) ?? -1;
    final useExactFixed = fixedMap != null &&
        fixedMap.length == shareMap.length &&
        shareMap.isNotEmpty &&
        fixedSum == pl.totalAmount;

    final derived = useExactFixed
        ? fixedMap
        : PlanPercentCalc.computeAmountsFromPercents(
            totalAmount: pl.totalAmount,
            sharePercentX100ById: shareMap,
          );
    return PlanWithAllocations(
      plan: pl,
      sharePercentX100ByPortfolioId: shareMap,
      derivedAmountsByPortfolioId: derived,
      fixedAmountsByPortfolioId: useExactFixed ? fixedMap : null,
    );
  }).toList();
});

final hideAmountsProvider = Provider<bool>((ref) {
  final hide = ref.watch(settingsStreamProvider).value?.hideAmounts ?? false;
  AppFormatters.hideAmounts = hide;
  return hide;
});

final globalCompositionProvider = Provider<GlobalCompositionSummary>((ref) {
  final snapshots = ref.watch(portfolioSnapshotsProvider);
  final stockTxs =
      ref.watch(allStockTransactionsStreamProvider).value ?? const [];

  final inputs = <GlobalComponentInput>[];
  for (final snap in snapshots) {
    final p = snap.portfolio;
    final isNoTarget = p.category == 'no_target' ||
        p.savedTarget == null ||
        p.savedTarget! <= 0;
    for (final c in snap.components) {
      inputs.add(
        GlobalComponentInput(
          portfolioId: p.id,
          portfolioName: p.name,
          portfolioColor: p.color,
          isNoTarget: isNoTarget,
          portfolioTargetTotal: p.savedTarget ?? 0,
          instrumentType: c.instrumentType,
          actualAmount: c.actualAmount,
          targetPercent: c.targetPercent,
          isLotBased: c.mechanism == StockLotCalc.mechanismLotBased,
        ),
      );
    }
  }

  final txRecords = stockTxs
      .map(
        (t) => StockTxRecord(
          id: t.id,
          ticker: t.ticker,
          side: t.side,
          lots: t.lots,
          shares: t.shares,
          pricePerShare: t.pricePerShare,
          totalAmount: t.totalAmount,
          transactionDate: t.transactionDate,
          createdAt: t.createdAt,
        ),
      )
      .toList();

  return GlobalCompositionCalc.compute(
    components: inputs,
    allStockTransactions: txRecords,
  );
});

