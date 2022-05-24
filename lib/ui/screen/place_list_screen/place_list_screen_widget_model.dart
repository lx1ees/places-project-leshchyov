import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet_widget_model.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/utils/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Фабрика для [PlaceListScreenWidgetModel]
PlaceListScreenWidgetModel placeListScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = PlaceListScreenModel(
    errorHandler: context.read<DefaultErrorHandler>(),
    placeInteractor: context.read<PlaceInteractor>(),
  );

  return PlaceListScreenWidgetModel(
    themeWrapper: context.read<ThemeWrapper>(),
    filtersManager: context.read<FiltersManager>(),
    model: model,
  );
}

/// Виджет-модель для [PlaceListScreenModel]
class PlaceListScreenWidgetModel
    extends WidgetModel<PlaceListScreen, PlaceListScreenModel>
    implements IPlaceListScreenWidgetModel {
  /// Менеджер фильтров
  final FiltersManager _filtersManager;

  /// Контроллер прокрутки списка
  final ScrollController _scrollController = ScrollController();

  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Состояние списка мест
  final _listPlacesEntityState = EntityStateNotifier<List<Place>>();

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  ScrollController get listScrollController => _scrollController;

  @override
  ListenableState<EntityState<List<Place>>> get listPlacesState =>
      _listPlacesEntityState;

  PlaceListScreenWidgetModel({
    required PlaceListScreenModel model,
    required FiltersManager filtersManager,
    required ThemeWrapper themeWrapper,
  })  : _filtersManager = filtersManager,
        _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _theme = _themeWrapper.getTheme(context);
    _colorScheme = _theme.colorScheme;

    _requestForPlaces();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void onFavoritePressed(Place place) => model.changeFavorite(place);

  @override
  void onPlaceCardPressed(Place place) => _openPlaceDetailsBottomSheet(place);

  @override
  void onAddNewPlacePressed() => _openAddNewPlaceScreen();

  @override
  void onFiltersPressed() => _openFiltersScreen();

  @override
  void onSearchPressed() => _openSearchScreen();

  /// Получение списка мест из модели
  Future<void> _requestForPlaces() async {
    _listPlacesEntityState.loading();
    try {
      await for (final places in model.getPlaces(
        filtersManager: _filtersManager,
        currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
      )) {
        _listPlacesEntityState.content(places);
      }
    } on Exception catch (e) {
      _listPlacesEntityState.error(e);
    }
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _openPlaceDetailsBottomSheet(Place place) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: _colorScheme.primary.withOpacity(0.24),
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) {
        return PlaceDetailsBottomSheet(
          place: place,
          widgetModelFactory: placeDetailsBottomSheetWidgetModelFactory,
        );
      },
    );
    await _requestForPlaces();
  }

  /// Метод открытия окна добавления нового места
  Future<void> _openAddNewPlaceScreen() async {
    await AppRoutes.navigateToAddNewPlaceScreen(context: context);
    await _requestForPlaces();
  }

  /// Метод открытия окна с фильтрами
  Future<void> _openFiltersScreen() async {
    await AppRoutes.navigateToFiltersScreen(
      context: context,
      filtersManager: _filtersManager,
    );
    await _requestForPlaces();
  }

  /// Метод открытия окна поиска
  Future<void> _openSearchScreen() async {
    await AppRoutes.navigateToSearchScreen(context: context);
    await _requestForPlaces();
  }
}

abstract class IPlaceListScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Контроллер прокрутки списка мест
  ScrollController get listScrollController;

  /// Состояние списка мест
  ListenableState<EntityState<List<Place>>> get listPlacesState;

  /// Обработчик нажатия на кнопку добавления/удаления в/из избранно-е/-го
  /// места [place]
  void onFavoritePressed(Place place);

  /// Обработчик нажатия на карточку места [place]
  void onPlaceCardPressed(Place place);

  /// Обработчик нажатия на кнопку для добавления нового места
  void onAddNewPlacePressed();

  /// Обработчик нажатия на кнопку Фильтры
  void onFiltersPressed();

  /// Обработчик нажатия на строку поиска
  void onSearchPressed();
}
