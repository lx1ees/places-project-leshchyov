import 'package:flutter/material.dart';

class AppTypography {
  static const TextStyle largeTitleTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.125, // = Line Height из Figma / Размер шрифта
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.333,
  );

  static const TextStyle textTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  static const TextStyle smallBoldTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.286,
  );

  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );

  static const TextStyle superSmallTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.333,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    height: 1.286,
  );

  static final TextStyle textRegularTextStyle = textTextStyle.copyWith(
    fontWeight: FontWeight.w400,
  );

  static final TextStyle superSmallBoldTextStyle = superSmallTextStyle.copyWith(
    fontWeight: FontWeight.w500,
  );
}
