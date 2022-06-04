import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_widget_model.dart';
import 'package:places/ui/widget/filters/distance_filter_section.dart';
import 'package:places/ui/widget/filters/filters_screen_app_bar.dart';
import 'package:places/ui/widget/filters/place_type_filter_section.dart';
import 'package:places/ui/widget/filters/show_filtered_list_button.dart';

/// Экран с фильтрами по категории и дистанции от текущего местоположения
class FiltersScreen extends ElementaryWidget<IFiltersScreenWidgetModel> {
  static const String routeName = '/filters';

  const FiltersScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IFiltersScreenWidgetModel wm) {
    return Scaffold(
      appBar: FilterScreenAppBar(
        onClearFilters: wm.onClearFilters,
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
                    const SizedBox(
                      height: AppConstants.defaultPaddingX1_5,
                    ),
                    StateNotifierBuilder<List<PlaceTypeFilterEntity>>(
                      listenableState: wm.placeTypesFilterState,
                      builder: (_, placeTypeFilters) {
                        if (placeTypeFilters == null) {
                          return const SizedBox.shrink();
                        }

                        return PlaceTypeFilterSection(
                          onPlaceTypeFilterTapped: wm.onPlaceTypeFilterTapped,
                          placeTypeFilters: placeTypeFilters,
                          isSmallScreen: wm.isSmallScreen,
                        );
                      },
                    ),
                    const SizedBox(height: AppConstants.defaultPaddingX2),
                    StateNotifierBuilder<DistanceFilter>(
                      listenableState: wm.distanceFilterState,
                      builder: (_, distanceFilter) {
                        if (distanceFilter == null) {
                          return const SizedBox.shrink();
                        }

                        return DistanceFilterSection(
                          distanceFilter: distanceFilter,
                          distanceTitleRepresentation:
                              wm.distanceTitleRepresentation,
                          onDistanceChanged: wm.onDistanceChanged,
                          onDistanceChangeEnded: wm.onDistanceChangeEnded,
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
              child: EntityStateNotifierBuilder<List<Place>>(
                listenableEntityState: wm.filteredPlacesState,
                loadingBuilder: (_, filteredPlaces) {
                  return ShowFilteredListButton(
                    affectedPlacesCount: filteredPlaces?.length ?? 0,
                    isLoading: true,
                    onShow: wm.onFilteredListShown,
                  );
                },
                errorBuilder: (_, __, ___) {
                  return ShowFilteredListButton(
                    affectedPlacesCount: 0,
                    onShow: () {},
                  );
                },
                builder: (_, filteredPlaces) {
                  return ShowFilteredListButton(
                    affectedPlacesCount: filteredPlaces?.length ?? 0,
                    onShow: wm.onFilteredListShown,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
