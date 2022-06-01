import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/data/storage/settings_storage.dart';

/// Менеджер настроек
class SettingsManager {
  final ISettingsStorage settingsStorage;
  final _currentThemeModeState =
      StateNotifier<ThemeMode>(initValue: ThemeMode.light);
  bool isFirstLaunch = true;

  /// Состояние текущей темы приложения
  StateNotifier<ThemeMode> get currentThemeModeState => _currentThemeModeState;

  SettingsManager({
    required this.settingsStorage,
  });

  /// Метод установки темы
  void setThemeMode({required bool isDark}) {
    settingsStorage.writeThemeSettings(isDark: isDark);
    _currentThemeModeState.accept(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Инициализация темы при старте
  Future<void> initTheme() async {
    final currentTheme = await settingsStorage.readThemeSettings();
    setThemeMode(isDark: currentTheme ?? false);
  }

  /// Метод установки признака первого входа
  void setIsFirstLaunch() => settingsStorage.writeIsFirstLaunch();

  /// Инициализация настройки признака первого входа при старте
  Future<void> initIsFirstLaunch() async {
    isFirstLaunch = !(await settingsStorage.readIsFirstLaunch() ?? false);
  }
}
