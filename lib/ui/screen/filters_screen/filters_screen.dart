import 'dart:math';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen/category_filter_section.dart';
import 'package:places/ui/screen/filters_screen/distance_filter_section.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_app_bar.dart';
import 'package:places/ui/screen/filters_screen/show_filtered_list_button.dart';

/// Экран с фильтрами по категории и дистанции от текущего местоположения
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final FiltersManager _filtersManager = FiltersManager();
  late List<Sight> _filteredSights;

  @override
  void initState() {
    super.initState();
    _filteredSights = _applyFilters(
      sights: sightsMock,
      filtersManager: _filtersManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterScreenAppBar(
        onClearFilters: () {
          _filtersManager.clearFilters();
          _filteredSights = _applyFilters(
            sights: sightsMock,
            filtersManager: _filtersManager,
          );
          setState(() {});
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppConstants.defaultPaddingX1_5),
                  CategoryFilterSection(
                    onCategoryFilterTapped: (categoryFilterEntity, index) {
                      _filtersManager.updateCategoryFilter(
                        index: index,
                        categoryFilterEntity: categoryFilterEntity,
                      );
                      _filteredSights = _applyFilters(
                        sights: sightsMock,
                        filtersManager: _filtersManager,
                      );
                      setState(() {});
                    },
                    filtersManager: _filtersManager,
                  ),
                  const SizedBox(height: AppConstants.defaultPaddingX2),
                  DistanceFilterSection(
                    filtersManager: _filtersManager,
                    onDistanceChanged: (values) {
                      _filtersManager
                        ..distanceLeftThreshold = values.start
                        ..distanceRightThreshold = values.end;
                      setState(() {});
                    },
                    onDistanceChangeEnded: (values) {
                      _filteredSights = _applyFilters(
                        sights: sightsMock,
                        filtersManager: _filtersManager,
                      );
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: AppConstants.defaultPaddingX4),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ShowFilteredListButton(
              affectedSightsCount: _filteredSights.length,
              onShow: () {},
            ),
          ),
        ],
      ),
    );
  }

  /// Применение фильтров к списку достопримечательностей
  List<Sight> _applyFilters({
    required List<Sight> sights,
    required FiltersManager filtersManager,
  }) {
    var result = <Sight>[...sights];

    /// Фильтрация по категориям
    result = _applyCategoryFilters(
      sights: result,
      filtersManager: filtersManager,
    );

    /// Фильтрация по дистанции
    result = _applyDistanceFilters(
      sights: result,
      filtersManager: filtersManager,
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
    required FiltersManager filtersManager,
  }) {
    if (!filtersManager.isCategoryFiltersApplied) return sights;

    return sights
        .where((sight) => filtersManager.isCategorySelected(sight.category))
        .toList();
  }

  /// Фильтрация по дистанции
  List<Sight> _applyDistanceFilters({
    required List<Sight> sights,
    required FiltersManager filtersManager,
    required LocationPoint currentLocationPoint,
  }) {
    return sights
        .where(
          (sight) => _arePointsNear(
            checkPoint: sight.point,
            centerPoint: currentLocationPoint,
            startRadiusRange: filtersManager.distanceLeftThreshold,
            endRadiusRange: filtersManager.distanceRightThreshold,
          ),
        )
        .toList();
  }

  /// Определение, находится ли координата [checkPoint] от текущего местоположения
  /// [centerPoint] в пределах дистанции от [startRadiusRange] до [endRadiusRange]
  /// в метрах.
  bool _arePointsNear({
    required LocationPoint checkPoint,
    required LocationPoint centerPoint,
    required double startRadiusRange,
    required double endRadiusRange,
  }) {
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lon - checkPoint.lon).abs() * kx;
    final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
    final distance = sqrt(dx * dx + dy * dy);
    final start = (startRadiusRange / 1000).round();
    final end = (endRadiusRange / 1000).round();

    return distance >= start && distance <= end;
  }
}
