import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/place_search_screen/place_search_error_placeholder.dart';
import 'package:places/ui/screen/place_search_screen/place_search_history_list.dart';
import 'package:places/ui/screen/place_search_screen/place_search_loading_indicator.dart';
import 'package:places/ui/screen/place_search_screen/place_search_no_results_placeholder.dart';
import 'package:places/ui/screen/place_search_screen/place_search_results_list.dart';
import 'package:places/ui/widget/custom_icon_button.dart';
import 'package:places/ui/widget/search_bar.dart';
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
  final _foundPlaces = <Place>[];
  late final TextEditingController _searchController;

  /// Временные флаги, пока нет стейтменеджмента
  final _isErrorOccurred = false;
  bool _isShowLoader = false;
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
            child: Builder(builder: (context) {
              if (_searchString.isEmpty) {
                /// Показываем историю
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
              } else if (_isErrorOccurred) {
                /// Показываем сообщение об ошибке
                return const PlaceSearchErrorPlaceholder();
              } else if (_isShowLoader) {
                /// Показываем лоадер
                return const PlaceSearchLoadingIndicator();
              } else if (_foundPlaces.isNotEmpty) {
                /// Если есть результаты поиска, показываем их
                return PlaceSearchResultsList(
                  searchString: _searchString,
                  results: _foundPlaces,
                  onPlacePressed: (place) {
                    _openPlaceDetailsBottomSheet(
                      context,
                      place,
                    );
                  },
                );
              }

              /// Если нет результатов поиска, показываем плейсхолдер
              return const PlaceSearchNoResultsPlaceholder();
            }),
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

  /// Метод изменения условий для показа лоадера
  void _showLoader() {
    setState(() {
      _isShowLoader = true;
    });
  }

  /// Метод изменения условий для сокрытия лоадера
  void _hideLoader() {
    setState(() {
      _isShowLoader = false;
    });
  }

  /// Функция поиска мест по запросу [searchString]
  Future<void> _requestForSearchResults(String searchString) async {
    _showLoader();
    _searchString = searchString;

    final places = await context.read<SearchInteractor>().getSearchResults(
          filtersManager: context.read<FiltersManager>(),
          currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
          searchString: searchString,
        );
    setState(() {
      _foundPlaces
        ..clear()
        ..addAll(places);
    });

    _hideLoader();
  }
}
