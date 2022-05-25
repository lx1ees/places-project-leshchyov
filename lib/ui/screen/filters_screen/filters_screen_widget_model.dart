import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_model.dart';
import 'package:places/utils/extensions.dart';
import 'package:provider/provider.dart';

/// Фабрика для [FiltersScreenWidgetModel]
FiltersScreenWidgetModel filtersScreenWidgetModelFactory(BuildContext context) {
  final dependencies = context.read<IAppScope>();
  final model = FiltersScreenModel(
    errorHandler: dependencies.errorHandler,
    placeInteractor: dependencies.placeInteractor,
  );

  return FiltersScreenWidgetModel(
    model: model,
    filtersManager: dependencies.filtersManager,
    navigator: Navigator.of(context),
  );
}

/// Виджет-модель для [FiltersScreenModel]
class FiltersScreenWidgetModel
    extends WidgetModel<FiltersScreen, FiltersScreenModel>
    implements IFiltersScreenWidgetModel {
  /// Менеджер фильтров
  final FiltersManager _filtersManager;

  /// Признак размера экрана
  late final bool _isSmallScreen;

  /// Локальный менеджер фильтров
  final FiltersManager _localFiltersManager = FiltersManager();

  final _filteredPlacesState = EntityStateNotifier<List<Place>>();
  final _placeTypesFilterState =
      StateNotifier<List<PlaceTypeFilterEntity>>(initValue: []);
  final _distanceFilterState = StateNotifier<DistanceFilter>();

  /// Навигатор
  final NavigatorState _navigator;

  @override
  ListenableState<EntityState<List<Place>>> get filteredPlacesState =>
      _filteredPlacesState;

  @override
  ListenableState<DistanceFilter> get distanceFilterState =>
      _distanceFilterState;

  @override
  ListenableState<List<PlaceTypeFilterEntity>> get placeTypesFilterState =>
      _placeTypesFilterState;

  @override
  String get distanceTitleRepresentation => _distanceTitleRepresentation(
        distanceFilterState.value?.distanceLeftThreshold ??
            AppConstants.distanceFilterMinValue,
        distanceFilterState.value?.distanceRightThreshold ??
            AppConstants.distanceFilterMaxValue,
      );

  @override
  bool get isSmallScreen => _isSmallScreen;

  FiltersScreenWidgetModel({
    required FiltersScreenModel model,
    required FiltersManager filtersManager,
    required NavigatorState navigator,
  })  : _filtersManager = filtersManager,
        _navigator = navigator,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _localFiltersManager.updateWith(_filtersManager);
    _updateFiltersStates(_localFiltersManager);
    _requestForPlaces(_localFiltersManager);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _isSmallScreen = MediaQuery.of(context).size.width * pixelRatio <=
            AppConstants.smallScreenWidth &&
        MediaQuery.of(context).size.height * pixelRatio <=
            AppConstants.smallScreenHeight;
  }

  @override
  void onClearFilters() {
    _localFiltersManager.clearFilters();
    _updateFiltersStates(_localFiltersManager);
    _requestForPlaces(_localFiltersManager);
  }

  @override
  void onDistanceChangeEnded(RangeValues values) {
    _requestForPlaces(_localFiltersManager);
  }

  @override
  void onDistanceChanged(RangeValues values) {
    _localFiltersManager.distanceFilter = DistanceFilter(
      distanceLeftThreshold: values.start,
      distanceRightThreshold: values.end,
    );
    _updateFiltersStates(_localFiltersManager);
  }

  @override
  void onPlaceTypeFilterTapped(
    PlaceTypeFilterEntity placeTypeFilterEntity,
    int index,
  ) {
    _localFiltersManager.updatePlaceTypeFilter(
      index: index,
      placeTypeFilterEntity: placeTypeFilterEntity,
    );
    _updateFiltersStates(_localFiltersManager);
    _requestForPlaces(_localFiltersManager);
  }

  @override
  void onFilteredListShown() {
    _filtersManager.updateWith(_localFiltersManager);
    _navigator.pop();
  }

  /// Получение списка мест из модели
  Future<void> _requestForPlaces(FiltersManager filtersManager) async {
    _filteredPlacesState.loading();
    try {
      final filteredPlaces = await model.getPlaces(
        filtersManager: filtersManager,
        currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
      );
      _filteredPlacesState.content(filteredPlaces);
    } on Exception catch (e) {
      _filteredPlacesState.error(e);
    }
  }

  /// Обвновление состояния фильтров из менеджера [filtersManager]
  void _updateFiltersStates(FiltersManager filtersManager) {
    _placeTypesFilterState.accept([...filtersManager.placeTypeFilters]);
    _distanceFilterState.accept(filtersManager.distanceFilter);
  }

  /// Формирование строки с информацией о выбранной дистанции
  String _distanceTitleRepresentation(
    double leftThreshold,
    double rightThreshold,
  ) {
    const oneKmInMeters = 1000;
    String _rightMeasure(double value, {bool addPostfix = false}) {
      if (value < oneKmInMeters) {
        return '${value.round()}${addPostfix ? ' ${AppStrings.meter}' : ''}';
      }
      final km = (value / oneKmInMeters).toPrecision(1);

      return '${km.isWhole ? km.round() : km}${addPostfix ? ' ${AppStrings.km}' : ''}';
    }

    if (leftThreshold < oneKmInMeters && rightThreshold < oneKmInMeters) {
      return '${AppStrings.prepositionFrom} ${_rightMeasure(leftThreshold)} ${AppStrings.prepositionTo} ${_rightMeasure(
        rightThreshold,
        addPostfix: true,
      )}';
    }
    if (leftThreshold > oneKmInMeters && rightThreshold > oneKmInMeters) {
      return '${AppStrings.prepositionFrom} ${_rightMeasure(leftThreshold)} ${AppStrings.prepositionTo} ${_rightMeasure(
        rightThreshold,
        addPostfix: true,
      )}';
    }

    return '${AppStrings.prepositionFrom} ${_rightMeasure(
      leftThreshold,
      addPostfix: true,
    )} ${AppStrings.prepositionTo} ${_rightMeasure(
      rightThreshold,
      addPostfix: true,
    )}';
  }
}

abstract class IFiltersScreenWidgetModel extends IWidgetModel {
  /// Состояние списка отфильтрованных мест
  ListenableState<EntityState<List<Place>>> get filteredPlacesState;

  /// Состояние фильтра по типу места
  ListenableState<List<PlaceTypeFilterEntity>> get placeTypesFilterState;

  /// Состояние фильтра по дистанции
  ListenableState<DistanceFilter> get distanceFilterState;

  /// Признак размера экрана
  bool get isSmallScreen;

  /// Описание фильтра по дистанции
  String get distanceTitleRepresentation;

  /// Обработчик нажатия на кнопку очистки всех фильтров
  void onClearFilters();

  /// Обработчик нажатия на фильтр типа места [placeTypeFilterEntity]
  void onPlaceTypeFilterTapped(
    PlaceTypeFilterEntity placeTypeFilterEntity,
    int index,
  );

  /// Обработчик движения ползунка смены расстояния
  void onDistanceChanged(RangeValues values);

  /// Обработчик окончания движения ползунка смены расстояния
  void onDistanceChangeEnded(RangeValues values);

  /// Обработчик нажатия на кнопку применения фильтров
  void onFilteredListShown();
}
