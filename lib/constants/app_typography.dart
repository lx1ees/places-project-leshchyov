import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';

class AppTypography {
  static const TextStyle appBarTitleTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.125, // = Line Height из Figma / Размер шрифта
  );

  static const TextStyle sightCardTypeTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.286,
  );

  static const TextStyle sightCardNameTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  static const TextStyle sightCardDetailsTextStyle = TextStyle(
    color: AppColors.secondary2Color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );
}
