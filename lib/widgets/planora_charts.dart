import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';

class DonutSliceData {
  const DonutSliceData({
    required this.label,
    required this.percent,
    required this.amount,
    required this.color,
  });

  final String label;
  final double percent;
  final int amount;
  final Color color;
}

class PlanoraChartEmptyState extends StatelessWidget {
  const PlanoraChartEmptyState({
    super.key,
    this.message = 'Belum ada data — catat setoran pertama',
    this.height = 140,
  });

  final String message;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      label: message,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_chart_outlined_rounded,
              size: 28,
              color: cs.onSurfaceVariant,
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTheme.manrope(
                size: 12,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanoraAllocationDonutChart extends StatefulWidget {
  const PlanoraAllocationDonutChart({
    super.key,
    required this.slices,
    required this.centerLabel,
    required this.centerValue,
    this.mini = false,
    this.emptyMessage = 'Belum ada data — catat setoran pertama',
  });

  final List<DonutSliceData> slices;
  final String centerLabel;
  final String centerValue;
  final bool mini;
  final String emptyMessage;

  @override
  State<PlanoraAllocationDonutChart> createState() =>
      _PlanoraAllocationDonutChartState();
}

class _PlanoraAllocationDonutChartState
    extends State<PlanoraAllocationDonutChart> {
  int _touchedVisualIndex = -1;

  @override
  Widget build(BuildContext context) {
    final positive = widget.slices.where((s) => s.percent > 0).toList();
    if (positive.isEmpty) {
      return PlanoraChartEmptyState(
        message: widget.emptyMessage,
        height: widget.mini ? 110 : 168,
      );
    }

    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final visualSlices = <DonutSliceData>[];
    var smallPercentSum = 0.0;
    var smallAmountSum = 0;
    for (final s in positive) {
      if (s.percent < 2.0) {
        smallPercentSum += s.percent;
        smallAmountSum += s.amount;
      } else {
        visualSlices.add(s);
      }
    }
    if (smallPercentSum > 0) {
      visualSlices.add(
        DonutSliceData(
          label: 'Lainnya',
          percent: PlanoraV22Calc.round2(smallPercentSum),
          amount: smallAmountSum,
          color: PlanoraChartTokens.colorForInstrument(
            'Lainnya',
            isDark: isDark,
          ),
        ),
      );
    }

    final touchedLabel = (_touchedVisualIndex >= 0 &&
            _touchedVisualIndex < visualSlices.length)
        ? visualSlices[_touchedVisualIndex].label
        : null;

    final sortedTop = [...positive]
      ..sort((a, b) => b.percent.compareTo(a.percent));
    final topSummary = sortedTop
        .take(3)
        .map(
          (s) =>
              '${s.label} ${PlanoraV22Calc.formatPercent(s.percent)} (${AppFormatters.rupiah(s.amount)})',
        )
        .join(', ');

    final chartSize = widget.mini ? 116.0 : 168.0;
    final sectionRadius = widget.mini ? 20.0 : 28.0;
    final centerSpace = widget.mini ? 34.0 : 52.0;

    final donutWidget = SizedBox(
      width: chartSize,
      height: chartSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: centerSpace,
              startDegreeOffset: -90,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  if (!event.isInterestedForInteractions ||
                      response == null ||
                      response.touchedSection == null) {
                    if (_touchedVisualIndex != -1) {
                      setState(() => _touchedVisualIndex = -1);
                    }
                    return;
                  }
                  final idx = response.touchedSection!.touchedSectionIndex;
                  if (idx != _touchedVisualIndex) {
                    setState(() => _touchedVisualIndex = idx);
                  }
                },
              ),
              sections: [
                for (var i = 0; i < visualSlices.length; i++)
                  PieChartSectionData(
                    value: visualSlices[i].percent,
                    color: visualSlices[i].color,
                    radius: i == _touchedVisualIndex
                        ? sectionRadius + 5
                        : sectionRadius,
                    showTitle: false,
                  ),
              ],
            ),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.centerLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.manrope(
                    size: widget.mini ? 9.5 : 10.5,
                    weight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 1),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.centerValue,
                    style: AppTheme.sora(
                      size: widget.mini ? 12 : 14,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                      tabular: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final legendWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final s in positive)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: touchedLabel == s.label
                  ? s.color.withValues(alpha: 0.14)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: s.color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    s.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.manrope(
                      size: widget.mini ? 11.5 : 12.5,
                      weight: touchedLabel == s.label
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  PlanoraV22Calc.formatPercent(s.percent),
                  style: AppTheme.manrope(
                    size: widget.mini ? 11.5 : 12.5,
                    weight: FontWeight.w800,
                    color: cs.onSurface,
                    tabular: true,
                  ),
                ),
                if (!widget.mini || s.amount > 0) ...[
                  const SizedBox(width: 6),
                  Text(
                    PlanoraChartTokens.compactRupiah(s.amount),
                    style: AppTheme.manrope(
                      size: 11,
                      color: cs.onSurfaceVariant,
                      tabular: true,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );

    return Semantics(
      label: 'Donut alokasi ${widget.centerLabel} ${widget.centerValue}: $topSummary',
      child: widget.mini
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                donutWidget,
                const SizedBox(width: 14),
                Expanded(child: legendWidget),
              ],
            )
          : Column(
              children: [
                Center(child: donutWidget),
                const SizedBox(height: 14),
                legendWidget,
              ],
            ),
    );
  }
}

class PlanoraAllocationComparisonRow extends StatelessWidget {
  const PlanoraAllocationComparisonRow({
    super.key,
    required this.instrument,
    required this.actualAmount,
    required this.targetAmount,
    required this.actualPercent,
    required this.targetPercent,
    required this.highlightNominal,
    this.onTap,
  });

  final String instrument;
  final int actualAmount;
  final int targetAmount;
  final double actualPercent;
  final double targetPercent;
  final bool highlightNominal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = PlanoraChartTokens.colorForInstrument(
      instrument,
      isDark: isDark,
    );
    final diffPoints = PlanoraV22Calc.round2(actualPercent - targetPercent);
    final showDiff = diffPoints.abs() >= 1.0;
    final diffLabel = diffPoints > 0
        ? '+${PlanoraV22Calc.formatPercent(diffPoints).replaceAll('%', '')} poin dari target'
        : '−${PlanoraV22Calc.formatPercent(diffPoints.abs()).replaceAll('%', '')} poin dari target';

    return Semantics(
      label:
          '$instrument, investasi ${AppFormatters.rupiah(actualAmount)}, alokasi aktual ${PlanoraV22Calc.formatPercent(actualPercent)}, target ${PlanoraV22Calc.formatPercent(targetPercent)}',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      instrument,
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppFormatters.rupiah(actualAmount),
                        style: AppTheme.manrope(
                          size: highlightNominal ? 14 : 13,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                          tabular: true,
                        ),
                      ),
                      if (targetAmount > 0)
                        Text(
                          'Target ${AppFormatters.rupiah(targetAmount)}',
                          style: AppTheme.manrope(
                            size: 11,
                            color: cs.onSurfaceVariant,
                            tabular: true,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _PairedBarLine(
                label: 'Alokasi',
                percent: actualPercent,
                color: color,
                trackColor: cs.surfaceContainerHighest,
              ),
              const SizedBox(height: 5),
              _PairedBarLine(
                label: 'Target',
                percent: targetPercent,
                color: color.withValues(alpha: 0.38),
                trackColor: cs.surfaceContainerHighest,
              ),
              if (showDiff) ...[
                const SizedBox(height: 5),
                Text(
                  diffLabel,
                  style: AppTheme.manrope(
                    size: 11,
                    weight: FontWeight.w700,
                    color: diffPoints.abs() > 10
                        ? PlanoraColors.gold
                        : cs.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PairedBarLine extends StatelessWidget {
  const _PairedBarLine({
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
          width: 48,
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
              height: 7,
              color: trackColor,
              alignment: Alignment.centerLeft,
              child: AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
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

class PlanoraBalanceAreaChart extends StatelessWidget {
  const PlanoraBalanceAreaChart({
    super.key,
    required this.points,
    this.height = 176,
    this.lineColor = PlanoraColors.primary,
    this.emptyMessage = 'Belum ada data — catat setoran pertama',
  });

  final List<MonthlyBalancePoint> points;
  final double height;
  final Color lineColor;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final hasAnyValue = points.any((p) => p.cumulativeBalance > 0);
    if (points.isEmpty || !hasAnyValue) {
      return PlanoraChartEmptyState(message: emptyMessage, height: height);
    }

    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strokeColor = isDark
        ? PlanoraChartTokens.chartMoney
        : lineColor;

    final maxVal = points
        .map((p) => p.cumulativeBalance)
        .reduce((a, b) => a > b ? a : b);
    final maxY = maxVal <= 0 ? 100.0 : (maxVal * 1.15);

    final spots = [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].cumulativeBalance.toDouble()),
    ];

    final sortedTop = [...points]
      ..sort((a, b) => b.cumulativeBalance.compareTo(a.cumulativeBalance));
    final topSummary = sortedTop
        .take(3)
        .map(
          (p) =>
              '${AppFormatters.monthYearShort(p.month)} ${AppFormatters.rupiah(p.cumulativeBalance)}',
        )
        .join(', ');

    final step = points.length > 6 ? 2 : 1;

    return Semantics(
      label: 'Grafik pertumbuhan saldo: $topSummary',
      child: SizedBox(
        height: height,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxY / 3,
              getDrawingHorizontalLine: (_) => FlLine(
                color: cs.outlineVariant.withValues(alpha: 0.6),
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 54,
                  interval: maxY / 3,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.max) return const SizedBox.shrink();
                    return Text(
                      PlanoraChartTokens.compactRupiah(value.round()),
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
                  interval: 1,
                  reservedSize: 24,
                  getTitlesWidget: (value, _) {
                    final idx = value.round();
                    if (idx < 0 || idx >= points.length) {
                      return const SizedBox.shrink();
                    }
                    if (idx % step != 0 && idx != points.length - 1) {
                      return const SizedBox.shrink();
                    }
                    final m = points[idx].month;
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        AppFormatters.monthShort(m),
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
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => cs.inverseSurface,
                getTooltipItems: (touchedSpots) => touchedSpots.map((s) {
                  final idx = s.x.round().clamp(0, points.length - 1);
                  final pt = points[idx];
                  return LineTooltipItem(
                    '${AppFormatters.monthYearShort(pt.month)}\n${AppFormatters.rupiah(pt.cumulativeBalance)}',
                    AppTheme.manrope(
                      size: 11,
                      weight: FontWeight.w700,
                      color: cs.onInverseSurface,
                      tabular: true,
                    ),
                  );
                }).toList(),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                preventCurveOverShooting: true,
                color: strokeColor,
                barWidth: 2.5,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, pct, bar, idx) => FlDotCirclePainter(
                    radius: idx == spots.length - 1 ? 4 : 2.5,
                    color: strokeColor,
                    strokeWidth: 1.5,
                    strokeColor: cs.surface,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: strokeColor.withValues(alpha: 0.14),
                ),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        ),
      ),
    );
  }
}

class MonthlyStackedBarData {
  const MonthlyStackedBarData({
    required this.month,
    required this.segments,
  });

  final DateTime month;
  final List<({String label, int amount, Color color})> segments;

  int get total => segments.fold<int>(0, (s, e) => s + e.amount);
}

class PlanoraMonthlyStackedBarChart extends StatelessWidget {
  const PlanoraMonthlyStackedBarChart({
    super.key,
    required this.bars,
    this.height = 170,
    this.onMonthTap,
  });

  final List<MonthlyStackedBarData> bars;
  final double height;
  final void Function(DateTime month)? onMonthTap;

  @override
  Widget build(BuildContext context) {
    final hasAny = bars.any((b) => b.total > 0);
    if (bars.isEmpty || !hasAny) {
      return PlanoraChartEmptyState(height: height);
    }

    final cs = Theme.of(context).colorScheme;
    final maxVal = bars.map((b) => b.total).reduce((a, b) => a > b ? a : b);
    final maxY = maxVal <= 0 ? 100.0 : maxVal * 1.2;

    final sortedTop = [...bars]..sort((a, b) => b.total.compareTo(a.total));
    final topSummary = sortedTop
        .take(3)
        .map(
          (b) =>
              '${AppFormatters.monthYearShort(b.month)} ${AppFormatters.rupiah(b.total)}',
        )
        .join(', ');

    return Semantics(
      label: 'Grafik batang setoran bulanan: $topSummary',
      child: SizedBox(
        height: height,
        child: BarChart(
          BarChartData(
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxY / 3,
              getDrawingHorizontalLine: (_) => FlLine(
                color: cs.outlineVariant.withValues(alpha: 0.6),
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 54,
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
                  reservedSize: 24,
                  getTitlesWidget: (v, _) {
                    final idx = v.round();
                    if (idx < 0 || idx >= bars.length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
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
            barTouchData: BarTouchData(
              touchCallback: (event, resp) {
                if (event is FlTapUpEvent &&
                    resp?.spot != null &&
                    onMonthTap != null) {
                  final idx = resp!.spot!.touchedBarGroupIndex;
                  if (idx >= 0 && idx < bars.length) {
                    onMonthTap!(bars[idx].month);
                  }
                }
              },
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => cs.inverseSurface,
                getTooltipItem: (group, groupIdx, rod, rodIdx) {
                  final b = bars[groupIdx];
                  return BarTooltipItem(
                    '${AppFormatters.monthYearShort(b.month)}\n${AppFormatters.rupiah(b.total)}',
                    AppTheme.manrope(
                      size: 11,
                      weight: FontWeight.w700,
                      color: cs.onInverseSurface,
                      tabular: true,
                    ),
                  );
                },
              ),
            ),
            barGroups: [
              for (var i = 0; i < bars.length; i++)
                _buildGroup(i, bars[i]),
            ],
          ),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        ),
      ),
    );
  }

  BarChartGroupData _buildGroup(int x, MonthlyStackedBarData bar) {
    final stackItems = <BarChartRodStackItem>[];
    var cursor = 0.0;
    for (final seg in bar.segments) {
      if (seg.amount <= 0) continue;
      final next = cursor + seg.amount;
      stackItems.add(BarChartRodStackItem(cursor, next, seg.color));
      cursor = next;
    }
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: cursor,
          width: 18,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
          rodStackItems: stackItems,
          color: PlanoraColors.primary,
        ),
      ],
    );
  }
}

class PlanoraProgressRing extends StatelessWidget {
  const PlanoraProgressRing({
    super.key,
    required this.progressPercent,
    this.size = 44,
    this.strokeWidth = 5,
    this.color = PlanoraColors.primary,
    this.showLabel = true,
  });

  final double progressPercent;
  final double size;
  final double strokeWidth;
  final Color color;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final clamped = progressPercent.clamp(0.0, 100.0);
    final remaining = (100.0 - clamped).clamp(0.0, 100.0);
    final centerRadius = (size / 2) - strokeWidth;

    return Semantics(
      label: 'Progres ${PlanoraV22Calc.formatPercent(clamped)}',
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 0,
                centerSpaceRadius: centerRadius > 0 ? centerRadius : 8,
                pieTouchData: PieTouchData(enabled: false),
                sections: [
                  PieChartSectionData(
                    value: clamped > 0 ? clamped : 0.001,
                    color: clamped > 0 ? color : cs.surfaceContainerHighest,
                    radius: strokeWidth,
                    showTitle: false,
                  ),
                  if (remaining > 0)
                    PieChartSectionData(
                      value: remaining,
                      color: cs.surfaceContainerHighest,
                      radius: strokeWidth,
                      showTitle: false,
                    ),
                ],
              ),
              duration: const Duration(milliseconds: 350),
            ),
            if (showLabel)
              Text(
                '${clamped.round()}%',
                style: AppTheme.manrope(
                  size: size >= 44 ? 10.5 : 9,
                  weight: FontWeight.w800,
                  color: cs.onSurface,
                  tabular: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PlanoraSparkline extends StatelessWidget {
  const PlanoraSparkline({
    super.key,
    required this.values,
    required this.color,
    this.width = 68,
    this.height = 24,
  });

  final List<int> values;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (values.length < 2 || !values.any((v) => v > 0)) {
      return SizedBox(width: width, height: height);
    }

    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final spots = [
      for (var i = 0; i < values.length; i++)
        FlSpot(i.toDouble(), values[i].toDouble()),
    ];

    return Semantics(
      label: 'Tren 6 bulan terakhir',
      child: SizedBox(
        width: width,
        height: height,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: maxVal <= 0 ? 10 : maxVal * 1.1,
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                preventCurveOverShooting: true,
                color: color,
                barWidth: 1.8,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: color.withValues(alpha: 0.12),
                ),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}

