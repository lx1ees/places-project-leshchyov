import 'package:elementary/elementary.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/settings_manager.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_widget_model.dart';

/// Модель для [SplashScreenWidgetModel]
class SplashScreenModel extends ElementaryModel {
  final SettingsManager settingsManager;

  bool get isFirstLaunch => settingsManager.isFirstLaunch;

  SplashScreenModel({
    required this.settingsManager,
  });

  /// Метод инициализации настроек приложения
  Future<bool> initSettings() async {
    await settingsManager.initTheme();
    await settingsManager.initIsFirstLaunch();

    return true;
  }

  /// Метод установки признака первого входа
  void setIsFirstLaunch() => settingsManager.setIsFirstLaunch();

  /// Метод для определения, прошла ли инициализация и можно ли закрывать сплеш
  Future<bool> isSplashOver() async {
    final isInitialized = initSettings();
    final isMinSplashTimeOver = Future.delayed(
      const Duration(seconds: AppConstants.minSplashTimeInSec),
      () => true,
    );

    return !(await Future.wait([isInitialized, isMinSplashTimeOver]))
        .contains(false);
  }
}
