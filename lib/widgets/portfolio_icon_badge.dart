import 'package:material_ui/material_ui.dart';
import 'package:planora/core/constants/portfolio_palette.dart';

class PortfolioIconBadge extends StatelessWidget {
  const PortfolioIconBadge({
    super.key,
    required this.iconKey,
    required this.colorValue,
    this.size = 42,
  });

  final String iconKey;
  final int colorValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Color(colorValue);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        PortfolioPalette.iconFor(iconKey),
        color: color,
        size: size * 0.54,
      ),
    );
  }
}

