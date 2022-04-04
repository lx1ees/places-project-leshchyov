import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

class AppTheme {

  /// Тема по-умолчанию - светлая
  static ThemeData get customTheme {
    final theme = ThemeData.light();

    return theme.copyWith(
      primaryColor: AppColors.whiteColor,
      primaryColorLight: AppColors.backgroundColor,
      primaryColorDark: AppColors.backgroundColor,
      colorScheme: theme.colorScheme.copyWith(
        background: AppColors.inactiveBlackColor,
        secondary: AppColors.greenColor,
        secondaryContainer: AppColors.secondary2Color,
        onPrimary: AppColors.secondaryColor,
        primary: AppColors.mainColor,
        error: AppColors.redColor,
        onPrimaryContainer: AppColors.secondaryColor,
        onSecondaryContainer: AppColors.secondary2Color,
      ),
      backgroundColor: AppColors.whiteColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      disabledColor: AppColors.backgroundColor,
      appBarTheme: theme.appBarTheme.copyWith(
        color: AppColors.whiteColor,
      ),
      tabBarTheme: theme.tabBarTheme.copyWith(
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.inactiveBlackColor,
        indicator: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius:
              BorderRadius.circular(AppConstants.defaultTabBorderRadius),
        ),
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.secondaryColor,
      ),
    );
  }

  /// Темная тема
  static ThemeData get customDarkTheme {
    final theme = ThemeData.dark();

    return theme.copyWith(
      primaryColor: AppColors.mainDarkColor,
      primaryColorLight: AppColors.darkColor,
      primaryColorDark: AppColors.darkColor,
      colorScheme: theme.colorScheme.copyWith(
        background: AppColors.inactiveBlackColor,
        secondary: AppColors.greenDarkColor,
        secondaryContainer: AppColors.secondary2Color,
        onPrimary: AppColors.whiteColor,
        primary: AppColors.whiteColor,
        error: AppColors.redDarkColor,
        onPrimaryContainer: AppColors.secondary2Color,
        onSecondaryContainer: AppColors.inactiveBlackColor,
      ),
      backgroundColor: AppColors.mainDarkColor,
      scaffoldBackgroundColor: AppColors.mainDarkColor,
      disabledColor: AppColors.mainDarkColor,
      appBarTheme: theme.appBarTheme.copyWith(
        color: AppColors.mainDarkColor,
      ),
      tabBarTheme: theme.tabBarTheme.copyWith(
        labelColor: AppColors.secondaryColor,
        unselectedLabelColor: AppColors.secondary2Color,
        indicator: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius:
              BorderRadius.circular(AppConstants.defaultTabBorderRadius),
        ),
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: AppColors.mainDarkColor,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
    );
  }
}
