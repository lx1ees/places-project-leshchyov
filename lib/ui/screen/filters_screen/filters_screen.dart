import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/filters/distance_filter_section.dart';
import 'package:places/ui/widget/filters/filters_screen_app_bar.dart';
import 'package:places/ui/widget/filters/place_type_filter_section.dart';
import 'package:places/ui/widget/filters/show_filtered_list_button.dart';
import 'package:provider/provider.dart';

/// Экран с фильтрами по категории и дистанции от текущего местоположения
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
  final List<Place> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    localFiltersManager.updateWith(context.read<FiltersManager>());
    _requestForPlaces(filtersManager: localFiltersManager);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterScreenAppBar(
        onClearFilters: () async {
          localFiltersManager.clearFilters();
          await _requestForPlaces(filtersManager: localFiltersManager);
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
                    PlaceTypeFilterSection(
                      onPlaceTypeFilterTapped:
                          (placeTypeFilterEntity, index) async {
                        localFiltersManager.updatePlaceTypeFilter(
                          index: index,
                          placeTypeFilterEntity: placeTypeFilterEntity,
                        );
                        await _requestForPlaces(
                          filtersManager: localFiltersManager,
                        );
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
                      onDistanceChangeEnded: (values) async {
                        await _requestForPlaces(
                          filtersManager: localFiltersManager,
                        );
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
                affectedPlacesCount: _filteredPlaces.length,
                onShow: () {
                  context
                      .read<FiltersManager>()
                      .updateWith(localFiltersManager);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestForPlaces({
    required FiltersManager filtersManager,
  }) async {
    final places = await context.read<PlaceInteractor>().getPlaces(
          filtersManager: filtersManager,
          currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
        );
    setState(() {
      _filteredPlaces
        ..clear()
        ..addAll(places);
    });
  }
}
