import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/global_composition_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/planora_widgets.dart';

class GlobalCompositionCard extends StatefulWidget {
  const GlobalCompositionCard({
    super.key,
    required this.composition,
    required this.hideAmounts,
    required this.onTapPortfolio,
  });

  final GlobalCompositionSummary composition;
  final bool hideAmounts;
  final void Function(String portfolioId) onTapPortfolio;

  @override
  State<GlobalCompositionCard> createState() => _GlobalCompositionCardState();
}

class _GlobalCompositionCardState extends State<GlobalCompositionCard> {
  String _mode = 'actual'; // 'actual' | 'target'

  Future<void> _showInstrumentDetailSheet(
    BuildContext context,
    GlobalInstrumentSlice slice,
  ) async {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = PlanoraChartTokens.colorForInstrument(
      slice.instrumentType,
      isDark: isDark,
    );
    final showStockTickers =
        slice.isLotBased && widget.composition.stockTickers.isNotEmpty;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      slice.instrumentType,
                      style: AppTheme.sora(size: 16.5, weight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    PlanoraV22Calc.formatPercent(slice.actualPercent),
                    style: AppTheme.manrope(
                      size: 14,
                      weight: FontWeight.w800,
                      color: cs.primary,
                      tabular: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Total aktual ${AppFormatters.rupiah(slice.actualAmount)}'
                '${widget.composition.hasTargetedPortfolios ? ' · Target global ${PlanoraV22Calc.formatPercent(slice.weightedTargetPercent)}' : ''}',
                style: AppTheme.manrope(
                  size: 12,
                  color: cs.onSurfaceVariant,
                  tabular: true,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'SEBARAN PER PORTOFOLIO',
                style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              for (final p in slice.portfolios)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: PortfolioDot(color: Color(p.portfolioColor), size: 10),
                  title: Text(
                    p.portfolioName,
                    style: AppTheme.manrope(
                      size: 13.5,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    p.isNoTarget
                        ? 'Target ${PlanoraV22Calc.formatPercent(p.targetPercentInPortfolio)} (Tanpa Target)'
                        : 'Target ${PlanoraV22Calc.formatPercent(p.targetPercentInPortfolio)} (${AppFormatters.rupiah(p.targetAmountInPortfolio)})',
                    style: AppTheme.manrope(
                      size: 11.5,
                      color: cs.onSurfaceVariant,
                      tabular: true,
                    ),
                  ),
                  trailing: Text(
                    AppFormatters.rupiah(p.actualAmount),
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w800,
                      color: cs.onSurface,
                      tabular: true,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    widget.onTapPortfolio(p.portfolioId);
                  },
                ),
              if (showStockTickers) ...[
                const Divider(height: 20),
                Text(
                  'RINCIAN KODE SAHAM LINTAS PORTO',
                  style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                for (final tk in widget.composition.stockTickers)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: PlanoraChartTokens.chartStock
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tk.ticker,
                            style: AppTheme.mono(
                              size: 12,
                              weight: FontWeight.w700,
                              color: PlanoraChartTokens.chartStock,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${tk.totalLots} lot (${AppFormatters.number(tk.totalShares)} lbr)',
                                style: AppTheme.manrope(
                                  size: 12.5,
                                  weight: FontWeight.w700,
                                  color: cs.onSurface,
                                  tabular: true,
                                ),
                              ),
                              Text(
                                widget.hideAmounts
                                    ? '${PlanoraV22Calc.formatPercent(tk.percentOfTotalStock)} dari total saham'
                                    : 'Rata-rata ${StockLotCalc.formatAveragePrice(tk.averagePrice)}/lbr · ${PlanoraV22Calc.formatPercent(tk.percentOfTotalStock)}',
                                style: AppTheme.manrope(
                                  size: 11,
                                  color: cs.onSurfaceVariant,
                                  tabular: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppFormatters.rupiah(tk.totalModal),
                          style: AppTheme.manrope(
                            size: 12.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final comp = widget.composition;
    if (comp.isEmpty) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTargetView = _mode == 'target';

    final donutSlices = comp.slices.map((s) {
      return DonutSliceData(
        label: s.instrumentType,
        percent: isTargetView ? s.weightedTargetPercent : s.actualPercent,
        amount: isTargetView ? s.targetAmount : s.actualAmount,
        color: PlanoraChartTokens.colorForInstrument(
          s.instrumentType,
          isDark: isDark,
        ),
      );
    }).toList();

    final centerValue = isTargetView
        ? (comp.totalTargetedBalance > 0
            ? PlanoraChartTokens.compactRupiah(comp.totalTargetedBalance)
            : '100%')
        : PlanoraChartTokens.compactRupiah(comp.totalActualBalance);

    return PlanoraCard(
      key: const Key('global_composition_card'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Komposisi Semua Porto',
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      'Ketuk instrumen untuk lihat rincian porto',
                      style: AppTheme.manrope(
                        size: 11.5,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (comp.hasTargetedPortfolios)
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'actual', label: Text('Aktual')),
                    ButtonSegment(value: 'target', label: Text('Target')),
                  ],
                  selected: {_mode},
                  onSelectionChanged: (s) {
                    if (s.isNotEmpty) setState(() => _mode = s.first);
                  },
                  showSelectedIcon: false,
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    textStyle: WidgetStatePropertyAll(
                      AppTheme.manrope(size: 11.5, weight: FontWeight.w700),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          PlanoraAllocationDonutChart(
            slices: donutSlices,
            centerLabel: isTargetView ? 'Target' : 'Aktual',
            centerValue: centerValue,
            mini: true,
            emptyMessage: isTargetView
                ? 'Belum ada portofolio bertarget'
                : 'Belum ada saldo instrumen — catat setoran pertama',
          ),
          if (comp.hasNoTargetPortfolios && comp.hasTargetedPortfolios) ...[
            const SizedBox(height: 8),
            Text(
              'Target global dihitung dari portofolio bertarget saja.',
              key: const Key('global_no_target_note'),
              style: AppTheme.manrope(
                size: 11,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 10),
          const Divider(),
          for (var i = 0; i < comp.slices.length; i++) ...[
            if (i > 0) const Divider(),
            _GlobalInstrumentRow(
              slice: comp.slices[i],
              hasActualBalance: comp.totalActualBalance > 0,
              hasTarget: comp.hasTargetedPortfolios,
              onTap: () => _showInstrumentDetailSheet(context, comp.slices[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _GlobalInstrumentRow extends StatelessWidget {
  const _GlobalInstrumentRow({
    required this.slice,
    required this.hasActualBalance,
    required this.hasTarget,
    required this.onTap,
  });

  final GlobalInstrumentSlice slice;
  final bool hasActualBalance;
  final bool hasTarget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = PlanoraChartTokens.colorForInstrument(
      slice.instrumentType,
      isDark: isDark,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    slice.instrumentType,
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                Text(
                  AppFormatters.rupiah(slice.actualAmount),
                  style: AppTheme.manrope(
                    size: 12.5,
                    weight: FontWeight.w800,
                    color: cs.onSurface,
                    tabular: true,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: cs.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 6),
            _GlobalBarLine(
              label: 'Aktual',
              percent: slice.actualPercent,
              color: color,
              trackColor: cs.surfaceContainerHighest,
            ),
            if (hasTarget) ...[
              const SizedBox(height: 4),
              _GlobalBarLine(
                label: 'Target',
                percent: slice.weightedTargetPercent,
                color: color.withValues(alpha: 0.38),
                trackColor: cs.surfaceContainerHighest,
              ),
            ],
            if (!hasActualBalance) ...[
              const SizedBox(height: 4),
              Text(
                'Belum ada setoran',
                style: AppTheme.manrope(
                  size: 11,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ] else if (slice.isSignificantDeviation) ...[
              const SizedBox(height: 4),
              Text(
                slice.diffPoints > 0
                    ? 'Lebih ${PlanoraV22Calc.formatPercent(slice.diffPoints)} dari target global'
                    : 'Kurang ${PlanoraV22Calc.formatPercent(slice.diffPoints.abs())} dari target global',
                style: AppTheme.manrope(
                  size: 11,
                  weight: FontWeight.w700,
                  color: PlanoraColors.gold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GlobalBarLine extends StatelessWidget {
  const _GlobalBarLine({
    required this.label,
    required this.percent,
    required this.color,
    required this.trackColor,
  });

  final String label;
  final double percent;
  final Color color;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ratio = (percent / 100.0).clamp(0.0, 1.0);
    return Row(
      children: [
        SizedBox(
          width: 44,
          child: Text(
            label,
            style: AppTheme.manrope(
              size: 11,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 6,
              color: trackColor,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: ratio,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 44,
          child: Text(
            PlanoraV22Calc.formatPercent(percent),
            textAlign: TextAlign.right,
            style: AppTheme.manrope(
              size: 11.5,
              weight: FontWeight.w700,
              color: cs.onSurface,
              tabular: true,
            ),
          ),
        ),
      ],
    );
  }
}
