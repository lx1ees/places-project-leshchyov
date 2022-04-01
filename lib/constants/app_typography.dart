import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';

class AppTypography {
  /// Типография приложения
  static const TextStyle appBarTitleTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.125, // = Line Height из Figma / Размер шрифта
  );

  /// Типография карточки достопримечательности
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

  static const TextStyle sightCardVisitInfoTextStyle = TextStyle(
    color: AppColors.secondary2Color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );

  static const TextStyle sightCardDetailsTextStyle = TextStyle(
    color: AppColors.secondary2Color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );

  /// Типография окна детальной информации достопримечательности
  static const TextStyle sightDetailsNameTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const TextStyle sightDetailsTypeTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.286,
  );

  static const TextStyle sightDetailsScheduleStyle = TextStyle(
    color: AppColors.secondary2Color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );

  static const TextStyle sightDetailsDescriptionTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );

  static const TextStyle sightDetailsButtonTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.286,
  );

  static const TextStyle sightDetailsRouteButtonTextStyle = TextStyle(
    color: AppColors.defaultButtonTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.286,
  );

  /// Типография окна Избранное
  static const TextStyle favoriteScreenAppBarTitleTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.333, // = Line Height из Figma / Размер шрифта
  );

  static const TextStyle favoriteScreenTabTitleTextStyle = TextStyle(
    color: AppColors.tabBarSelectedTitleColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.286, // = Line Height из Figma / Размер шрифта
  );
}
