import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/app/app_widget_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/res/themes.dart';

class App extends ElementaryWidget<IAppWidgetModel> {
  const App({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IAppWidgetModel wm) {
    return StateNotifierBuilder<ThemeMode>(
      listenableState: wm.currentThemeModeState,
      builder: (_, currentThemeMode) {
        return MaterialApp(
          title: AppStrings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentThemeMode,
          navigatorKey: AppRoutes.navigators[AppRoutes.mainNavigatorKey],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            AppConstants.locale,
          ],
          onGenerateRoute: (settings) {
            return MaterialPageRoute<Object?>(
              builder: AppRoutes.routeBuilder(
                route: settings.name,
                arguments: settings.arguments,
              ),
              settings: settings,
            );
          },
        );
      },
    );
  }
}