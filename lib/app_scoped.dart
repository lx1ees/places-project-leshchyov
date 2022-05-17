import 'package:flutter/material.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
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
    final filtersManager = FiltersManager();
    final placeRepository = PlaceRepository(NetworkService());
    final placeInteractor = PlaceInteractor(
      repository: placeRepository,
    );
    final searchInteractor = SearchInteractor(
      repository: placeRepository,
      filtersManager: filtersManager,
    );
    final settingsInteractor = SettingsInteractor();

    return MultiProvider(
      providers: [
        Provider.value(value: filtersManager),
        Provider.value(value: filtersManager),
        Provider.value(value: placeInteractor),
        Provider.value(value: searchInteractor),
        Provider.value(value: settingsInteractor),
      ],
      child: widget.child,
    );
  }
}
