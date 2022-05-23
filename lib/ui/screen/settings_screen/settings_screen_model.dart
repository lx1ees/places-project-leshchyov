import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/settings_manager.dart';

class SettingsScreenModel extends ElementaryModel {
  final SettingsManager settingsManager;

  StateNotifier<ThemeMode> get currentThemeModeState =>
      settingsManager.currentThemeModeState;

  ThemeMode get currentThemeMode =>
      currentThemeModeState.value ?? ThemeMode.light;

  SettingsScreenModel({
    required ErrorHandler errorHandler,
    required this.settingsManager,
  }) : super(errorHandler: errorHandler);

  void setThemeMode({required bool isDark}) =>
      settingsManager.setThemeMode(isDark: isDark);
}
