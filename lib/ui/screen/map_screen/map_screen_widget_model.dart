import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/map_screen/map_screen.dart';
import 'package:places/ui/screen/map_screen/map_screen_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/utils/deffered_execution_provider.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Фабрика для [MapScreenWidgetModel]
MapScreenWidgetModel mapScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = MapScreenModel(
    errorHandler: dependencies.errorHandler,
    placeInteractor: dependencies.placeInteractor,
  );

  return MapScreenWidgetModel(
    themeWrapper: dependencies.themeWrapper,
    model: model,
  );
}

/// Виджет-модель для [MapScreenModel]
class MapScreenWidgetModel extends WidgetModel<MapScreen, MapScreenModel>
    with DefferedExecutionProvider
    implements IMapScreenWidgetModel {
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

  MapScreenWidgetModel({
    required MapScreenModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _theme = _themeWrapper.getTheme(context);
    _colorScheme = _theme.colorScheme;
    _listPlacesEntityState.content([]);
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
  void onPlaceCardPressed(Place place) => _navigateToPlaceDetailsScreen(place);

  @override
  void onAddNewPlacePressed() => _openAddNewPlaceScreen();

  @override
  void onFiltersPressed() => _openFiltersScreen();

  @override
  void onSearchPressed() => _openSearchScreen();

  @override
  void onMapCreated(YandexMapController mapController) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    mapController.setMapStyle(
      isDark ? AppConstants.mapDarkStyle : AppConstants.mapStyle,
    );
  }

  /// Получение списка мест из модели
  Future<void> _requestForPlaces() async {
    deffered(_listPlacesEntityState.loading, delay: 2);
    final filtersManager = await model.getFiltersManager();
    try {
      await for (final places in model.getPlaces(
        filtersManager: filtersManager,
      )) {
        cancelDeffered();
        _listPlacesEntityState.content(places);
      }
    } on Exception catch (e) {
      _listPlacesEntityState.error(e);
    }
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _navigateToPlaceDetailsScreen(Place place) async {
    await AppRoutes.navigateToPlaceDetailsScreen(
      context: context,
      place: place,
    );
    Future.delayed(const Duration(milliseconds: 200), _requestForPlaces);
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
    );
    await _requestForPlaces();
  }

  /// Метод открытия окна поиска
  Future<void> _openSearchScreen() async {
    await AppRoutes.navigateToSearchScreen(context: context);
    await _requestForPlaces();
  }
}

abstract class IMapScreenWidgetModel extends IWidgetModel {
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

  /// ----------

  /// Обработчик создания карты
  void onMapCreated(YandexMapController mapController);
}
