import 'package:flutter/material.dart';

abstract class WidgetUtils {
  /// Вычисляет размер текста
  static Size calculateTitleSize({
    required BuildContext context,
    required String text,
    required TextStyle style,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size;
  }
}
