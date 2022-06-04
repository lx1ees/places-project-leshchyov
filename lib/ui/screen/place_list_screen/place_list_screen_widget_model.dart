import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/utils/deffered_execution_provider.dart';
import 'package:places/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

/// Фабрика для [PlaceListScreenWidgetModel]
PlaceListScreenWidgetModel placeListScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = PlaceListScreenModel(
    errorHandler: dependencies.errorHandler,
    placeInteractor: dependencies.placeInteractor,
  );

  return PlaceListScreenWidgetModel(
    themeWrapper: dependencies.themeWrapper,
    model: model,
  );
}

/// Виджет-модель для [PlaceListScreenModel]
class PlaceListScreenWidgetModel
    extends WidgetModel<PlaceListScreen, PlaceListScreenModel>
    with DefferedExecutionProvider
    implements IPlaceListScreenWidgetModel {
  /// Контроллер прокрутки списка
  final ScrollController _scrollController = ScrollController();

  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Состояние списка мест
  final _listPlacesEntityState = EntityStateNotifier<List<Place>>();

  @override
  ColorScheme get colorScheme => _themeWrapper.getTheme(context).colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  ScrollController get listScrollController => _scrollController;

  @override
  ListenableState<EntityState<List<Place>>> get listPlacesState =>
      _listPlacesEntityState;

  PlaceListScreenWidgetModel({
    required PlaceListScreenModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _theme = _themeWrapper.getTheme(context);
    _listPlacesEntityState.content([]);
    _requestForPlaces();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> onFavoritePressed(Place place) async {
    await model.changeFavorite(place);
    await _requestForLocalPlaces();
  }

  @override
  void onPlaceCardPressed(Place place) => _navigateToPlaceDetailsScreen(place);

  @override
  void onAddNewPlacePressed() => _openAddNewPlaceScreen();

  @override
  void onFiltersPressed() => _openFiltersScreen();

  @override
  void onSearchPressed() => _openSearchScreen();

  Future<void> _updateCurrentLocation() async {
    try {
      await model.updateCurrentLocation();
    } on PermissionDeniedException catch (_) {
      if (!isMounted) return;
      DialogUtils.showSnackBar(
        context: context,
        title: AppStrings.errorLocationPermissionDenied,
        actionTitle: AppStrings.allow,
        onPressedAction: _onRequestForLocationPermission,
      );
    }
  }

  Future<void> _onRequestForLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _updateCurrentLocation();
      await _requestForPlaces();
    }
  }

  /// Получение списка мест из модели
  Future<void> _requestForPlaces() async {
    _listPlacesEntityState.loading();
    await _updateCurrentLocation();
    final filtersManager = await model.getFiltersManager();
    try {
      await for (final places in model.getPlaces(
        filtersManager: filtersManager,
      )) {
        _listPlacesEntityState.content(places);
      }
    } on Exception catch (e) {
      _listPlacesEntityState.error(e);
    }
  }

  /// Получение локального списка мест из модели (например, после того как
  /// добавили место в избранное или в помещегнные, где не требуется запрос в сеть)
  Future<void> _requestForLocalPlaces() async {
    try {
      final places = await model.getLocalPlaces();
      _listPlacesEntityState.content(places);
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
    Future.delayed(const Duration(milliseconds: 200), _requestForLocalPlaces);
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
    // await _requestForPlaces();
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
