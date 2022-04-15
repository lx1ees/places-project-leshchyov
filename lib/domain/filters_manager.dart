import 'package:places/constants/app_constants.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_category.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/location_utils.dart';

/// Класс, который содержит информацию о фильтрах по категории [categoryFilters],
/// минимальной [distanceLeftThreshold] и максимальной [distanceRightThreshold] дистанции.
class FiltersManager {
  double distanceLeftThreshold;
  double distanceRightThreshold;

  List<CategoryFilterEntity> get categoryFilters => _categoryFilters;

  bool get isCategoryFiltersApplied =>
      _categoryFilters.where((category) => category.isSelected).isNotEmpty;

  List<CategoryFilterEntity> _categoryFilters;

  FiltersManager()
      : _categoryFilters = [...categoryFiltersMock],
        distanceLeftThreshold = AppConstants.distanceFilterMinValue,
        distanceRightThreshold = AppConstants.distanceFilterMaxValue;

  void updateWith(final FiltersManager filtersManager) {
    distanceRightThreshold = filtersManager.distanceRightThreshold;
    distanceLeftThreshold = filtersManager.distanceLeftThreshold;
    _categoryFilters = [...filtersManager.categoryFilters];
  }

  /// Очистка фильтров
  void clearFilters() {
    _categoryFilters = [...categoryFiltersMock];
    distanceLeftThreshold = AppConstants.distanceFilterMinValue;
    distanceRightThreshold = AppConstants.distanceFilterMaxValue;
  }

  /// Обновление фильтра по категории [categoryFilterEntity] в списке фильтров по категории
  void updateCategoryFilter({
    required int index,
    required CategoryFilterEntity categoryFilterEntity,
  }) {
    if (index != -1) {
      _categoryFilters[index] = categoryFilterEntity.copyWith(
        isSelected: !categoryFilterEntity.isSelected,
      );
    }
  }

  /// Определение, осуществляется ли фильтрация по категории [category]
  bool isCategorySelected(SightCategory category) => categoryFilters
      .where((category) => category.isSelected)
      .map((categoryFilter) => categoryFilter.sightCategory)
      .contains(category);

  /// Пока что делегировал фильтрацию списка мест этому классу, в будущем перенесу
  /// в интерактор, когда выстроится архитектура и стейтменеджмент

  /// Применение фильтров к списку достопримечательностей
  List<Sight> applyFilters({
    required List<Sight> sights,
  }) {
    var result = <Sight>[...sights];

    /// Фильтрация по категориям
    result = _applyCategoryFilters(
      sights: result,
    );

    /// Фильтрация по дистанции
    result = _applyDistanceFilters(
      sights: result,
      currentLocationPoint: const LocationPoint(
        // mock
        lat: 46.35039319381485,
        lon: 48.04015295725935,
      ),
    );

    return result;
  }

  /// Фильтрация по категориям
  List<Sight> _applyCategoryFilters({
    required List<Sight> sights,
  }) {
    if (!isCategoryFiltersApplied) return sights;

    return sights.where((sight) => isCategorySelected(sight.category)).toList();
  }

  /// Фильтрация по дистанции
  List<Sight> _applyDistanceFilters({
    required List<Sight> sights,
    required LocationPoint currentLocationPoint,
  }) {
    return sights
        .where(
          (sight) => LocationUtils.arePointsNear(
            checkPoint: sight.point,
            centerPoint: currentLocationPoint,
            startRadiusRange: distanceLeftThreshold,
            endRadiusRange: distanceRightThreshold,
          ),
        )
        .toList();
  }
}
