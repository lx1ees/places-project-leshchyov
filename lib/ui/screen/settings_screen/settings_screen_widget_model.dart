import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/settings_screen/settings_screen.dart';
import 'package:places/ui/screen/settings_screen/settings_screen_model.dart';
import 'package:provider/provider.dart';

SettingsScreenWidgetModel settingsScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = SettingsScreenModel(
    errorHandler: dependencies.errorHandler,
    settingsManager: dependencies.settingsManager,
  );

  return SettingsScreenWidgetModel(
    model: model,
    themeWrapper: dependencies.themeWrapper,
  );
}

class SettingsScreenWidgetModel
    extends WidgetModel<SettingsScreen, SettingsScreenModel>
    implements ISettingsScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  @override
  ColorScheme get colorScheme => _themeWrapper.getTheme(context).colorScheme;

  @override
  ThemeData get theme => _themeWrapper.getTheme(context);

  @override
  bool get isDarkMode => model.currentThemeMode == ThemeMode.dark;

  SettingsScreenWidgetModel({
    required SettingsScreenModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void onShowOnboardingPressed() => _openOnboardingScreen();

  @override
  void onThemeChanged(bool isDark) {
    model.setThemeMode(isDark: isDark);
  }

  /// Метод открытия окна  с онбордингом
  Future<void> _openOnboardingScreen() async {
    await AppRoutes.navigateToOnboardingScreen(context: context);
  }
}

abstract class ISettingsScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Признак активной темной темы
  bool get isDarkMode;

  /// Обработчик переключения темы
  // ignore: avoid_positional_boolean_parameters
  void onThemeChanged(bool isDark);

  /// ОБработчик нажатия на кнопку открытия онбординга
  void onShowOnboardingPressed();
}
