import 'package:places/constants/app_constants.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/mocks.dart';

/// Класс, который содержит информацию о фильтрах по категории [_categoryFilters],
/// минимальной [distanceLeftThreshold] и максимальной [distanceRightThreshold] дистанции.
class FiltersManager {
  double distanceLeftThreshold;
  double distanceRightThreshold;

  List<CategoryFilterEntity> get categoryFilters => _categoryFilters;

  bool get isCategoryFiltersApplied =>
      categoryFilters.where((category) => category.isSelected).isNotEmpty;
  List<CategoryFilterEntity> _categoryFilters;

  FiltersManager()
      : _categoryFilters = [...categoryFiltersMock],
        distanceLeftThreshold = AppConstants.distanceFilterMinValue,
        distanceRightThreshold = AppConstants.distanceFilterMaxValue;

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
}
