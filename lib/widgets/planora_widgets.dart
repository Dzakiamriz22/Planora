import 'package:material_ui/material_ui.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';

/// Kartu standar Planora: radius 18, border 1px `#E4EAE2`, padding 14.
class PlanoraCard extends StatelessWidget {
  const PlanoraCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.borderColor,
    this.borderWidth = 1,
    this.showGoldRing = false,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final double borderWidth;
  final bool showGoldRing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? PlanoraColors.darkCard : PlanoraColors.cardSurface;
    final defaultBorder =
        isDark ? PlanoraColors.darkBorder : PlanoraColors.cardBorder;

    final card = Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor ?? defaultBorder,
          width: borderWidth,
        ),
        boxShadow: showGoldRing
            ? [
                BoxShadow(
                  color: PlanoraColors.gold.withValues(alpha: 0.25),
                  spreadRadius: 1,
                  blurRadius: 0,
                ),
              ]
            : null,
      ),
      child: onTap == null
          ? Padding(padding: padding, child: child)
          : Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Padding(padding: padding, child: child),
              ),
            ),
    );

    return card;
  }
}

/// Chip pill Planora: radius 999, padding 3x8, teks 10,5px bold.
class PlanoraPill extends StatelessWidget {
  const PlanoraPill({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  factory PlanoraPill.green(String label, {IconData? icon}) => PlanoraPill(
        label: label,
        backgroundColor: PlanoraColors.greenSoft,
        textColor: PlanoraColors.primary,
        icon: icon,
      );

  factory PlanoraPill.gray(String label, {IconData? icon}) => PlanoraPill(
        label: label,
        backgroundColor: PlanoraColors.segmentBg,
        textColor: PlanoraColors.inkSecondary,
        icon: icon,
      );

  factory PlanoraPill.yellow(String label, {IconData? icon}) => PlanoraPill(
        label: label,
        backgroundColor: PlanoraColors.chipYellowBg,
        textColor: PlanoraColors.chipYellowText,
        icon: icon,
      );

  factory PlanoraPill.sekuritas(String label, {IconData? icon}) => PlanoraPill(
        label: label,
        backgroundColor: PlanoraColors.chipSekuritasBg,
        textColor: PlanoraColors.chipSekuritasText,
        icon: icon,
      );

  factory PlanoraPill.danger(String label, {IconData? icon}) => PlanoraPill(
        label: label,
        backgroundColor: PlanoraColors.dangerSoft,
        textColor: PlanoraColors.danger,
        icon: icon,
      );

  factory PlanoraPill.platform(String platformLabel) {
    return PlanoraPill.green(platformLabel);
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? PlanoraColors.segmentBg;
    final fg = textColor ?? PlanoraColors.inkSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTheme.manrope(
              size: 10.5,
              weight: FontWeight.w700,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

/// Titik warna porto: 9x9px, radius 3px.
class PortfolioDot extends StatelessWidget {
  const PortfolioDot({super.key, required this.color, this.size = 9});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

/// Bar progres Planora: tinggi default 7px (Detail Porto 9px), rel `#E7EDE5`, isi warna porto.
class PlanoraProgressBar extends StatelessWidget {
  const PlanoraProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 7,
  });

  final double value;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final clamped = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              color: isDark ? PlanoraColors.darkBorder : PlanoraColors.trackBg,
            ),
            if (clamped > 0)
              FractionallySizedBox(
                widthFactor: clamped < 0.03 ? 0.03 : clamped,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Segmen untuk bar alokasi bertumpuk.
class AllocationBarSegment {
  const AllocationBarSegment({required this.amount, required this.color});

  final int amount;
  final Color color;
}

/// Bar alokasi bertumpuk: tinggi 12px (Form Fase 10px), pill, jarak antar segmen 2px.
class StackedAllocationBar extends StatelessWidget {
  const StackedAllocationBar({
    super.key,
    required this.segments,
    this.height = 12,
  });

  final List<AllocationBarSegment> segments;
  final double height;

  @override
  Widget build(BuildContext context) {
    final nonZero = segments.where((s) => s.amount > 0).toList();
    if (nonZero.isEmpty) {
      return PlanoraProgressBar(
        value: 0,
        color: PlanoraColors.primary,
        height: height,
      );
    }

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Row(
          children: [
            for (var i = 0; i < nonZero.length; i++) ...[
              if (i > 0) const SizedBox(width: 2),
              Expanded(
                flex: nonZero[i].amount,
                child: Container(
                  decoration: BoxDecoration(
                    color: nonZero[i].color,
                    borderRadius: BorderRadius.horizontal(
                      left: i == 0 ? const Radius.circular(999) : Radius.zero,
                      right: i == nonZero.length - 1
                          ? const Radius.circular(999)
                          : Radius.zero,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Kotak catatan hijau (`#F2F7F1`) atau kuning (`#FBF4E0`).
class PlanoraNoteBox extends StatelessWidget {
  const PlanoraNoteBox({
    super.key,
    required this.child,
    this.isWarning = false,
  });

  final Widget child;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isWarning
        ? (isDark
            ? PlanoraColors.gold.withValues(alpha: 0.14)
            : PlanoraColors.noteYellowBg)
        : (isDark
            ? PlanoraColors.primary.withValues(alpha: 0.25)
            : PlanoraColors.noteGreenBg);
    final border = isWarning
        ? (isDark
            ? PlanoraColors.gold.withValues(alpha: 0.4)
            : PlanoraColors.noteYellowBorder)
        : (isDark
            ? PlanoraColors.greenBright.withValues(alpha: 0.5)
            : PlanoraColors.greenSoft);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border, width: 1),
      ),
      child: child,
    );
  }
}

/// Tombol ikon app bar 36x36 visual dengan target sentuh 48x48, radius 12.
class PlanoraAppBarIconButton extends StatelessWidget {
  const PlanoraAppBarIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.filled = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = filled
        ? PlanoraColors.primary
        : (isDark ? PlanoraColors.darkCard : PlanoraColors.cardSurface);
    final fg = filled
        ? Colors.white
        : (isDark ? PlanoraColors.darkInkPrimary : PlanoraColors.inkPrimary);
    final border = isDark
        ? PlanoraColors.darkBorder
        : PlanoraColors.iconButtonBorder;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: filled ? null : Border.all(color: border, width: 1),
              ),
              child: Icon(icon, size: 19, color: fg),
            ),
          ),
        ),
      ),
    );
  }
}

/// Baris kunci–nilai standar (label redup kiri, nilai bold tabular kanan).
class PlanoraKeyValueRow extends StatelessWidget {
  const PlanoraKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueStyle,
    this.onTap,
    this.verticalPadding = 10,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final TextStyle? valueStyle;
  final VoidCallback? onTap;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final row = Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTheme.manrope(
                size: 13,
                weight: FontWeight.w500,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            textAlign: TextAlign.right,
            style: valueStyle ??
                AppTheme.manrope(
                  size: 13,
                  weight: FontWeight.w800,
                  color: valueColor ?? cs.onSurface,
                  tabular: true,
                ),
          ),
        ],
      ),
    );

    if (onTap == null) return row;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: row,
    );
  }
}

/// Garis pemisah putus-putus untuk daftar checklist Beranda.
class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark ? PlanoraColors.darkBorder : PlanoraColors.hairlineDivider;

    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashGap = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashGap)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(width: dashWidth, height: 1, color: color),
          ),
        );
      },
    );
  }
}

/// Bottom navigation bar kustom Planora sesuai desain layar (4 tab tetap).
class PlanoraBottomNavBar extends StatelessWidget {
  const PlanoraBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? PlanoraColors.darkCard : PlanoraColors.cardSurface;
    final border =
        isDark ? PlanoraColors.darkBorder : PlanoraColors.cardBorder;

    const items = [
      (icon: Icons.home_outlined, label: 'Beranda'),
      (icon: Icons.account_balance_wallet_outlined, label: 'Porto'),
      (icon: Icons.layers_outlined, label: 'Fase'),
      (icon: Icons.settings_outlined, label: 'Pengaturan'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border(top: BorderSide(color: border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 10),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: i == currentIndex
                                ? (isDark
                                    ? PlanoraColors.primary
                                        .withValues(alpha: 0.4)
                                    : PlanoraColors.greenSoft)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Icon(
                            items[i].icon,
                            size: 21,
                            color: i == currentIndex
                                ? (isDark
                                    ? const Color(0xFF34D399)
                                    : PlanoraColors.primary)
                                : PlanoraColors.navInactive,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[i].label,
                          style: AppTheme.manrope(
                            size: 10.5,
                            weight: FontWeight.w700,
                            color: i == currentIndex
                                ? (isDark
                                    ? const Color(0xFF34D399)
                                    : PlanoraColors.primary)
                                : PlanoraColors.navInactive,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
