import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/filters_manager.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_search_screen_route_arguments.dart';
import 'package:places/domain/model/search_history_manager.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/place_card/place_view_card.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/place_list.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen_sliver_app_bar.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widget/gradient_extended_fab.dart';
import 'package:places/ui/widget/search_bar.dart';

/// Виджет, описывающий экран списка интересных мест
class PlaceListScreen extends StatefulWidget {
  static const String routeName = '/placeList';

  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  final FiltersManager filtersManager = FiltersManager();
  final SearchHistoryManager searchHistoryManager = SearchHistoryManager();
  final ScrollController _scrollController = ScrollController();
  late List<Place> filteredPlaces;

  @override
  void initState() {
    super.initState();
    filteredPlaces = [...placesMock];
    _applyFilters(filtersManager);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientExtendedFab(
        icon: SvgPicture.asset(AppAssets.plusIcon),
        label: AppStrings.newPlaceTitle.toUpperCase(),
        startColor: colorScheme.surfaceVariant,
        endColor: colorScheme.secondary,
        onPressed: () {
          _openAddNewPlaceScreen(context);
        },
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        controller: _scrollController,
        headerSliverBuilder: (_, __) =>
            [PlaceListScreenSliverAppBar(scrollController: _scrollController)],
        body: Column(
          children: [
            const SizedBox(height: AppConstants.defaultPaddingX0_5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: SearchBar(
                isBlocked: true,
                onOpenFiltersPressed: () {
                  _openFiltersScreen(context);
                },
                onTap: () {
                  _openSearchScreen(context);
                },
              ),
            ),
            const SizedBox(height: AppConstants.defaultPaddingX1_5),
            Expanded(
              child: PlaceList(
                placeCards: filteredPlaces
                    .map((place) => PlaceViewCard(
                          place: place,
                          onFavoritePressed: () {},
                          onCardTapped: () =>
                              _openPlaceDetailsBottomSheet(context, place),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
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
        return PlaceDetailsBottomSheet(place: place);
      },
    );
  }

  /// Метод открытия окна добавления нового места
  Future<void> _openAddNewPlaceScreen(
    BuildContext context,
  ) async {
    await AppRoutes.navigateToAddNewPlaceScreen(context: context);
    _applyFilters(filtersManager);
    setState(() {});
  }

  /// Метода открытия окна с фильтрами
  Future<void> _openFiltersScreen(
    BuildContext context,
  ) async {
    await AppRoutes.navigateToFiltersScreen(
      context: context,
      filtersManager: filtersManager,
    );
    _applyFilters(filtersManager);
    setState(() {});
  }

  /// Метода открытия окна поиска
  Future<void> _openSearchScreen(
    BuildContext context,
  ) async {
    await AppRoutes.navigateToSearchScreen(
      context: context,
      arguments: PlaceSearchScreenRouteArguments(
        filtersManager: filtersManager,
        searchHistoryManager: searchHistoryManager,
      ),
    );
    setState(() {});
  }

  void _applyFilters(FiltersManager filtersManager) {
    filteredPlaces = filtersManager.applyFilters(places: placesMock);
  }
}
