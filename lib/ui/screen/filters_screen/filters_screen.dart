import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen/category_filter_section.dart';
import 'package:places/ui/screen/filters_screen/distance_filter_section.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_app_bar.dart';
import 'package:places/ui/screen/filters_screen/show_filtered_list_button.dart';

/// Экран с фильтрами по категории и дистанции от текущего местоположения
/// [filtersManager] - менеджер фильтров, хранит информацию о примененных фильтрах
class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final FiltersManager filtersManager;

  const FiltersScreen({
    required this.filtersManager,
    Key? key,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  /// Локальный менеджер фильтров [localFiltersManager] для хранения только что
  /// сделанных изменений на экране с фильтрами. При нажатии на кнопку Показать,
  /// его значения перезаписывают значения пришедшего извне менеджера фильтров.
  /// Иначе изменения не применяются (например, когда открыли экран фильтров,
  /// поменяли какие-то фильтры, не нажали Показать, а вернулись назад, т.е.
  /// не применили сделанные изменения).
  final FiltersManager localFiltersManager = FiltersManager();
  late List<Sight> _filteredSights;

  @override
  void initState() {
    super.initState();
    localFiltersManager.updateWith(widget.filtersManager);
    _filteredSights = widget.filtersManager.applyFilters(
      sights: sightsMock,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterScreenAppBar(
        onClearFilters: () {
          localFiltersManager.clearFilters();
          _filteredSights = localFiltersManager.applyFilters(
            sights: sightsMock,
          );
          setState(() {});
        },
      ),
      body: SafeArea(
        child: Stack(
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
                        localFiltersManager.updateCategoryFilter(
                          index: index,
                          categoryFilterEntity: categoryFilterEntity,
                        );
                        _filteredSights = localFiltersManager.applyFilters(
                          sights: sightsMock,
                        );
                        setState(() {});
                      },
                      filtersManager: localFiltersManager,
                    ),
                    const SizedBox(height: AppConstants.defaultPaddingX2),
                    DistanceFilterSection(
                      filtersManager: localFiltersManager,
                      onDistanceChanged: (values) {
                        localFiltersManager
                          ..distanceLeftThreshold = values.start
                          ..distanceRightThreshold = values.end;
                        setState(() {});
                      },
                      onDistanceChangeEnded: (values) {
                        _filteredSights = localFiltersManager.applyFilters(
                          sights: sightsMock,
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
                onShow: () {
                  widget.filtersManager.updateWith(localFiltersManager);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
