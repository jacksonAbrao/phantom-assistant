import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Fantasminha do Phantom, desenhado em código (sem arte de terceiros).
class PhantomLogo extends StatelessWidget {
  const PhantomLogo({
    super.key,
    this.size = 26,
    this.color = AppColors.primaryLight,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _GhostPainter(color)),
      ),
    );
  }
}

class _GhostPainter extends CustomPainter {
  _GhostPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24, size.height / 24);

    final body = Path()
      ..moveTo(5, 20)
      ..lineTo(5, 10)
      ..arcToPoint(const Offset(19, 10), radius: const Radius.circular(7))
      ..lineTo(19, 20)
      ..lineTo(16.5, 18)
      ..lineTo(14.5, 20)
      ..lineTo(12, 18)
      ..lineTo(9.5, 20)
      ..lineTo(7.5, 18)
      ..close();

    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(body, stroke);

    final fill = Paint()..color = color;
    canvas.drawCircle(const Offset(9.5, 10), 1, fill);
    canvas.drawCircle(const Offset(14.5, 10), 1, fill);
  }

  @override
  bool shouldRepaint(_GhostPainter oldDelegate) => oldDelegate.color != color;
}
