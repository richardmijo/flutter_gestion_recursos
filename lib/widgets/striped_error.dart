import 'package:flutter/material.dart';

class StripedErrorWidget extends StatelessWidget {
  final double stripeWidth;
  const StripedErrorWidget({Key? key, this.stripeWidth = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _StripedPainter(stripeWidth: stripeWidth),
      child: const Center(
        child: Icon(
          Icons.error_outline,
          size: 64,
          color: Colors.red,
        ),
      ),
    );
  }
}

class _StripedPainter extends CustomPainter {
  final double stripeWidth;
  _StripedPainter({required this.stripeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paintYellow = Paint()..color = Colors.yellow;
    final paintBlack = Paint()..color = Colors.black;

    // Draw diagonal stripes from top-left to bottom-right
    final diag = stripeWidth * 2;
    for (double x = -size.height; x < size.width; x += diag) {
      final path = Path();
      path.moveTo(x, 0);
      path.lineTo(x + stripeWidth, 0);
      path.lineTo(x + size.height + stripeWidth, size.height);
      path.lineTo(x + size.height, size.height);
      path.close();
      canvas.drawPath(path, paintYellow);

      final path2 = Path();
      path2.moveTo(x + stripeWidth, 0);
      path2.lineTo(x + diag, 0);
      path2.lineTo(x + size.height + diag, size.height);
      path2.lineTo(x + size.height + stripeWidth, size.height);
      path2.close();
      canvas.drawPath(path2, paintBlack);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
