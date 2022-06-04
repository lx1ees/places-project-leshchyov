import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/map_screen/map_screen.dart';
import 'package:places/ui/screen/map_screen/map_screen_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/utils/dialog_utils.dart';
import 'package:places/utils/ui_utils.dart';
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
    with SingleTickerProviderWidgetModelMixin
    implements IMapScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Состояние списка плейсмарков на карте
  final _listPlacemarksState = StateNotifier<List<PlacemarkMapObject>>();

  /// Состояние выбрранного места на карте
  final _selectedPlaceState = StateNotifier<Place>();

  final List<Place> _listPlaces = [];

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  ListenableState<List<PlacemarkMapObject>> get listPlacemarksState =>
      _listPlacemarksState;

  @override
  ListenableState<Place?> get selectedPlaceState => _selectedPlaceState;

  YandexMapController? _mapController;

  /// Флаг для определения, бало ли выбрано место на карте (нужно для того, чтобы
  /// обработчик нажатия на карту не закрывал сразу же карточку)
  bool _isPlacemarkTapped = false;

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

    _requestForPlaces();
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

  @override
  void onMapTap(Point point) {
    if (_isPlacemarkTapped || _selectedPlaceState.value == null) return;
    _selectedPlaceState.accept(null);
    _updateMapObjects();
    _moveCameraTo(
      LocationPoint(
        lat: point.latitude,
        lon: point.longitude,
      ),
    );
  }

  @override
  Future<void> onMapCreated(YandexMapController mapController) async {
    _mapController = mapController;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    await mapController.setMapStyle(
      isDark ? AppConstants.mapDarkStyle : AppConstants.mapStyle,
    );

    await mapController.toggleUserLayer(visible: true, autoZoomEnabled: true);
    await _moveCameraToCurrentLocation();
    await _requestForPlaces();
  }

  @override
  Future<UserLocationView>? onUserLocationAdded(
    UserLocationView userLocationView,
  ) async {
    final customIconAssetName = UiUtils.getValueByTheme<String>(
      context: context,
      defaultValue: AppAssets.currentLocationIcon,
      darkValue: AppAssets.currentLocationIconDark,
    );

    return userLocationView.copyWith(
      pin: userLocationView.pin.copyWith(
        opacity: 1.0,
      ),
      arrow: userLocationView.arrow.copyWith(
        opacity: 1.0,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(customIconAssetName),
            scale: 2,
          ),
        ),
      ),
      accuracyCircle: userLocationView.accuracyCircle.copyWith(
        fillColor: Colors.transparent,
        strokeColor: Colors.transparent,
      ),
    );
  }

  @override
  Future<void> onUpdateGeo() async {
    try {
      await model.updateCurrentLocation();
      await _moveCameraToCurrentLocation();
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

  @override
  void onUpdateMap() => _requestForPlaces();

  @override
  Future<void> onMakeRoute(Place place) async {
    final availableMaps = await MapLauncher.installedMaps;
    final lat = place.point.lat;
    final lon = place.point.lon;
    if (availableMaps.isNotEmpty) {
      await model.addPlaceInVisited(place: place);
      await MapLauncher.showDirections(
        mapType: availableMaps.first.mapType,
        destination: Coords(lat, lon),
      );
    }
  }

  Future<void> _onRequestForLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await onUpdateGeo();
    }
  }

  Future<void> _moveCameraToCurrentLocation() async {
    final currentLocation = await model.getCurrentLocation();
    await _moveCameraTo(currentLocation);
  }

  Future<void> _moveCameraTo(LocationPoint? point) async {
    if (point != null) {
      await _mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: point.lat,
              longitude: point.lon,
            ),
            zoom: 13,
          ),
        ),
        animation: const MapAnimation(
          // type: MapAnimationType.smooth,
          duration: 0.3,
        ),
      );
    }
  }

  Future<void> _updateMapObjects() async {
    final placeIconAssetName = UiUtils.getValueByTheme<String>(
      context: context,
      defaultValue: AppAssets.placemarkIcon,
      darkValue: AppAssets.placemarkIconDark,
    );

    final selectedPlaceIconAssetName = UiUtils.getValueByTheme<String>(
      context: context,
      defaultValue: AppAssets.placemarkSelectedIcon,
      darkValue: AppAssets.placemarkSelectedIconDark,
    );

    final mapObjects = _listPlaces.map((place) {
      return PlacemarkMapObject(
        mapId: MapObjectId(place.id.toString()),
        point: Point(
          latitude: place.point.lat,
          longitude: place.point.lon,
        ),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              _selectedPlaceState.value?.id == place.id
                  ? selectedPlaceIconAssetName
                  : placeIconAssetName,
            ),
            scale: _selectedPlaceState.value?.id == place.id ? 0.75 : 1,
          ),
        ),
        onTap: (mapObject, point) async {
          _isPlacemarkTapped = true;
          if (_selectedPlaceState.value?.id == place.id) return;
          _selectedPlaceState.accept(place);
          await _updateMapObjects();
          _isPlacemarkTapped = false;
        },
      );
    }).toList();
    _listPlacemarksState.accept(mapObjects);
    await _moveCameraTo(_selectedPlaceState.value?.point);
  }

  /// Получение списка мест из модели
  Future<void> _requestForPlaces() async {
    final filtersManager = await model.getFiltersManager();
    try {
      await for (final places in model.getPlaces(
        filtersManager: filtersManager,
      )) {
        _listPlaces
          ..clear()
          ..addAll(places);
        if (!_listPlaces.contains(_selectedPlaceState.value)) {
          _selectedPlaceState.accept(null);
        }
        await _updateMapObjects();
      }
    } on Exception catch (_) {
      if (!isMounted) return;
      DialogUtils.showSnackBar(
        context: context,
        title: AppStrings.errorWhileUpdatingPlaces,
      );
    }
  }

  /// Получение локального списка мест из модели (например, после того как
  /// добавили место в избранное или в помещегнные, где не требуется запрос в сеть)
  Future<void> _requestForLocalPlaces() async {
    try {
      final places = await model.getLocalPlaces();
      _listPlaces
        ..clear()
        ..addAll(places);
      _updateSelectedPlace();
      await _updateMapObjects();
    } on Exception catch (_) {
      if (!isMounted) return;
      DialogUtils.showSnackBar(
        context: context,
        title: AppStrings.errorWhileUpdatingPlaces,
      );
    }
  }

  void _updateSelectedPlace() {
    final idx =
        _listPlaces.indexWhere((e) => e.id == _selectedPlaceState.value?.id);
    if (idx != -1) {
      _selectedPlaceState.accept(_listPlaces[idx]);
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
    await _requestForPlaces();
  }
}

abstract class IMapScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Состояние списка индикаторов мест на карте
  ListenableState<List<PlacemarkMapObject>> get listPlacemarksState;

  /// Состояние выбранного места на карте
  ListenableState<Place?> get selectedPlaceState;

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

  /// Обработчик создания карты
  void onMapCreated(YandexMapController mapController);

  /// Обработчик нажатия на карту
  void onMapTap(Point point);

  /// Обработчик нажатия на кнопку Обновить карту
  void onUpdateMap();

  /// Обработчик нажатия на кнопку Запросить геолокацию
  void onUpdateGeo();

  /// Обработчик события добавления текущего метоположения на карту
  Future<UserLocationView>? onUserLocationAdded(
    UserLocationView userLocationView,
  );

  /// Обработчик открытия нативной карты
  void onMakeRoute(Place place);
}
