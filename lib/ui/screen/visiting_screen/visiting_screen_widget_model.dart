import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_model.dart';
import 'package:places/utils/datetime_utils.dart';
import 'package:provider/provider.dart';

/// Фабрика для [VisitingScreenWidgetModel]
VisitingScreenWidgetModel visitingScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = VisitingScreenModel(
    errorHandler: dependencies.errorHandler,
    placeInteractor: dependencies.placeInteractor,
  );

  return VisitingScreenWidgetModel(
    model: model,
    themeWrapper: dependencies.themeWrapper,
  );
}

/// Виджет-модель для [VisitingScreenModel]
class VisitingScreenWidgetModel
    extends WidgetModel<VisitingScreen, VisitingScreenModel>
    with TickerProviderWidgetModelMixin
    implements IVisitingScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Контроллер табов
  late final TabController _tabController;

  final _listFavoritePlacesEntityState = EntityStateNotifier<List<Place>>();
  final _listVisitedPlacesEntityState = EntityStateNotifier<List<Place>>();

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  TabController get tabController => _tabController;

  @override
  ListenableState<EntityState<List<Place>>> get listFavoritePlacesState =>
      _listFavoritePlacesEntityState;

  @override
  ListenableState<EntityState<List<Place>>> get listVisitedPlacesState =>
      _listVisitedPlacesEntityState;

  VisitingScreenWidgetModel({
    required VisitingScreenModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
    _theme = _themeWrapper.getTheme(context);
    _tabController = TabController(length: 2, vsync: this);
    _requestForPlaces();
    _tabController.addListener(_requestForPlaces);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void onChangeOrderInFavorites(int fromIndex, int toIndex) {
    model.changeOrderInFavorites(
      fromIndex: fromIndex,
      toIndex: toIndex,
    );
    _requestForFavoritesPlaces();
  }

  @override
  void onChangeOrderInVisited(int fromIndex, int toIndex) {
    model.changeOrderInVisited(
      fromIndex: fromIndex,
      toIndex: toIndex,
    );
    _requestForVisitedPlaces();
  }

  @override
  void onDeleteFavoritePlacePressed(Place place) {
    model.removePlaceFromFavorites(place: place);
    _requestForFavoritesPlaces();
  }

  @override
  void onDeleteVisitedPlacePressed(Place place) {
    model.removePlaceFromVisited(place: place);
    _requestForVisitedPlaces();
  }

  @override
  void onPlaceCardPressed(Place place) {
    _navigateToPlaceDetailsScreen(place).then((_) {
      if (place.isInFavorites) {
        _requestForFavoritesPlaces();
      } else if (place.isVisited) {
        _requestForVisitedPlaces();
      }
    });
  }

  @override
  void onPlanPlacePressed(Place place) {
    DateTimeUtils.pickPlanDate(context).then((planDate) {
      if (planDate != null) {
        model.setPlacePlanDate(place: place, planDate: planDate);
        _requestForFavoritesPlaces();
      }
    });
  }

  /// Получение списков всех мест
  void _requestForPlaces() {
    _requestForFavoritesPlaces();
    _requestForVisitedPlaces();
  }

  /// Получение списка избранных мест
  Future<void> _requestForFavoritesPlaces() async {
    _listFavoritePlacesEntityState.loading();

    try {
      final favoritePlaces = model.favoritePlaces();
      _listFavoritePlacesEntityState.content(favoritePlaces);
    } on Exception catch (e) {
      _listFavoritePlacesEntityState.error(e);
    }
  }

  /// Получение списка посещенных мест
  Future<void> _requestForVisitedPlaces() async {
    _listVisitedPlacesEntityState.loading();
    try {
      final visitedPlaces = model.visitedPlaces();
      _listVisitedPlacesEntityState.content(visitedPlaces);
    } on Exception catch (e) {
      _listVisitedPlacesEntityState.error(e);
    }
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _navigateToPlaceDetailsScreen(
    Place place,
  ) async {
    await AppRoutes.navigateToPlaceDetailsScreen(
      context: context,
      place: place,
    );
  }
}

abstract class IVisitingScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Контроллер табов
  TabController get tabController;

  /// Состояние списка "Хочу посетить"
  ListenableState<EntityState<List<Place>>> get listFavoritePlacesState;

  /// Состояние списка "Посещенные места"
  ListenableState<EntityState<List<Place>>> get listVisitedPlacesState;

  /// Обработчик перемещения карточки в списке "Хочу посетить" с индекса
  /// [fromIndex] на индекс [toIndex]
  void onChangeOrderInFavorites(
    int fromIndex,
    int toIndex,
  );

  /// Обработчик перемещения карточки в списке "Посещенные места" с индекса
  /// [fromIndex] на индекс [toIndex]
  void onChangeOrderInVisited(
    int fromIndex,
    int toIndex,
  );

  /// Обработчик планирования даты посещения места [place]
  void onPlanPlacePressed(Place place);

  /// Обработчик удаления места [place] из списка избранного
  void onDeleteFavoritePlacePressed(Place place);

  /// Обработчик удаления места [place] из списка посещенных мест
  void onDeleteVisitedPlacePressed(Place place);

  /// Обработчик нажатия на карточку места [place]
  void onPlaceCardPressed(Place place);
}
