import 'dart:math';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_model.dart';
import 'package:provider/provider.dart';

/// Фабрика для [SplashScreenWidgetModel]
SplashScreenWidgetModel splashScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();

  return SplashScreenWidgetModel(
    model: SplashScreenModel(
      settingsManager: dependencies.settingsManager,
    ),
    navigator: Navigator.of(context),
  );
}

/// Виджет-модель для [SplashScreen]
class SplashScreenWidgetModel
    extends WidgetModel<SplashScreen, SplashScreenModel>
    with TickerProviderWidgetModelMixin
    implements ISplashScreenWidgetModel {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  /// Навигатор
  final NavigatorState _navigator;

  @override
  double get animationValue => _animation.value;

  @override
  AnimationController get controller => _animationController;

  SplashScreenWidgetModel({
    required SplashScreenModel model,
    required NavigatorState navigator,
  })  : _navigator = navigator,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppConstants.splashAnimationDurationInMillis,
      ),
    );
    _animation = Tween<double>(begin: 0, end: -2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.repeat();
    _navigateToNext();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Метод для навигации на следующий экран с логикой: ожидаем инициализацию,
  /// ожидаем минимальное время показа сплеша, не позволяем закрыть сплеш до тех пор,
  /// пока не будут выполнены все условия.
  Future<void> _navigateToNext() async {
    try {
      final isNavigationAllowed = await model.isSplashOver();

      if (isNavigationAllowed) {
        if (model.isFirstLaunch) {
          _navigator.pop();
          model.setIsFirstLaunch();
          await AppRoutes.navigateToOnboardingScreen(context: context);
        } else {
          await AppRoutes.navigateToHomeScreen(context: context);
        }

      }
    } on Exception catch (_) {}
  }
}

abstract class ISplashScreenWidgetModel extends IWidgetModel {
  /// Значение анимации в единицу времени
  double get animationValue;

  /// Контроллер анимации
  AnimationController get controller;
}
