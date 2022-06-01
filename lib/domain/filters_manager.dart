import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';

class DistanceFilter {
  final double distanceLeftThreshold;
  final double distanceRightThreshold;

  const DistanceFilter({
    double? distanceLeftThreshold,
    double? distanceRightThreshold,
  })  : distanceLeftThreshold =
            distanceLeftThreshold ?? AppConstants.distanceFilterMinValue,
        distanceRightThreshold =
            distanceRightThreshold ?? AppConstants.distanceFilterMaxValue;
}

/// Класс, который содержит информацию о фильтрах по категории [placeTypeFilters],
/// минимальной и максимальной дистанции [distanceFilter].
class FiltersManager {
  DistanceFilter distanceFilter;

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
      distanceFilter.distanceRightThreshold !=
          AppConstants.distanceFilterMaxValue;

  List<PlaceTypeFilterEntity> _placeTypeFilters;

  FiltersManager()
      : _placeTypeFilters = [
          ...PlaceTypeFilterEntity.availablePlaceTypeFilters,
        ],
        distanceFilter = const DistanceFilter();

  factory FiltersManager.from({
    required double? distance,
    required List<PlaceTypeFilterEntity>? placeTypes,
  }) {
    return FiltersManager()
      ..distanceFilter = DistanceFilter(distanceRightThreshold: distance)
      .._placeTypeFilters = [
        ...placeTypes ?? PlaceTypeFilterEntity.availablePlaceTypeFilters,
      ];
  }

  ///  Обновление значений мепнеджера фильтров из переданного менеджера фильтров
  void updateWith(final FiltersManager filtersManager) {
    distanceFilter = filtersManager.distanceFilter;
    _placeTypeFilters = [...filtersManager.placeTypeFilters];
  }

  /// Очистка фильтров
  void clearFilters() {
    _placeTypeFilters = [
      ...PlaceTypeFilterEntity.availablePlaceTypeFilters,
    ];
    distanceFilter = const DistanceFilter();
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
