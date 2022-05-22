import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/utils/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Класс обертка над App с DI
class AppScoped extends StatefulWidget {
  final Widget child;

  const AppScoped({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<AppScoped> createState() => _AppScopedState();
}

class _AppScopedState extends State<AppScoped> {
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
    final settingsInteractor = SettingsInteractor();

    return MultiProvider(
      providers: [
        Provider.value(value: filtersManager),
        Provider.value(value: filtersManager),
        Provider.value(value: placeInteractor),
        Provider.value(value: searchInteractor),
        Provider.value(value: settingsInteractor),
        Provider.value(value: errorHandler),
        Provider<ThemeWrapper>(create: (_) => themeWrapper),
      ],
      child: widget.child,
    );
  }
}
