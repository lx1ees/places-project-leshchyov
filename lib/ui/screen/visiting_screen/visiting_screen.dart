import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_widget_model.dart';
import 'package:places/ui/widget/common/custom_tab_bar.dart';
import 'package:places/ui/widget/common/loading_indicator.dart';
import 'package:places/ui/widget/common/no_items_placeholder.dart';
import 'package:places/ui/widget/place_card/place_to_visit_card.dart';
import 'package:places/ui/widget/place_card/place_visited_card.dart';
import 'package:places/ui/widget/place_list/place_list.dart';

/// Экран со списками посещения
class VisitingScreen extends ElementaryWidget<IVisitingScreenWidgetModel> {
  static const String routeName = '/visiting';

  const VisitingScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IVisitingScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            AppStrings.favoriteScreenAppBarTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: wm.colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: wm.theme.scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight:
            kToolbarHeight + AppConstants.defaultTabVerticalPadding * 2,
        bottom: CustomTabBar(
          controller: wm.tabController,
          labelTabs: const [
            AppStrings.favoriteWantToVisitTabTitle,
            AppStrings.favoriteVisitedTabTitle,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: AppConstants.defaultPaddingX1_5),
        child: TabBarView(
          controller: wm.tabController,
          children: [
            EntityStateNotifierBuilder<List<Place>>(
              listenableEntityState: wm.listFavoritePlacesState,
              builder: (_, favoritePlaces) {
                if (favoritePlaces == null) {
                  return const SizedBox.shrink();
                }

                return PlaceList(
                  onDragComplete: wm.onChangeOrderInFavorites,
                  placeCards: favoritePlaces
                      .map((place) => PlaceToVisitCard(
                            key: ObjectKey(place),
                            place: place,
                            dateOfVisit: place.planDate,
                            onPlanPressed: wm.onPlanPlacePressed,
                            onDeletePressed: wm.onDeleteFavoritePlacePressed,
                            onCardTapped: wm.onPlaceCardPressed,
                          ))
                      .toList(),
                  emptyListPlaceholder: const NoItemsPlaceholder(
                    iconPath: AppAssets.noToVisitPlacesIcon,
                    title: AppStrings.placeholderNoItemsTitleText,
                    subtitle: AppStrings.placeholderNoToVisitPlacesText,
                  ),
                );
              },
              loadingBuilder: (_, __) {
                return const Center(
                  child: LoadingIndicator(),
                );
              },
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
            EntityStateNotifierBuilder<List<Place>>(
              listenableEntityState: wm.listVisitedPlacesState,
              builder: (_, visitedPlaces) {
                if (visitedPlaces == null) {
                  return const SizedBox.shrink();
                }

                return PlaceList(
                  onDragComplete: wm.onChangeOrderInVisited,
                  placeCards: visitedPlaces
                      .map(
                        (place) => PlaceVisitedCard(
                          key: ObjectKey(place),
                          place: place,
                          dateOfVisit: place.planDate,
                          onSharePressed: (_) {},
                          onDeletePressed: wm.onDeleteVisitedPlacePressed,
                          onCardTapped: wm.onPlaceCardPressed,
                        ),
                      )
                      .toList(),
                  emptyListPlaceholder: const NoItemsPlaceholder(
                    iconPath: AppAssets.noVisitedPlacesIcon,
                    title: AppStrings.placeholderNoItemsTitleText,
                    subtitle: AppStrings.placeholderNoVisitedPlacesText,
                  ),
                );
              },
              loadingBuilder: (_, __) {
                return const Center(
                  child: LoadingIndicator(),
                );
              },
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
