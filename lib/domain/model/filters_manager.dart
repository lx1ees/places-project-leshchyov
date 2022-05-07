import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/location_utils.dart';

/// Класс, который содержит информацию о фильтрах по категории [placeTypeFilters],
/// минимальной [distanceLeftThreshold] и максимальной [distanceRightThreshold] дистанции.
class FiltersManager {
  double distanceLeftThreshold;
  double distanceRightThreshold;

  List<PlaceTypeFilterEntity> get placeTypeFilters => _placeTypeFilters;

  bool get isPlaceTypeFiltersApplied =>
      _placeTypeFilters.where((placeType) => placeType.isSelected).isNotEmpty;

  List<PlaceTypeFilterEntity> _placeTypeFilters;

  FiltersManager()
      : _placeTypeFilters = [...placeTypeFiltersMock],
        distanceLeftThreshold = AppConstants.distanceFilterMinValue,
        distanceRightThreshold = AppConstants.distanceFilterMaxValue;

  void updateWith(final FiltersManager filtersManager) {
    distanceRightThreshold = filtersManager.distanceRightThreshold;
    distanceLeftThreshold = filtersManager.distanceLeftThreshold;
    _placeTypeFilters = [...filtersManager.placeTypeFilters];
  }

  /// Очистка фильтров
  void clearFilters() {
    _placeTypeFilters = [...placeTypeFiltersMock];
    distanceLeftThreshold = AppConstants.distanceFilterMinValue;
    distanceRightThreshold = AppConstants.distanceFilterMaxValue;
  }

  /// Обновление фильтра по категории [placeTypeFilterEntity] в списке фильтров по категории
  void updatePlaceTypeFilter({
    required int index,
    required PlaceTypeFilterEntity placeTypeFilterEntity,
  }) {
    if (index != -1) {
      _placeTypeFilters[index] = placeTypeFilterEntity.copyWith(
        isSelected: !placeTypeFilterEntity.isSelected,
      );
    }
  }

  /// Определение, осуществляется ли фильтрация по категории [placeType]
  bool isPlaceTypeSelected(PlaceType placeType) => placeTypeFilters
      .where((currentPlaceType) => currentPlaceType.isSelected)
      .map((placeTypeFilter) => placeTypeFilter.placeType)
      .contains(placeType);

  /// Пока что делегировал фильтрацию списка мест этому классу, в будущем перенесу
  /// в интерактор, когда выстроится архитектура и стейтменеджмент

  /// Применение фильтров к списку достопримечательностей
  List<Place> applyFilters({
    required List<Place> places,
  }) {
    var result = <Place>[...places];

    /// Фильтрация по категориям
    result = _applyPlaceTypeFilters(
      places: result,
    );

    /// Фильтрация по дистанции
    result = _applyDistanceFilters(
      places: result,
      currentLocationPoint: const LocationPoint(
        // mock
        lat: 46.35039319381485,
        lon: 48.04015295725935,
      ),
    );

    return result;
  }

  /// Фильтрация по категориям
  List<Place> _applyPlaceTypeFilters({
    required List<Place> places,
  }) {
    if (!isPlaceTypeFiltersApplied) return places;

    return places
        .where((place) => isPlaceTypeSelected(place.placeType))
        .toList();
  }

  /// Фильтрация по дистанции
  List<Place> _applyDistanceFilters({
    required List<Place> places,
    required LocationPoint currentLocationPoint,
  }) {
    return places
        .where(
          (place) => LocationUtils.arePointsNear(
            checkPoint: place.point,
            centerPoint: currentLocationPoint,
            startRadiusRange: distanceLeftThreshold,
            endRadiusRange: distanceRightThreshold,
          ),
        )
        .toList();
  }
}
