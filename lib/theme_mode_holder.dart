import 'package:flutter/material.dart';

/// Временный глобальный экземпляр ченджнотифаера
final themeModeHolder = ThemeModeHolder();

/// Временный класс-холдер режима темы
class ThemeModeHolder extends ChangeNotifier {
  ThemeMode currentThemeMode = ThemeMode.light;

  void setThemeMode({required bool isDark}) {
    currentThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
