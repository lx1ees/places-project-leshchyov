import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/res/themes.dart';

/// Пока нет нормального DI здесь хранятся все инстансы репозиториев и
/// интеракторов
FiltersManager filtersManager = FiltersManager();
PlaceRepository placeRepository = PlaceRepository(NetworkService());
PlaceInteractor placeInteractor = PlaceInteractor(
  repository: placeRepository,
);
SearchInteractor searchInteractor = SearchInteractor(
  repository: placeRepository,
  filtersManager: filtersManager,
);
SettingsInteractor settingsInteractor = SettingsInteractor();
/// ----------------------------------------------------------------------------

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
    settingsInteractor.themeModeHolder.addListener(_themeModeHolderListener);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsInteractor.themeModeHolder.currentThemeMode,
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
    settingsInteractor.themeModeHolder.removeListener(_themeModeHolderListener);
    super.dispose();
  }

  void _themeModeHolderListener() {
    setState(() {});
  }
}
