import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/cash_flow_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/cash_flow_repository.dart';
import 'package:planora/features/cashflow/cash_flow_entry_sheet.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/planora_widgets.dart';

class CashFlowScreen extends ConsumerStatefulWidget {
  const CashFlowScreen({super.key});

  @override
  ConsumerState<CashFlowScreen> createState() => _CashFlowScreenState();
}

class _CashFlowScreenState extends ConsumerState<CashFlowScreen> {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  void _shiftMonth(int delta) {
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + delta);
    });
  }

  Future<void> _showCategoriesManager() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _CategoriesManagerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(hideAmountsProvider);
    final summary = ref.watch(cashFlowMonthlySummaryProvider(_selectedMonth));
    final bars6m = ref.watch(cashFlowMonthlyBars6mProvider(_selectedMonth));
    final rawTxs =
        ref.watch(cashFlowTransactionsStreamProvider).value ?? const [];
    final rawTxById = {for (final t in rawTxs) t.id: t};
    final cs = Theme.of(context).colorScheme;

    final budgetPill = switch (summary.budgetStatus) {
      ExpenseBudgetStatus.noBudget => PlanoraPill.gray('Budget belum diatur'),
      ExpenseBudgetStatus.onTrack => PlanoraPill.green('On Track'),
      ExpenseBudgetStatus.warning => PlanoraPill.yellow('Hati-hati'),
      ExpenseBudgetStatus.overBudget => PlanoraPill.danger('Over Budget'),
    };

    final expenseDonutSlices = summary.expenseByCategory
        .map(
          (c) => DonutSliceData(
            label: c.name,
            percent: c.percent,
            amount: c.amount,
            color: Color(c.color),
          ),
        )
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('cashflow_fab_add'),
        onPressed: () => showCashFlowEntrySheet(context),
        backgroundColor: PlanoraColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Catat'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 88),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arus Kas',
                        style: AppTheme.sora(
                          size: 21,
                          weight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        'Pemasukan dan pengeluaran harian',
                        style: AppTheme.manrope(
                          size: 12.5,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                PlanoraAppBarIconButton(
                  icon: Icons.category_outlined,
                  tooltip: 'Kelola kategori',
                  onPressed: _showCategoriesManager,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Navigasi Bulan
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _shiftMonth(-1),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Text(
                  AppFormatters.monthYear(_selectedMonth),
                  style: AppTheme.manrope(
                    size: 14,
                    weight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
                IconButton(
                  onPressed: () => _shiftMonth(1),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Kartu Ringkasan Bulanan
            PlanoraCard(
              key: const Key('cashflow_summary_card'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RINGKASAN BULAN INI',
                    style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  PlanoraKeyValueRow(
                    label: 'Pemasukan aktual',
                    value: AppFormatters.rupiah(summary.incomeActual),
                    valueColor: PlanoraColors.primary,
                    verticalPadding: 4,
                  ),
                  PlanoraKeyValueRow(
                    label: 'Pengeluaran',
                    value: AppFormatters.rupiah(summary.expenseActual),
                    valueColor: PlanoraColors.danger,
                    verticalPadding: 4,
                  ),
                  PlanoraKeyValueRow(
                    label: 'Setoran ke portofolio',
                    value: AppFormatters.rupiah(summary.portfolioDeposits),
                    verticalPadding: 4,
                  ),
                  const Divider(height: 14),
                  PlanoraKeyValueRow(
                    label: 'Sisa kas bulan ini',
                    value: AppFormatters.rupiah(summary.remainingCash),
                    valueColor: summary.remainingCash < 0
                        ? PlanoraColors.danger
                        : cs.primary,
                    verticalPadding: 4,
                  ),
                ],
              ),
            ),

            // Saran anti-dobel (hanya informatif, tidak pernah otomatis ubah Plan/gaji)
            if (summary.incomeAdviceMessage != null) ...[
              const SizedBox(height: 10),
              PlanoraNoteBox(
                child: Row(
                  key: const Key('cashflow_income_advice'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 18,
                      color: PlanoraColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        summary.incomeAdviceMessage!,
                        style: AppTheme.manrope(
                          size: 12,
                          color: cs.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Kartu Budget Pengeluaran
            PlanoraCard(
              key: const Key('cashflow_budget_card'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Budget Pengeluaran',
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      budgetPill,
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (summary.budgetAmount == null) ...[
                    Text(
                      'Atur biaya hidup di Pengaturan untuk memantau batas pengeluaran bulanan.',
                      style: AppTheme.manrope(
                        size: 12,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      key: const Key('cashflow_setup_budget_button'),
                      onPressed: () => context.go('/settings'),
                      child: const Text('Atur di Pengaturan'),
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${summary.budgetSourceLabel}: ${AppFormatters.rupiah(summary.budgetAmount!)}',
                          style: AppTheme.manrope(
                            size: 12,
                            color: cs.onSurfaceVariant,
                            tabular: true,
                          ),
                        ),
                        Text(
                          PlanoraV22Calc.formatPercent(summary.budgetUsagePct),
                          style: AppTheme.manrope(
                            size: 12.5,
                            weight: FontWeight.w800,
                            color: summary.budgetStatus ==
                                    ExpenseBudgetStatus.overBudget
                                ? PlanoraColors.danger
                                : cs.onSurface,
                            tabular: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    PlanoraProgressBar(
                      value: (summary.budgetUsagePct / 100.0).clamp(0.0, 1.0),
                      color: switch (summary.budgetStatus) {
                        ExpenseBudgetStatus.overBudget => PlanoraColors.danger,
                        ExpenseBudgetStatus.warning => PlanoraColors.gold,
                        _ => PlanoraColors.primary,
                      },
                      height: 8,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      summary.remainingBudget! >= 0
                          ? 'Sisa budget ${AppFormatters.rupiah(summary.remainingBudget!)}'
                          : 'Melebihi budget ${AppFormatters.rupiah(summary.remainingBudget!.abs())}',
                      style: AppTheme.manrope(
                        size: 12,
                        weight: FontWeight.w700,
                        color: summary.remainingBudget! < 0
                            ? PlanoraColors.danger
                            : cs.onSurfaceVariant,
                        tabular: true,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (summary.expenseActual > 0) ...[
              const SizedBox(height: 12),
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengeluaran per Kategori',
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PlanoraAllocationDonutChart(
                      slices: expenseDonutSlices,
                      centerLabel: 'Keluar',
                      centerValue:
                          PlanoraChartTokens.compactRupiah(summary.expenseActual),
                      mini: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'RINGKASAN MINGGUAN',
                      style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        for (var w = 0; w < 5; w++)
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'M${w + 1}',
                                  style: AppTheme.manrope(
                                    size: 10.5,
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  summary.weeklyExpenses[w] > 0
                                      ? PlanoraChartTokens.compactRupiah(
                                          summary.weeklyExpenses[w],
                                        )
                                      : '-',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.manrope(
                                    size: 10.5,
                                    weight: FontWeight.w700,
                                    color: cs.onSurface,
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
            ],

            if (bars6m.any((b) => b.expenseTotal > 0)) ...[
              const SizedBox(height: 12),
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengeluaran 6 Bulan vs Budget',
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CashFlowSixMonthBarChart(bars: bars6m),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 14),
            Text(
              'RIWAYAT TRANSAKSI',
              style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 8),

            if (summary.dayGroups.isEmpty)
              PlanoraCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.swap_vert_rounded,
                        size: 36,
                        color: cs.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Belum ada transaksi di bulan ini',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tekan tombol Catat untuk mencatat pemasukan atau pengeluaran.',
                        textAlign: TextAlign.center,
                        style: AppTheme.manrope(
                          size: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              for (final group in summary.dayGroups) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppFormatters.shortDate(group.date),
                        style: AppTheme.manrope(
                          size: 12,
                          weight: FontWeight.w800,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${group.dayIncome > 0 ? '+${AppFormatters.rupiah(group.dayIncome)} ' : ''}'
                        '${group.dayExpense > 0 ? '−${AppFormatters.rupiah(group.dayExpense)}' : ''}',
                        style: AppTheme.manrope(
                          size: 11.5,
                          weight: FontWeight.w700,
                          color: cs.onSurfaceVariant,
                          tabular: true,
                        ),
                      ),
                    ],
                  ),
                ),
                PlanoraCard(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Column(
                    children: [
                      for (var i = 0; i < group.items.length; i++) ...[
                        if (i > 0) const Divider(height: 1),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Color(group.items[i].categoryColor)
                                  .withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              cashFlowIconData(group.items[i].categoryIcon),
                              size: 18,
                              color: Color(group.items[i].categoryColor),
                            ),
                          ),
                          title: Text(
                            group.items[i].categoryName,
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w700,
                              color: cs.onSurface,
                            ),
                          ),
                          subtitle: group.items[i].note != null
                              ? Text(
                                  group.items[i].note!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.manrope(
                                    size: 11.5,
                                    color: cs.onSurfaceVariant,
                                  ),
                                )
                              : null,
                          trailing: Text(
                            '${group.items[i].isIncome ? '+' : '−'}${AppFormatters.rupiah(group.items[i].amount)}',
                            style: AppTheme.manrope(
                              size: 13,
                              weight: FontWeight.w800,
                              color: group.items[i].isIncome
                                  ? PlanoraColors.primary
                                  : PlanoraColors.danger,
                              tabular: true,
                            ),
                          ),
                          onTap: () {
                            final raw = rawTxById[group.items[i].id];
                            if (raw != null) {
                              showCashFlowEntrySheet(context, existing: raw);
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
          ],
        ),
      ),
    );
  }
}

class _CashFlowSixMonthBarChart extends StatelessWidget {
  const _CashFlowSixMonthBarChart({required this.bars});

  final List<CashFlowMonthlyBar> bars;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final budget = bars.last.budget;
    var maxVal = bars.map((b) => b.expenseTotal).reduce((a, b) => a > b ? a : b);
    if (budget != null && budget > maxVal) maxVal = budget;
    final maxY = maxVal <= 0 ? 100.0 : maxVal * 1.2;

    return SizedBox(
      height: 155,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 3,
            getDrawingHorizontalLine: (_) => FlLine(
              color: cs.outlineVariant.withValues(alpha: 0.5),
              strokeWidth: 1,
            ),
          ),
          extraLinesData: budget != null && budget > 0
              ? ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: budget.toDouble(),
                      color: PlanoraColors.gold,
                      strokeWidth: 1.5,
                      dashArray: [5, 4],
                    ),
                  ],
                )
              : null,
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: !AppFormatters.hideAmounts,
                reservedSize: AppFormatters.hideAmounts ? 8 : 54,
                interval: maxY / 3,
                getTitlesWidget: (v, meta) {
                  if (v == meta.max) return const SizedBox.shrink();
                  return Text(
                    PlanoraChartTokens.compactRupiah(v.round()),
                    style: AppTheme.manrope(
                      size: 10,
                      color: cs.onSurfaceVariant,
                      tabular: true,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (v, _) {
                  final idx = v.round();
                  if (idx < 0 || idx >= bars.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppFormatters.monthShort(bars[idx].month),
                      style: AppTheme.manrope(
                        size: 10,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < bars.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: bars[i].expenseTotal.toDouble(),
                    width: 18,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                    color: (budget != null && bars[i].expenseTotal >= budget)
                        ? PlanoraColors.danger
                        : PlanoraColors.primary,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesManagerSheet extends ConsumerStatefulWidget {
  const _CategoriesManagerSheet();

  @override
  ConsumerState<_CategoriesManagerSheet> createState() =>
      _CategoriesManagerSheetState();
}

class _CategoriesManagerSheetState
    extends ConsumerState<_CategoriesManagerSheet> {
  String _tabType = CashFlowCalc.typeExpense;

  Future<void> _showAddCategoryDialog() async {
    final nameCtrl = TextEditingController();
    String? errText;
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(
            _tabType == CashFlowCalc.typeIncome
                ? 'Tambah Kategori Pemasukan'
                : 'Tambah Kategori Pengeluaran',
          ),
          content: TextField(
            controller: nameCtrl,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Nama kategori',
              errorText: errText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () async {
                try {
                  await ref.read(cashFlowRepositoryProvider).createCategory(
                        type: _tabType,
                        name: nameCtrl.text,
                      );
                  if (ctx.mounted) Navigator.of(ctx).pop();
                } catch (e) {
                  setDialogState(() => errText = e.toString());
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDeleteOrHide(CashFlowCategory cat) async {
    final repo = ref.read(cashFlowRepositoryProvider);
    final usage = await repo.countCategoryUsage(cat.id);
    if (!mounted) return;

    if (usage > 0) {
      await repo.setCategoryHidden(cat.id, !cat.isHidden);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              cat.isHidden
                  ? 'Kategori "${cat.name}" ditampilkan kembali.'
                  : 'Kategori "${cat.name}" masih dipakai $usage transaksi sehingga disembunyikan (bukan dihapus).',
            ),
          ),
        );
      }
      return;
    }

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Kategori?'),
        content: Text(
          'Kategori "${cat.name}" belum dipakai transaksi apa pun dan akan dihapus permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: PlanoraColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await repo.deleteOrHideCategory(cat.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allCats =
        ref.watch(cashFlowCategoriesStreamProvider).value ?? const [];
    final list = allCats.where((c) => c.type == _tabType).toList();
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Kelola Kategori',
                  style: AppTheme.sora(size: 16.5, weight: FontWeight.w700),
                ),
              ),
              TextButton.icon(
                onPressed: _showAddCategoryDialog,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Tambah'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: CashFlowCalc.typeExpense,
                label: Text('Pengeluaran'),
              ),
              ButtonSegment(
                value: CashFlowCalc.typeIncome,
                label: Text('Pemasukan'),
              ),
            ],
            selected: {_tabType},
            onSelectionChanged: (s) {
              if (s.isNotEmpty) setState(() => _tabType = s.first);
            },
          ),
          const SizedBox(height: 10),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: list.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, idx) {
                final cat = list[idx];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    cashFlowIconData(cat.icon),
                    color: cat.isHidden
                        ? cs.onSurfaceVariant
                        : Color(cat.color),
                  ),
                  title: Text(
                    cat.name,
                    style: AppTheme.manrope(
                      size: 13.5,
                      weight: FontWeight.w700,
                      color: cat.isHidden ? cs.onSurfaceVariant : cs.onSurface,
                    ),
                  ),
                  subtitle: cat.isHidden
                      ? const Text('Disembunyikan')
                      : null,
                  trailing: IconButton(
                    tooltip: cat.isHidden
                        ? 'Tampilkan kembali'
                        : 'Sembunyikan / Hapus',
                    onPressed: () => _handleDeleteOrHide(cat),
                    icon: Icon(
                      cat.isHidden
                          ? Icons.visibility_outlined
                          : Icons.delete_outline_rounded,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
