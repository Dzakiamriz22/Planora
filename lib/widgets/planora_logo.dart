import 'package:material_ui/material_ui.dart';

enum PlanoraLogoVariant { tile, onDark, onLight, mono }

class PlanoraLogo extends StatelessWidget {
  const PlanoraLogo({
    super.key,
    this.size = 104,
    this.showTile = true,
    this.variant,
    this.monoColor,
  });

  final double size;
  final bool showTile;
  final PlanoraLogoVariant? variant;
  final Color? monoColor;

  @override
  Widget build(BuildContext context) {
    final effectiveVariant = variant ??
        (showTile ? PlanoraLogoVariant.tile : PlanoraLogoVariant.onDark);
    return Semantics(
      label: 'Logo Planora',
      child: CustomPaint(
        size: Size.square(size),
        painter: _PlanoraLogoPainter(
          variant: effectiveVariant,
          monoColor: monoColor ?? const Color(0xFF132A20),
          compact: size < 24,
        ),
      ),
    );
  }
}

class _PlanoraLogoPainter extends CustomPainter {
  const _PlanoraLogoPainter({
    required this.variant,
    required this.monoColor,
    required this.compact,
  });

  final PlanoraLogoVariant variant;
  final Color monoColor;
  final bool compact;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 120.0;
    canvas.save();
    canvas.scale(s, s);

    if (variant == PlanoraLogoVariant.tile) {
      final tileRect = RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 120, 120),
        const Radius.circular(27),
      );
      canvas.drawRRect(
        tileRect,
        Paint()..color = const Color(0xFF0B4A34),
      );
    }

    final stairColor = switch (variant) {
      PlanoraLogoVariant.tile || PlanoraLogoVariant.onDark =>
        const Color(0xFFF7F3E7),
      PlanoraLogoVariant.onLight => const Color(0xFF0B4A34),
      PlanoraLogoVariant.mono => monoColor,
    };

    final accentColor = variant == PlanoraLogoVariant.mono
        ? monoColor
        : const Color(0xFFC98A1B);

    final stairPath = Path()
      ..moveTo(30, 86)
      ..lineTo(47, 86)
      ..lineTo(47, 69)
      ..lineTo(64, 69)
      ..lineTo(64, 52)
      ..lineTo(81, 52);

    canvas.drawPath(
      stairPath,
      Paint()
        ..color = stairColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    canvas.drawCircle(
      const Offset(88, 45),
      6,
      Paint()..color = accentColor,
    );

    if (!compact) {
      canvas.drawLine(
        const Offset(30, 100),
        const Offset(90, 100),
        Paint()
          ..color = accentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PlanoraLogoPainter oldDelegate) =>
      oldDelegate.variant != variant ||
      oldDelegate.monoColor != monoColor ||
      oldDelegate.compact != compact;
}
