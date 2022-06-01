/// Интерфейс хранилища настроек
abstract class ISettingsStorage {
  /// Сохраняет значение настройки темы [isDark]
  Future<bool> writeThemeSettings({required bool isDark});

  /// Читает значение настройки темы
  Future<bool?> readThemeSettings();

  /// Сохраняет значение настройки признака первого входа в приложение
  Future<bool> writeIsFirstLaunch();

  /// Читает значение настройки признака первого входа в приложение
  Future<bool?> readIsFirstLaunch();
}
