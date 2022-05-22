import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:places/ui/redux/state/search_state.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';
import 'package:places/ui/widget/common/search_bar.dart';
import 'package:places/ui/widget/place_search/place_search_error_placeholder.dart';
import 'package:places/ui/widget/place_search/place_search_history_list.dart';
import 'package:places/ui/widget/place_search/place_search_loading_indicator.dart';
import 'package:places/ui/widget/place_search/place_search_no_results_placeholder.dart';
import 'package:places/ui/widget/place_search/place_search_results_list.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// Экран поиска мест
class PlaceSearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final FiltersManager filtersManager;

  const PlaceSearchScreen({
    required this.filtersManager,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final _searchStream = PublishSubject<String>();
  late final TextEditingController _searchController;
  String _searchString = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchStream
        .debounceTime(const Duration(milliseconds: 500))
        .listen(_requestForSearchResults);
  }

  @override
  void dispose() {
    _searchStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: AppConstants.defaultIcon2Size,
          ),
        ),
        title: Text(
          AppStrings.searchTitle,
          style: AppTypography.subtitleTextStyle.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
              vertical: AppConstants.defaultPaddingX0_5,
            ),
            child: SearchBar(
              onSearch: _searchStream.add,
              controller: _searchController,
            ),
          ),
          Expanded(
            child: StoreConnector<AppState, SearchState>(
              converter: (store) {
                return store.state.searchState;
              },
              builder: (context, vm) {
                if (_searchString.isEmpty) {
                  return PlaceSearchHistoryList(
                    searchHistoryManager:
                        context.read<SearchInteractor>().searchHistoryManager,
                    onHistoryPressed: (historySearchString) {
                      _searchController
                        ..text = historySearchString
                        ..selection = TextSelection.collapsed(
                          offset: historySearchString.length,
                        );
                    },
                  );
                }

                if (vm is SearchLoadingState) {
                  return const PlaceSearchLoadingIndicator();
                } else if (vm is SearchSuccessState) {
                  final foundPlaces = vm.foundPlaces;

                  if (foundPlaces.isEmpty) {
                    return const PlaceSearchNoResultsPlaceholder();
                  }

                  return PlaceSearchResultsList(
                    searchString: _searchString,
                    results: vm.foundPlaces,
                    onPlacePressed: (place) {
                      _openPlaceDetailsBottomSheet(
                        context,
                        place,
                      );
                    },
                  );
                }

                return const PlaceSearchErrorPlaceholder();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _openPlaceDetailsBottomSheet(
    BuildContext context,
    Place place,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Theme.of(context).colorScheme.primary.withOpacity(0.24),
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) {
        return PlaceDetailsBottomSheet(place: place, isExpanded: true);
      },
    );
  }

  /// Функция поиска мест по запросу [searchString]
  Future<void> _requestForSearchResults(String searchString) async {
    _searchString = searchString;
    StoreProvider.of<AppState>(context).dispatch(GetSearchResultsAction(
      filtersManager: context.read<FiltersManager>(),
      currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
      searchString: searchString,
    ));
  }
}
