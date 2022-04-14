import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

class StringUtils {
  /// Метод выделяет строки [toHighlight] в тексте [source] цветом [highlightColor]
  static List<TextSpan> highlightPhrases({
    required String source,
    required String toHighlight,
    required Color highlightColor,
  }) {
    final allMatches =
        toHighlight.toLowerCase().allMatches(source.toLowerCase());
    final highlighted = <TextSpan>[];
    var lastMatchEnd = 0;

    for (var i = 0; i < allMatches.length; i++) {
      final match = allMatches.elementAt(i);

      if (match.start != lastMatchEnd) {
        highlighted.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      highlighted.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: AppTypography.textTextStyle.copyWith(
          color: highlightColor,
        ),
      ));

      if (i == allMatches.length - 1 && match.end != source.length) {
        highlighted.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }

    return highlighted;
  }
}
