import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen_widget_model.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';
import 'package:places/ui/widget/place_search/place_search_error_placeholder.dart';
import 'package:places/ui/widget/place_search/place_search_history_list.dart';
import 'package:places/ui/widget/place_search/place_search_loading_indicator.dart';
import 'package:places/ui/widget/place_search/place_search_no_results_placeholder.dart';
import 'package:places/ui/widget/place_search/place_search_results_list.dart';
import 'package:places/ui/widget/place_search/search_bar.dart';

/// Экран поиска мест
class PlaceSearchScreen
    extends ElementaryWidget<IPlaceSearchScreenWidgetModel> {
  static const String routeName = '/search';

  const PlaceSearchScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IPlaceSearchScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onPressed: wm.onBackButtonPressed,
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: AppConstants.defaultIcon2Size,
          ),
        ),
        title: Text(
          AppStrings.searchTitle,
          style: AppTypography.subtitleTextStyle.copyWith(
            color: wm.colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: wm.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
              vertical: AppConstants.defaultPaddingX0_5,
            ),
            child: StateNotifierBuilder<bool>(
              listenableState: wm.searchBarClearButtonState,
              builder: (_, isClearButtonActive) {
                return SearchBar(
                  theme: wm.theme,
                  controller: wm.searchController,
                  focusNode: wm.searchBarFocusNode,
                  isClearButtonActive: isClearButtonActive,
                );
              },
            ),
          ),
          Expanded(
            child: EntityStateNotifierBuilder<List<Place>>(
              listenableEntityState: wm.listFoundPlacesState,
              builder: (_, foundPlaces) {
                if (wm.searchString.isEmpty) {
                  return StateNotifierBuilder<List<String>>(
                    listenableState: wm.searchHistoryState,
                    builder: (_, history) {
                      return PlaceSearchHistoryList(
                        onHistoryItemPressed: wm.onHistoryItemPressed,
                        scrollController: wm.scrollController,
                        colorScheme: wm.colorScheme,
                        onHistoryItemRemoved: wm.onHistoryItemRemoved,
                        onHistoryCleared: wm.onHistoryCleared,
                        history: history,
                      );
                    },
                  );
                }

                if (foundPlaces == null) {
                  return const PlaceSearchErrorPlaceholder();
                }

                if (foundPlaces.isEmpty) {
                  return const PlaceSearchNoResultsPlaceholder();
                }

                return PlaceSearchResultsList(
                  searchString: wm.searchString,
                  results: foundPlaces,
                  onPlacePressed: wm.onPlaceCardPressed,
                );
              },
              loadingBuilder: (_, __) => const PlaceSearchLoadingIndicator(),
              errorBuilder: (_, __, ___) => const PlaceSearchErrorPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }
}
