import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/global_composition_calc.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/cashflow/cash_flow_entry_sheet.dart';
import 'package:planora/features/home/global_composition_card.dart';
import 'package:planora/features/portfolios/contribution_sheet.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/planora_logo.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rebalance_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  int _chartMonths = 6; // 6 atau 12 bulan (Bab 6)
  String _chartKind = 'area'; // 'area' | 'stacked'

  void _shiftMonth(int delta) {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + delta);
    });
  }

  Future<void> _toggleHideAmounts(bool nextValue) async {
    await ref.read(settingsRepositoryProvider).setHideAmounts(nextValue);
    final updated = await ref.read(settingsRepositoryProvider).getSettings();
    final activePlan = ref
        .read(plansWithAllocationsProvider)
        .where((p) => p.plan.isActive)
        .firstOrNull;
    await ref.read(reminderServiceProvider).syncSchedules(
          setting: updated,
          activePlanName: activePlan?.plan.name,
          activePlanTotal: activePlan?.totalMonthly ?? 0,
        );
  }

  Future<void> _showScaleDownDialog(
    List<PortfolioSnapshot> snapshots,
    FinancialSummary summary,
  ) async {
    final ceiling = summary.ceiling;
    if (ceiling == null) return;

    final result = PlanoraCalc.scaleAllToCeiling(
      items: snapshots
          .map(
            (s) => RebalanceItem(
              id: s.portfolio.id,
              name: s.portfolio.name,
              currentAmount: s.portfolio.monthlyPlan,
            ),
          )
          .toList(),
      ceilingAmount: ceiling,
    );

    final approved = await showRebalancePreviewDialog(
      context,
      result: result,
      ceilingAmount: ceiling,
      title: 'Sesuaikan Rencana ke Batas Nabung',
      subtitle:
          'Total rencana saat ini melebihi batas nabung sebesar ${AppFormatters.rupiah(summary.overCeilingBy)}. Seluruh porto akan diturunkan secara proporsional agar sesuai batas ${AppFormatters.rupiah(ceiling)}.',
    );
    if (!approved) return;

    final updatedPlans = {
      for (final ch in result.changes) ch.id: ch.newAmount,
    };
    await ref.read(portfolioRepositoryProvider).applyMonthlyPlans(updatedPlans);
    await ref.read(planRepositoryProvider).scaleActivePlanToCeiling(ceiling);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rencana setoran berhasil disesuaikan ke batas aman.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(financialSummaryProvider);
    final snapshots = ref.watch(portfolioSnapshotsProvider);
    final dashboard = ref.watch(dashboardDataProvider);
    final globalComp = ref.watch(globalCompositionProvider);
    final cashFlowNow = ref.watch(currentMonthCashFlowProvider);
    final hideAmounts = ref.watch(hideAmountsProvider);
    final profile = ref.watch(userProfileStreamProvider).value;
    final setting = ref.watch(settingsStreamProvider).value;
    final notifAllowed =
        ref.watch(notificationPermissionStatusProvider).value ?? false;
    final checklist = ref.watch(monthlyChecklistProvider(_selectedMonth));
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();

    final nickName = profile?.displayName?.trim();
    final greeting =
        (nickName != null && nickName.isNotEmpty) ? 'Halo, $nickName' : 'Halo';

    if (snapshots.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            children: [
              _HeaderRow(
                greeting: greeting,
                todayLabel: AppFormatters.shortDate(now),
                profile: profile,
                progressPercent: null,
                onTapProfile: () => context.push('/profile'),
                onTapHistory: () => context.push('/history'),
              ),
              const SizedBox(height: 36),
              PlanoraCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 28,
                ),
                child: Column(
                  children: [
                    const PlanoraLogo(size: 72),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada portofolio',
                      textAlign: TextAlign.center,
                      style: AppTheme.sora(
                        size: 16.5,
                        weight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Buat portofolio pertama untuk mulai mencatat target dan setoran.',
                      textAlign: TextAlign.center,
                      style: AppTheme.manrope(
                        size: 12.5,
                        color: cs.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => context.push('/portfolios/new'),
                        child: const Text('Buat porto pertama'),
                      ),
                    ),
                    if (!summary.hasCeiling) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => context.go('/settings'),
                          child: const Text('Atur Gaji & Biaya Hidup'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final completedCount = checklist.where((r) => r.isCompleted).length;
    final ceiling = summary.ceiling;
    final ceilingRatio = (ceiling != null && ceiling > 0)
        ? (summary.totalMonthlyPlan / ceiling).clamp(0.0, 1.0)
        : 0.0;

    final sortedInstruments = summary.instrumentSubtotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final ceilingChip = ceiling == null
        ? PlanoraPill.gray('Belum diatur')
        : (summary.isOverCeiling
            ? PlanoraPill.danger('Melebihi batas')
            : (summary.remainingCeiling == 0
                ? PlanoraPill.green('Pas batas')
                : PlanoraPill.green('Dalam batas')));

    final areaPoints = _chartMonths == 12
        ? dashboard.balanceSeries12m
        : dashboard.balanceSeries6m;

    final momText = dashboard.momDeltaAmount == 0
        ? 'Sama dengan bulan lalu'
        : (dashboard.momDeltaAmount > 0
            ? '+${AppFormatters.rupiah(dashboard.momDeltaAmount)}'
            : AppFormatters.rupiah(dashboard.momDeltaAmount));
    final momPctText = dashboard.momDeltaPercent != null
        ? ' (${dashboard.momDeltaPercent! >= 0 ? '+' : ''}${PlanoraV22Calc.formatPercent(dashboard.momDeltaPercent!)})'
        : '';
    final momSummary = dashboard.momDeltaAmount == 0
        ? 'Sama seperti bulan lalu'
        : '$momText$momPctText vs bulan lalu';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          children: [
            _HeaderRow(
              greeting: greeting,
              todayLabel: AppFormatters.shortDate(now),
              profile: profile,
              progressPercent:
                  summary.totalTarget > 0 ? summary.combinedProgressPct : null,
              onTapProfile: () => context.push('/profile'),
              onTapHistory: () => context.push('/history'),
            ),

            const SizedBox(height: 14),

            _TotalBalanceCard(
              totalBalance: summary.totalBalance,
              totalTarget: summary.totalTarget,
              combinedPct: summary.combinedProgressPct,
              thisMonthDeposit: dashboard.thisMonthDeposit,
              momLabel: momSummary,
              instrumentSubtotals: sortedInstruments,
              globalSlices: globalComp.slices,
              hideAmounts: hideAmounts,
              onToggleHideAmounts: () => _toggleHideAmounts(!hideAmounts),
            ),

            if (!globalComp.isEmpty) ...[
              const SizedBox(height: 12),
              GlobalCompositionCard(
                composition: globalComp,
                hideAmounts: hideAmounts,
                onTapPortfolio: (pid) => context.push('/portfolios/$pid'),
              ),
            ],

            const SizedBox(height: 12),

            // Kartu kecil Arus Kas Bulan Ini (v3.3)
            PlanoraCard(
              key: const Key('home_cashflow_card'),
              onTap: () => context.go('/cashflow'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Arus Kas Bulan Ini',
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => showCashFlowEntrySheet(context),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Catat'),
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masuk',
                              style: AppTheme.manrope(
                                size: 11,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              AppFormatters.rupiah(cashFlowNow.incomeActual),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.manrope(
                                size: 12.5,
                                weight: FontWeight.w800,
                                color: PlanoraColors.primary,
                                tabular: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Keluar',
                              style: AppTheme.manrope(
                                size: 11,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              AppFormatters.rupiah(cashFlowNow.expenseActual),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.manrope(
                                size: 12.5,
                                weight: FontWeight.w800,
                                color: PlanoraColors.danger,
                                tabular: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Sisa Kas',
                              style: AppTheme.manrope(
                                size: 11,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              AppFormatters.rupiah(cashFlowNow.remainingCash),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.manrope(
                                size: 12.5,
                                weight: FontWeight.w800,
                                color: cashFlowNow.remainingCash < 0
                                    ? PlanoraColors.danger
                                    : cs.onSurface,
                                tabular: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            PlanoraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _chartKind == 'area'
                              ? 'Pertumbuhan Saldo'
                              : 'Setoran Bulanan',
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      if (_chartKind == 'area')
                        _SmallRangeToggle(
                          options: const [('6 Bln', 6), ('12 Bln', 12)],
                          selected: _chartMonths,
                          onSelect: (v) => setState(() => _chartMonths = v),
                        ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () => setState(
                          () => _chartKind =
                              _chartKind == 'area' ? 'stacked' : 'area',
                        ),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            _chartKind == 'area'
                                ? Icons.bar_chart_rounded
                                : Icons.show_chart_rounded,
                            size: 18,
                            color: cs.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_chartKind == 'area')
                    PlanoraBalanceAreaChart(
                      points: areaPoints,
                      height: 168,
                    )
                  else
                    PlanoraMonthlyStackedBarChart(
                      bars: dashboard.stackedBars6m,
                      height: 168,
                      onMonthTap: (_) => context.push('/history'),
                    ),
                ],
              ),
            ),

            if (setting != null &&
                setting.reminderMonthlyEnabled &&
                !notifAllowed) ...[
              const SizedBox(height: 12),
              PlanoraNoteBox(
                isWarning: true,
                child: Row(
                  key: const Key('in_app_reminder_card'),
                  children: [
                    const Icon(
                      Icons.notifications_off_outlined,
                      size: 18,
                      color: PlanoraColors.gold,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengingat Setoran Bulanan',
                            style: AppTheme.manrope(
                              size: 12.5,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          Text(
                            'Jadwal tanggal ${setting.reminderMonthlyDay} pukul ${setting.reminderMonthlyHour.toString().padLeft(2, '0')}.${setting.reminderMonthlyMinute.toString().padLeft(2, '0')} · Notifikasi belum aktif, tampil di sini.',
                            style: AppTheme.manrope(
                              size: 12,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/settings'),
                      child: const Text('Atur'),
                    ),
                  ],
                ),
              ),
            ],

            if (dashboard.insights.isNotEmpty) ...[
              const SizedBox(height: 12),
              _InsightsSection(
                insights: dashboard.insights,
                onTapPortfolio: (pid) => context.push('/portfolios/$pid'),
              ),
            ],

            const SizedBox(height: 12),

            PlanoraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Progres Bulan Ini',
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      PlanoraPill.gray(
                        'Sisa ${dashboard.daysRemainingInMonth} hari',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            dashboard.activePlanName ?? 'Belum ada Plan aktif',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.manrope(
                              size: 12,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${AppFormatters.rupiah(dashboard.thisMonthDeposit)} / ${AppFormatters.rupiah(dashboard.activePlanTotal)}',
                          style: AppTheme.manrope(
                            size: 12,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                            tabular: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    PlanoraProgressBar(
                      value: dashboard.activePlanTotal > 0
                          ? (dashboard.thisMonthDeposit /
                                  dashboard.activePlanTotal)
                              .clamp(0.0, 1.0)
                          : (dashboard.thisMonthDeposit > 0 ? 1.0 : 0.0),
                      color: dashboard.thisMonthDeposit >=
                                  dashboard.activePlanTotal &&
                              dashboard.activePlanTotal > 0
                          ? PlanoraChartTokens.chartMoney
                          : PlanoraColors.primary,
                      height: 7,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Batas Tabungan Bulanan',
                            style: AppTheme.manrope(
                              size: 12,
                              weight: FontWeight.w700,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                        ceilingChip,
                      ],
                    ),
                  if (ceiling != null) ...[
                    const SizedBox(height: 6),
                    PlanoraProgressBar(
                      value: ceilingRatio,
                      color: summary.isOverCeiling
                          ? PlanoraColors.danger
                          : PlanoraColors.greenBright,
                      height: 6,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rencana ${AppFormatters.rupiah(summary.totalMonthlyPlan)}',
                          style: AppTheme.manrope(
                            size: 11.5,
                            color: cs.onSurfaceVariant,
                            tabular: true,
                          ),
                        ),
                        Text(
                          'Batas ${AppFormatters.rupiah(ceiling)}/bln',
                          style: AppTheme.manrope(
                            size: 11.5,
                            weight: FontWeight.w700,
                            color: cs.onSurface,
                            tabular: true,
                          ),
                        ),
                      ],
                    ),
                    if (summary.isOverCeiling) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: PlanoraColors.danger,
                            side: const BorderSide(color: PlanoraColors.danger),
                          ),
                          onPressed: () =>
                              _showScaleDownDialog(snapshots, summary),
                          child: const Text(
                            'Sesuaikan Rencana ke Batas Nabung',
                          ),
                        ),
                      ),
                    ],
                  ] else ...[
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () => context.go('/settings'),
                      child: Text(
                        'Atur gaji & biaya hidup untuk batas nabung otomatis →',
                        style: AppTheme.manrope(
                          size: 12,
                          weight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            PlanoraCard(
              child: Row(
                children: [
                  Expanded(
                    child: _MetricTile(
                      label: 'Streak',
                      value: '${dashboard.streakMonths} bln',
                      icon: Icons.local_fire_department_outlined,
                      accent: PlanoraColors.gold,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: cs.outlineVariant,
                  ),
                  Expanded(
                    child: _MetricTile(
                      label: 'Bulan Ini',
                      value: PlanoraChartTokens.compactRupiah(
                        dashboard.thisMonthDeposit,
                      ),
                      icon: Icons.savings_outlined,
                      accent: PlanoraChartTokens.chartMoney,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: cs.outlineVariant,
                  ),
                  Expanded(
                    child: _MetricTile(
                      label: 'Rata-rata 3 Bln',
                      value: PlanoraChartTokens.compactRupiah(
                        dashboard.avg3MonthsDeposit,
                      ),
                      icon: Icons.trending_up_rounded,
                      accent: PlanoraChartTokens.chartBond,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            if (checklist.isNotEmpty) ...[
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Setoran Bulan Ini',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _shiftMonth(-1),
                          borderRadius: BorderRadius.circular(8),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.chevron_left, size: 18),
                          ),
                        ),
                        PlanoraPill.gray(
                          '$completedCount dari ${checklist.length}',
                        ),
                        if (_selectedMonth.year != now.year ||
                            _selectedMonth.month != now.month)
                          InkWell(
                            onTap: () => _shiftMonth(1),
                            borderRadius: BorderRadius.circular(8),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.chevron_right, size: 18),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    for (var i = 0; i < checklist.length; i++) ...[
                      if (i > 0) const Divider(),
                      _ChecklistRowTile(
                        row: checklist[i],
                        onTap: () => showContributionSheet(
                          context,
                          ref: ref,
                          portfolioId: checklist[i].portfolio.id,
                          portfolioName: checklist[i].portfolio.name,
                          suggestedAmount: checklist[i].isCompleted
                              ? checklist[i].monthlyPlan
                              : (checklist[i].monthlyPlan -
                                      checklist[i].deposited)
                                  .clamp(0, checklist[i].monthlyPlan),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            PlanoraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Proyeksi Capaian',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/portfolios'),
                        child: Text(
                          'Lihat Porto',
                          style: AppTheme.manrope(
                            size: 12,
                            weight: FontWeight.w700,
                            color: cs.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (var i = 0; i < snapshots.length; i++) ...[
                    if (i > 0) const Divider(),
                    _ProjectionRow(
                      snapshot: snapshots[i],
                      onTap: () => context
                          .push('/portfolios/${snapshots[i].portfolio.id}'),
                    ),
                  ],
                ],
              ),
            ),

            if (dashboard.recentActivities.isNotEmpty) ...[
              const SizedBox(height: 12),
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktivitas Terakhir',
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                        InkWell(
                          onTap: () => context.push('/history'),
                          child: Text(
                            'Semua',
                            style: AppTheme.manrope(
                              size: 12,
                              weight: FontWeight.w700,
                              color: cs.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    for (var i = 0;
                        i < dashboard.recentActivities.length;
                        i++) ...[
                      if (i > 0) const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Row(
                          children: [
                            PortfolioDot(
                              color: Color(
                                dashboard.recentActivities[i].portfolio
                                        ?.color ??
                                    0xFF0E7C66,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dashboard.recentActivities[i].portfolio
                                            ?.name ??
                                        'Porto',
                                    style: AppTheme.manrope(
                                      size: 12.5,
                                      weight: FontWeight.w700,
                                      color: cs.onSurface,
                                    ),
                                  ),
                                  Text(
                                    AppFormatters.shortDate(
                                      AppFormatters.parseIsoDate(
                                            dashboard.recentActivities[i]
                                                .contribution.date,
                                          ) ??
                                          now,
                                    ),
                                    style: AppTheme.manrope(
                                      size: 11,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              dashboard.recentActivities[i].contribution.amount < 0
                                  ? '− ${AppFormatters.rupiah(dashboard.recentActivities[i].contribution.amount.abs())}'
                                  : '+ ${AppFormatters.rupiah(dashboard.recentActivities[i].contribution.amount)}',
                              style: AppTheme.manrope(
                                size: 12.5,
                                weight: FontWeight.w800,
                                color: dashboard.recentActivities[i]
                                            .contribution.amount <
                                        0
                                    ? PlanoraColors.danger
                                    : (isDark
                                        ? PlanoraChartTokens.chartMoney
                                        : PlanoraColors.primary),
                                tabular: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],

            if (!dashboard.isQuoteDismissedThisMonth) ...[
              const SizedBox(height: 12),
              PlanoraNoteBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 18,
                      color: cs.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catatan Hari Ini',
                            style: AppTheme.manrope(
                              size: 11,
                              weight: FontWeight.w800,
                              color: cs.primary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            dashboard.dailyQuote,
                            style: AppTheme.manrope(
                              size: 12,
                              color: cs.onSurface,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Tutup catatan bulan ini',
                      onPressed: () {
                        ref
                            .read(settingsRepositoryProvider)
                            .dismissQuoteForMonth(
                              AppFormatters.toYearMonth(now),
                            );
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 17,
                        color: cs.onSurfaceVariant,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.greeting,
    required this.todayLabel,
    required this.profile,
    required this.progressPercent,
    required this.onTapProfile,
    required this.onTapHistory,
  });

  final String greeting;
  final String todayLabel;
  final UserProfile? profile;
  final double? progressPercent;
  final VoidCallback onTapProfile;
  final VoidCallback onTapHistory;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final nick = profile?.displayName?.trim() ?? '';
    final hasPhoto = profile?.avatarPath != null &&
        profile!.avatarPath!.isNotEmpty &&
        File(profile!.avatarPath!).existsSync();

    return Row(
      children: [
        InkWell(
          onTap: onTapProfile,
          borderRadius: BorderRadius.circular(24),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: PlanoraColors.primary,
            backgroundImage:
                hasPhoto ? FileImage(File(profile!.avatarPath!)) : null,
            child: hasPhoto
                ? null
                : (nick.isNotEmpty
                    ? Text(
                        nick.substring(0, 1).toUpperCase(),
                        style: AppTheme.sora(
                          size: 15,
                          weight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.person_outline,
                        size: 20,
                        color: Colors.white,
                      )),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: onTapProfile,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.sora(
                    size: 16,
                    weight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
                Text(
                  todayLabel,
                  style: AppTheme.manrope(
                    size: 11.5,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (progressPercent != null) ...[
          PlanoraProgressRing(
            progressPercent: progressPercent!,
            size: 40,
            strokeWidth: 4,
            color: PlanoraColors.primary,
          ),
          const SizedBox(width: 6),
        ],
        PlanoraAppBarIconButton(
          icon: Icons.history_rounded,
          tooltip: 'Riwayat setoran global',
          onPressed: onTapHistory,
        ),
      ],
    );
  }
}

class _TotalBalanceCard extends StatelessWidget {
  const _TotalBalanceCard({
    required this.totalBalance,
    required this.totalTarget,
    required this.combinedPct,
    required this.thisMonthDeposit,
    required this.momLabel,
    required this.instrumentSubtotals,
    required this.globalSlices,
    required this.hideAmounts,
    required this.onToggleHideAmounts,
  });

  final int totalBalance;
  final int totalTarget;
  final double combinedPct;
  final int thisMonthDeposit;
  final String momLabel;
  final List<MapEntry<String, int>> instrumentSubtotals;
  final List<GlobalInstrumentSlice> globalSlices;
  final bool hideAmounts;
  final VoidCallback onToggleHideAmounts;

  @override
  Widget build(BuildContext context) {
    final pctByNorm = {
      for (final s in globalSlices)
        s.instrumentType.trim().toLowerCase(): s.actualPercent,
    };

    return Container(
      decoration: BoxDecoration(
        color: PlanoraColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -28,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'TOTAL SALDO PORTOFOLIO',
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.uppercaseLabel(
                          color: PlanoraColors.balanceLabel,
                        ),
                      ),
                    ),
                    if (totalTarget > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${PlanoraV22Calc.formatPercent(combinedPct)} dari target',
                          style: AppTheme.manrope(
                            size: 10.5,
                            weight: FontWeight.w700,
                            color: Colors.white,
                            tabular: true,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppFormatters.rupiah(totalBalance),
                        style: AppTheme.sora(
                          size: 25,
                          weight: FontWeight.w800,
                          color: PlanoraColors.balanceText,
                          tabular: true,
                        ),
                      ),
                    ),
                    IconButton(
                      key: const Key('privacy_toggle_button'),
                      tooltip: hideAmounts
                          ? 'Tampilkan nominal'
                          : 'Sembunyikan nominal',
                      onPressed: onToggleHideAmounts,
                      icon: Icon(
                        hideAmounts
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 21,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  totalTarget > 0
                      ? 'Target gabungan ${AppFormatters.rupiah(totalTarget)} · $momLabel'
                      : momLabel,
                  style: AppTheme.manrope(
                    size: 11.5,
                    color: PlanoraColors.balanceLabel,
                    tabular: true,
                  ),
                ),
                if (instrumentSubtotals.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: instrumentSubtotals.map((entry) {
                      final pct =
                          pctByNorm[entry.key.trim().toLowerCase()] ?? 0.0;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pct > 0
                                  ? '${entry.key.toUpperCase()} · ${PlanoraV22Calc.formatPercent(pct)}'
                                  : entry.key.toUpperCase(),
                              style: AppTheme.manrope(
                                size: 9.5,
                                weight: FontWeight.w700,
                                color: PlanoraColors.balanceLabel,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              AppFormatters.rupiah(entry.value),
                              style: AppTheme.manrope(
                                size: 12.5,
                                weight: FontWeight.w800,
                                color: Colors.white,
                                tabular: true,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightsSection extends StatelessWidget {
  const _InsightsSection({
    required this.insights,
    required this.onTapPortfolio,
  });

  final List<DashboardInsight> insights;
  final void Function(String portfolioId) onTapPortfolio;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < insights.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _buildInsightCard(context, cs, insights[i]),
        ],
      ],
    );
  }

  Widget _buildInsightCard(
    BuildContext context,
    ColorScheme cs,
    DashboardInsight item,
  ) {
    final (icon, accent) = switch (item.kind) {
      DashboardInsightKind.offTrack => (
          Icons.warning_amber_rounded,
          PlanoraColors.danger,
        ),
      DashboardInsightKind.noDepositAfterDay10 => (
          Icons.notifications_none_rounded,
          PlanoraColors.gold,
        ),
      DashboardInsightKind.allocationDeviation ||
      DashboardInsightKind.emptyComponent => (
          Icons.pie_chart_outline_rounded,
          PlanoraChartTokens.chartBond,
        ),
      DashboardInsightKind.milestone => (
          Icons.emoji_events_outlined,
          PlanoraChartTokens.chartMoney,
        ),
      DashboardInsightKind.streak => (
          Icons.local_fire_department_outlined,
          PlanoraColors.gold,
        ),
    };

    return PlanoraCard(
      onTap: item.portfolioId != null
          ? () => onTapPortfolio(item.portfolioId!)
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.message,
              style: AppTheme.manrope(
                size: 12,
                weight: FontWeight.w600,
                color: cs.onSurface,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallRangeToggle extends StatelessWidget {
  const _SmallRangeToggle({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<(String, int)> options;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.map((opt) {
          final isSel = opt.$2 == selected;
          return InkWell(
            onTap: () => onSelect(opt.$2),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSel ? cs.surface : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                opt.$1,
                style: AppTheme.manrope(
                  size: 11,
                  weight: isSel ? FontWeight.w800 : FontWeight.w600,
                  color: isSel ? cs.primary : cs.onSurfaceVariant,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: accent),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.manrope(
            size: 12.5,
            weight: FontWeight.w800,
            color: cs.onSurface,
            tabular: true,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.manrope(
            size: 10.5,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ProjectionRow extends StatelessWidget {
  const _ProjectionRow({required this.snapshot, required this.onTap});

  final PortfolioSnapshot snapshot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final p = snapshot.portfolio;
    final proj = snapshot.projectionV22;

    final statusPill = switch (proj.status) {
      PortfolioTrackStatusV22.achieved => PlanoraPill.green('Tercapai'),
      PortfolioTrackStatusV22.notStarted => PlanoraPill.gray('Belum Mulai'),
      PortfolioTrackStatusV22.onTrack => PlanoraPill.green('On Track'),
      PortfolioTrackStatusV22.offTrack => PlanoraPill.danger('Off Track'),
    };

    final projText = proj.status == PortfolioTrackStatusV22.achieved
        ? 'Target tercapai'
        : proj.projectedDate != null
            ? 'Est. ${AppFormatters.shortMonthYear(proj.projectedDate!)}'
            : (proj.rateEmptyMessage ?? 'Belum ada laju setoran');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            PortfolioDot(color: Color(p.color)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    projText,
                    style: AppTheme.manrope(
                      size: 11.5,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            statusPill,
          ],
        ),
      ),
    );
  }
}

class _ChecklistRowTile extends StatelessWidget {
  const _ChecklistRowTile({required this.row, required this.onTap});

  final ChecklistRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final done = row.isCompleted;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? PlanoraColors.primary : Colors.transparent,
                border: Border.all(
                  color:
                      done ? PlanoraColors.primary : PlanoraColors.checkBorder,
                  width: 1.8,
                ),
              ),
              child: done
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            PortfolioDot(color: Color(row.portfolio.color)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                row.portfolio.name,
                style: AppTheme.manrope(
                  size: 13,
                  weight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
            ),
            Text(
              AppFormatters.rupiah(row.monthlyPlan),
              style: AppTheme.manrope(
                size: 12.5,
                weight: FontWeight.w800,
                color: done ? cs.onSurface : cs.onSurfaceVariant,
                tabular: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

