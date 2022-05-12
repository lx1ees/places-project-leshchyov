import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';

/// Класс, который содержит информацию о фильтрах по категории [placeTypeFilters],
/// минимальной [distanceLeftThreshold] и максимальной [distanceRightThreshold] дистанции.
class FiltersManager {
  double distanceLeftThreshold;
  double distanceRightThreshold;

  List<PlaceTypeFilterEntity> get placeTypeFilters => _placeTypeFilters;

  List<String>? get placeTypeFilterIds {
    final ids = placeTypeFilters
        .where((e) => e.isSelected)
        .map((e) => e.placeType.id)
        .toList();

    return ids.isNotEmpty ? ids : null;
  }

  bool get isPlaceTypeFiltersApplied =>
      _placeTypeFilters.where((placeType) => placeType.isSelected).isNotEmpty;

  bool get isFiltersApplied =>
      isPlaceTypeFiltersApplied ||
      distanceRightThreshold != AppConstants.distanceFilterMaxValue;

  List<PlaceTypeFilterEntity> _placeTypeFilters;

  FiltersManager()
      : _placeTypeFilters = [
          ...PlaceTypeFilterEntity.availablePlaceTypeFilters,
        ],
        distanceLeftThreshold = AppConstants.distanceFilterMinValue,
        distanceRightThreshold = AppConstants.distanceFilterMaxValue;

  void updateWith(final FiltersManager filtersManager) {
    distanceRightThreshold = filtersManager.distanceRightThreshold;
    distanceLeftThreshold = filtersManager.distanceLeftThreshold;
    _placeTypeFilters = [...filtersManager.placeTypeFilters];
  }

  /// Очистка фильтров
  void clearFilters() {
    _placeTypeFilters = [...PlaceTypeFilterEntity.availablePlaceTypeFilters];
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
}
