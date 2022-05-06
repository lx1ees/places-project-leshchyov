import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/theme_mode_holder.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/res/themes.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    themeModeHolder.addListener(_themeModeHolderListener);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeHolder.currentThemeMode,
      navigatorKey: AppRoutes.navigators[AppRoutes.mainNavigatorKey],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
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
  }

  @override
  void dispose() {
    themeModeHolder.removeListener(_themeModeHolderListener);
    super.dispose();
  }

  void _themeModeHolderListener() {
    setState(() {});
  }
}
