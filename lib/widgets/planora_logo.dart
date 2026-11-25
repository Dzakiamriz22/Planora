import 'package:material_ui/material_ui.dart';

/// Logo resmi Planora dari SVG DS-PLN-2026-001 (Bab A.5 & Library Bab 01).
class PlanoraLogo extends StatelessWidget {
  const PlanoraLogo({
    super.key,
    this.size = 104,
    this.showTile = true,
  });

  final double size;
  final bool showTile;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _PlanoraLogoPainter(showTile: showTile),
    );
  }
}

class _PlanoraLogoPainter extends CustomPainter {
  const _PlanoraLogoPainter({required this.showTile});

  final bool showTile;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 120.0;
    canvas.save();
    canvas.scale(s, s);

    if (showTile) {
      final tileRect = RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 120, 120),
        const Radius.circular(27),
      );
      canvas.drawRRect(
        tileRect,
        Paint()..color = const Color(0xFF0B4A34),
      );
    }

    // Huruf P geometris krem #F7F3E7
    final pPath = Path()
      ..moveTo(40, 90)
      ..lineTo(40, 30)
      ..lineTo(63, 30)
      ..arcToPoint(
        const Offset(63, 64),
        radius: const Radius.circular(17),
        clockwise: true,
      )
      ..lineTo(40, 64);

    canvas.drawPath(
      pPath,
      Paint()
        ..color = const Color(0xFFF7F3E7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Titik emas (82, 30) r=6
    canvas.drawCircle(
      const Offset(82, 30),
      6,
      Paint()..color = const Color(0xFFC98A1B),
    );

    // Garis tumbuh emas (40, 102) -> (84, 102) stroke 6
    canvas.drawLine(
      const Offset(40, 102),
      const Offset(84, 102),
      Paint()
        ..color = const Color(0xFFC98A1B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PlanoraLogoPainter oldDelegate) =>
      oldDelegate.showTile != showTile;
}
