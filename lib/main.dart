import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/app_scoped.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppScoped(child: App()));
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
    context
        .read<SettingsInteractor>()
        .themeModeHolder
        .addListener(_themeModeHolderListener);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.read<SettingsInteractor>().themeModeHolder.currentThemeMode,
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
  }

  @override
  void dispose() {
    context
        .read<SettingsInteractor>()
        .themeModeHolder
        .removeListener(_themeModeHolderListener);
    super.dispose();
  }

  void _themeModeHolderListener() {
    setState(() {});
  }
}
