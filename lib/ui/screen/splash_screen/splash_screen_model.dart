import 'package:elementary/elementary.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_widget_model.dart';

/// Модель для [SplashScreenWidgetModel]
class SplashScreenModel extends ElementaryModel {
  /// Метод для определения, прошла ли инициализация и можно ли закрывать сплеш
  Future<bool> isSplashOver() async {
    final isInitialized =
        Future.delayed(const Duration(seconds: 2), () => true);
    final isMinSplashTimeOver = Future.delayed(
      const Duration(seconds: AppConstants.minSplashTimeInSec),
      () => true,
    );

    return !(await Future.wait([isInitialized, isMinSplashTimeOver]))
        .contains(false);
  }
}
