import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/domain/settings_manager.dart';
import 'package:places/utils/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Класс обертка над App с DI
class AppScoped extends StatelessWidget {
  final Widget child;

  const AppScoped({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorHandler = DefaultErrorHandler();
    final themeWrapper = ThemeWrapper();
    final filtersManager = FiltersManager();
    final searchHistoryManager = SearchHistoryManager();
    final placeRepository = PlaceRepository(NetworkService());
    final placeInteractor = PlaceInteractor(
      repository: placeRepository,
    );
    final searchInteractor = SearchInteractor(
      repository: placeRepository,
      filtersManager: filtersManager,
      searchHistoryManager: searchHistoryManager,
    );
    final settingsManager = SettingsManager();

    return MultiProvider(
      providers: [
        Provider.value(value: filtersManager),
        Provider.value(value: searchHistoryManager),
        Provider.value(value: placeInteractor),
        Provider.value(value: searchInteractor),
        Provider.value(value: errorHandler),
        Provider.value(value: settingsManager),
        Provider<ThemeWrapper>(create: (_) => themeWrapper),
      ],
      child: child,
    );
  }
}
