import 'package:places/theme_mode_holder.dart';

/// Интерактор экрана настроек
class SettingsInteractor{
  /// Пока нет стейтменеджмента, держу ссылку на ThemeModeHolder тут, позже
  /// от него избавлюсь
  final ThemeModeHolder themeModeHolder = ThemeModeHolder();

  /// Метод установки темы
  void setThemeMode({required bool isDark}) {
    themeModeHolder.setThemeMode(isDark: isDark);
  }
}