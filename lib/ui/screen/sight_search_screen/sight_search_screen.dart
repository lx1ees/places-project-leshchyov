import 'dart:async';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_error_placeholder.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_history_list.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_loading_indicator.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_no_results_placeholder.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_results_list.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:rxdart/rxdart.dart';

/// Экран поиска мест
/// [filtersManager] - менеджер фильтров
/// [searchHistoryManager] - менеджер истории поиска
class SightSearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final FiltersManager filtersManager;
  final SearchHistoryManager searchHistoryManager;

  const SightSearchScreen({
    required this.filtersManager,
    required this.searchHistoryManager,
    Key? key,
  }) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final _searchStream = PublishSubject<String>();
  final _source = <Sight>[];
  final _foundSights = <Sight>[];
  late final TextEditingController _searchController;

  /// Временные флаги, пока нет стейтменеджмента
  final _isErrorOccurred = false;
  bool _isShowLoader = false;
  String _searchString = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    /// Сначала фильтруем по категориям и дистанции, среди полученного результата
    /// и будет производиться поиск
    _source.addAll(widget.filtersManager.applyFilters(sights: sightsMock));
    _searchStream
        .debounceTime(const Duration(milliseconds: 500))
        .listen(_searchFor);
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
                return SightSearchHistoryList(
                  searchHistoryManager: widget.searchHistoryManager,
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
                return const SightSearchErrorPlaceholder();
              } else if (_isShowLoader) {
                /// Показываем лоадер
                return const SightSearchLoadingIndicator();
              } else if (_foundSights.isNotEmpty) {
                /// Если есть результаты поиска, показываем их
                return SightSearchResultsList(
                  searchString: _searchString,
                  results: _foundSights,
                  onSightPressed: (sight) {
                    _openSightDetailsScreen(
                      context,
                      sight,
                    );
                  },
                );
              }

              /// Если нет результатов поиска, показываем плейсхолдер
              return const SightSearchNoResultsPlaceholder();
            }),
          ),
        ],
      ),
    );
  }

  /// Функция поиска мест по запросу [searchString]
  Future<void> _searchFor(String searchString) async {
    _showLoader();
    _searchString = searchString;

    /// Имитация сетевой задержки при поиске для демонстрации работы лоадера
    await Future.delayed(const Duration(milliseconds: 500), () {});
    _foundSights
      ..clear()
      ..addAll(
        _source.where((sight) {
          return searchString.isNotEmpty &&
              sight.name
                  .toLowerCase()
                  .contains(searchString.toLowerCase().trim());
        }),
      );
    if (_foundSights.isNotEmpty) {
      /// Если текущий поисковой запрос превел к каким-то результатам, сохраняем
      /// стоку поиска в историю
      widget.searchHistoryManager.addInHistory(searchString);
    }
    _hideLoader();
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _openSightDetailsScreen(
    BuildContext context,
    Sight sight,
  ) async {
    await AppRoutes.navigateToSightDetailsScreen(
      context: context,
      sight: sight,
    );
    setState(() {});
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
}
