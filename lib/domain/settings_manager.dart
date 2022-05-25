import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Менеджер настроек
class SettingsManager {
  final _currentThemeModeState =
      StateNotifier<ThemeMode>(initValue: ThemeMode.light);

  /// Состояние текущей темы приложения
  StateNotifier<ThemeMode> get currentThemeModeState => _currentThemeModeState;

  /// Метод установки темы
  void setThemeMode({required bool isDark}) {
    _currentThemeModeState.accept(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
