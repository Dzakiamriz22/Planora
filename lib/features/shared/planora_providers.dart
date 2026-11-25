import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/phase_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/profile_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';

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

final phasesStreamProvider = StreamProvider<List<Phase>>((ref) {
  return ref.watch(phaseRepositoryProvider).watchPhases();
});

final phaseAllocationsStreamProvider =
    StreamProvider<List<PhaseAllocation>>((ref) {
  return ref.watch(phaseRepositoryProvider).watchAllAllocations();
});

final priceReferencesStreamProvider =
    StreamProvider<List<PriceReference>>((ref) {
  return ref.watch(settingsRepositoryProvider).watchPriceReferences();
});

class PortfolioSnapshot {
  const PortfolioSnapshot({
    required this.portfolio,
    required this.balance,
    required this.components,
    required this.totalComponents,
    required this.unallocatedBalance,
    required this.remaining,
    required this.progressPct,
    required this.requiredMonthly,
    required this.estimatedDate,
    required this.status,
  });

  final Portfolio portfolio;
  final int balance;
  final List<PortfolioComponent> components;
  final int totalComponents;
  final int unallocatedBalance;
  final int remaining;
  final double progressPct;
  final RequiredMonthlyResult? requiredMonthly;
  final TargetDateEstimate? estimatedDate;
  final GoalTrackStatus status;

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
  for (final c in contributions) {
    balanceByPortfolio[c.portfolioId] =
        (balanceByPortfolio[c.portfolioId] ?? 0) + c.amount;
  }

  final compsByPortfolio = <String, List<PortfolioComponent>>{};
  for (final comp in components) {
    compsByPortfolio.putIfAbsent(comp.portfolioId, () => []).add(comp);
  }

  return portfolios.map((p) {
    final balance = balanceByPortfolio[p.id] ?? 0;
    final pComps = compsByPortfolio[p.id] ?? const <PortfolioComponent>[];
    final compSummary = PlanoraCalc.componentsSummary(
      balance: balance,
      componentAmounts: pComps.map((c) => c.amount),
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

    return PortfolioSnapshot(
      portfolio: p,
      balance: balance,
      components: pComps,
      totalComponents: compSummary.totalComponents,
      unallocatedBalance: compSummary.unallocated,
      remaining: remaining,
      progressPct: progressPct,
      requiredMonthly: req,
      estimatedDate: est,
      status: status,
    );
  }).toList();
});

class FinancialSummary {
  const FinancialSummary({
    required this.totalBalance,
    required this.instrumentSubtotals,
    required this.monthlySalary,
    required this.minimumLivingCost,
    required this.currentLivingCost,
    required this.ceiling,
    required this.totalMonthlyPlan,
    required this.defaultAnnualReturnPct,
    required this.phaseLimitEnabled,
    required this.phaseLimitAmount,
  });

  final int totalBalance;

  /// Subtotal dinamis per jenis instrumen yang benar-benar dipakai (FR-28).
  final Map<String, int> instrumentSubtotals;
  final int? monthlySalary;
  final int? minimumLivingCost;
  final int? currentLivingCost;
  final int? ceiling;
  final int totalMonthlyPlan;
  final double defaultAnnualReturnPct;
  final bool phaseLimitEnabled;
  final int? phaseLimitAmount;

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
  var totalPlan = 0;
  for (final snap in snapshots) {
    totalBalance += snap.balance;
    totalPlan += snap.portfolio.monthlyPlan;
  }

  // Subtotal dinamis per jenis instrumen saja (FR-28: tanpa subtotal bernama platform)
  final subtotals = <String, int>{};
  for (final comp in components) {
    if (comp.amount <= 0) continue;
    final key = comp.instrumentType.trim();
    if (key.isEmpty) continue;
    subtotals[key] = (subtotals[key] ?? 0) + comp.amount;
  }

  return FinancialSummary(
    totalBalance: totalBalance,
    instrumentSubtotals: subtotals,
    monthlySalary: salary,
    minimumLivingCost: minLiving,
    currentLivingCost: curLiving,
    ceiling: ceiling,
    totalMonthlyPlan: totalPlan,
    defaultAnnualReturnPct: defaultReturn,
    phaseLimitEnabled: settings?.phaseLimitEnabled ?? false,
    phaseLimitAmount: settings?.phaseLimitAmount,
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

final phasesWithAllocationsProvider =
    Provider<List<PhaseWithAllocations>>((ref) {
  final phases = ref.watch(phasesStreamProvider).value ?? const [];
  final allocations =
      ref.watch(phaseAllocationsStreamProvider).value ?? const [];

  final byPhase = <String, Map<String, int>>{};
  for (final a in allocations) {
    byPhase.putIfAbsent(a.phaseId, () => <String, int>{})[a.portfolioId] =
        a.monthlyAmount;
  }

  return phases
      .map(
        (ph) => PhaseWithAllocations(
          phase: ph,
          allocations: byPhase[ph.id] ?? const {},
        ),
      )
      .toList();
});
