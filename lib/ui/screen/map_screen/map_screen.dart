import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/map_screen/map_screen_widget_model.dart';
import 'package:places/ui/widget/common/gradient_extended_fab.dart';
import 'package:places/ui/widget/map/map_actions.dart';
import 'package:places/ui/widget/map/map_place_card.dart';
import 'package:places/ui/widget/place_search/search_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Виджет, описывающий экран с картой интересных мест
class MapScreen extends ElementaryWidget<IMapScreenWidgetModel> {
  static const String routeName = '/map';

  const MapScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(
          widgetModelFactory,
          key: key,
        );

  @override
  Widget build(IMapScreenWidgetModel wm) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StateNotifierBuilder<Place?>(
        listenableState: wm.selectedPlaceState,
        builder: (_, selectedPlace) {
          if (selectedPlace != null) return const SizedBox.shrink();

          return GradientExtendedFab(
            icon: SvgPicture.asset(AppAssets.plusIcon),
            label: AppStrings.newPlaceTitle.toUpperCase(),
            startColor: wm.colorScheme.surfaceVariant,
            endColor: wm.colorScheme.secondary,
            onPressed: wm.onAddNewPlacePressed,
          );
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            AppStrings.mapScreenAppBarTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: wm.colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: wm.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: AppConstants.defaultPaddingX0_5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                child: SearchBar(
                  isBlocked: true,
                  onOpenFiltersPressed: wm.onFiltersPressed,
                  onTap: wm.onSearchPressed,
                  theme: wm.theme,
                ),
              ),
              const SizedBox(height: AppConstants.defaultPaddingX1_5),
              Expanded(
                child: StateNotifierBuilder<List<PlacemarkMapObject>>(
                  listenableState: wm.listPlacemarksState,
                  builder: (_, placemarks) {
                    return YandexMap(
                      nightModeEnabled: wm.theme.brightness == Brightness.dark,
                      onMapCreated: wm.onMapCreated,
                      onUserLocationAdded: wm.onUserLocationAdded,
                      mapObjects: placemarks ?? [],
                      fastTapEnabled: true,
                      onMapTap: wm.onMapTap,
                      // fastTapEnabled: true,
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: StateNotifierBuilder<Place?>(
              listenableState: wm.selectedPlaceState,
              builder: (_, selectedPlace) {
                return Column(
                  children: [
                    MapActions(
                      onRefreshPressed: wm.onUpdateMap,
                      onGeoPressed: wm.onUpdateGeo,
                    ),
                    AnimatedSlide(
                      offset: selectedPlace != null
                          ? Offset.zero
                          : const Offset(0, 1),
                      duration: const Duration(
                        milliseconds: AppConstants
                            .mapPlaceAppearanceAnimationDurationInMillis,
                      ),
                      child: selectedPlace != null
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.defaultPadding,
                                  ),
                                  child: MapPlaceCard(
                                    place: selectedPlace,
                                    onFavoritePressed: wm.onFavoritePressed,
                                    onCardTapped: wm.onPlaceCardPressed,
                                    onRoutePressed: (_) {},
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
