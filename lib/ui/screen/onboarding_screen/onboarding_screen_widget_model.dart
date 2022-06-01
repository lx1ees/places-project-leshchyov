import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/onboarding_item.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:provider/provider.dart';

/// Фабрика для [OnboardingScreenWidgetModel]
OnboardingScreenWidgetModel onboardingScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();

  return OnboardingScreenWidgetModel(
    model: OnboardingScreenModel(),
    themeWrapper: dependencies.themeWrapper,
    navigator: Navigator.of(context),
  );
}

/// Виджет-модель для [OnboardingScreen]
class OnboardingScreenWidgetModel
    extends WidgetModel<OnboardingScreen, OnboardingScreenModel>
    with SingleTickerProviderWidgetModelMixin
    implements IOnboardingScreenWidgetModel {
  /// Список элементов онбординга
  final List<OnboardingItem> _onboardingItems = [
    const OnboardingItem(
      title: AppStrings.tutorial1Title,
      subtitle: AppStrings.tutorial1Subtitle,
      iconPath: AppAssets.tutorial1Icon,
    ),
    const OnboardingItem(
      title: AppStrings.tutorial2Title,
      subtitle: AppStrings.tutorial2Subtitle,
      iconPath: AppAssets.tutorial2Icon,
    ),
    const OnboardingItem(
      title: AppStrings.tutorial3Title,
      subtitle: AppStrings.tutorial3Subtitle,
      iconPath: AppAssets.tutorial3Icon,
    ),
  ];

  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Навигатор
  final NavigatorState _navigator;

  final _currentPageState = StateNotifier<int>();

  @override
  List<OnboardingItem> get onboardingItems => _onboardingItems;

  @override
  ThemeData get theme => _theme;

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ListenableState<int> get currentPageState => _currentPageState;

  OnboardingScreenWidgetModel({
    required OnboardingScreenModel model,
    required ThemeWrapper themeWrapper,
    required NavigatorState navigator,
  })  : _themeWrapper = themeWrapper,
        _navigator = navigator,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
    _theme = _themeWrapper.getTheme(context);
    _currentPageState.accept(0);
  }

  @override
  void onClose() {
    if (widget.fromLaunch) {
      AppRoutes.navigateToHomeScreen(context: context);
    } else {
      _navigator.pop();
    }
  }

  @override
  void onPageChanged(int page) => _currentPageState.accept(page);
}

abstract class IOnboardingScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Список элементов онбординга
  List<OnboardingItem> get onboardingItems;

  /// Состояние текущей страницы
  ListenableState<int> get currentPageState;

  /// Обработчик закрытия экрана онбординга
  void onClose();

  /// Обработчик смены страницы
  void onPageChanged(int page);
}
