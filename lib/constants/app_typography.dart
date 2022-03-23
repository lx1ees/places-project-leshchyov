import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';

class AppTypography {
  static const TextStyle appBarTitleTextStyle = TextStyle(
    color: AppColors.appBarTitleColor,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.125, // = Line Height из Figma / Размер шрифта
  );
}
