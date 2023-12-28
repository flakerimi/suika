import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GridComponent extends Component {
  final double labelSpacing;
  final Paint gridPaint;
  final TextStyle textStyle;
  final Vector2 screenSize;

  GridComponent({
    required this.screenSize,
    this.labelSpacing = 5.0, // Distance between labels
    Paint? gridPaint,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 10),
  }) : gridPaint = gridPaint ??
            (Paint()
              ..color = Colors.grey
              ..style = PaintingStyle.stroke);

  @override
  void render(Canvas canvas) {
    final cellWidth = screenSize.x / 80;
    final cellHeight = screenSize.y / 60;

    // Draw horizontal and vertical lines
    for (int i = 0; i <= 80; i++) {
      final x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, screenSize.y), gridPaint);

      // Draw labels at specified intervals
      if (i % labelSpacing == 0) {
        _drawLabel(canvas, ' $i', Offset(x, 0));
      }
    }

    for (int j = 0; j <= 60; j++) {
      final y = j * cellHeight;
      canvas.drawLine(Offset(0, y), Offset(screenSize.x, y), gridPaint);

      // Draw labels at specified intervals
      if (j % labelSpacing == 0) {
        _drawLabel(canvas, ' $j', Offset(0, y));
      }
    }
  }

  void _drawLabel(Canvas canvas, String text, Offset position) {
    TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: double.infinity)
      ..paint(canvas, position);
  }
}
