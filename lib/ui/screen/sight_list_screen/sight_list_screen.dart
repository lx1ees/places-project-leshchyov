import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_search_screen_route_arguments.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/sight_card/sight_view_card.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottom_sheet.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen_sliver_app_bar.dart';
import 'package:places/ui/widgets/gradient_extended_fab.dart';
import 'package:places/ui/widgets/search_bar.dart';

/// Виджет, описывающий экран списка интересных мест
class SightListScreen extends StatefulWidget {
  static const String routeName = '/sightList';

  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final FiltersManager filtersManager = FiltersManager();
  final SearchHistoryManager searchHistoryManager = SearchHistoryManager();
  final ScrollController _scrollController = ScrollController();
  late List<Sight> filteredSights;

  @override
  void initState() {
    super.initState();
    filteredSights = [...sightsMock];
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
            [SightListScreenSliverAppBar(scrollController: _scrollController)],
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
              child: SightList(
                sightCards: filteredSights
                    .map((sight) => SightViewCard(
                          sight: sight,
                          onFavoritePressed: () {},
                          onCardTapped: () => _openSightDetailsBottomSheet(context, sight),
                          // _openSightDetailsScreen(context, sight),
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
  Future<void> _openSightDetailsBottomSheet(
    BuildContext context,
    Sight sight,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Theme.of(context).colorScheme.primary.withOpacity(0.24),
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) {
        return SightDetailsBottomSheet(sight: sight);
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
      arguments: SightSearchScreenRouteArguments(
        filtersManager: filtersManager,
        searchHistoryManager: searchHistoryManager,
      ),
    );
    setState(() {});
  }

  void _applyFilters(FiltersManager filtersManager) {
    filteredSights = filtersManager.applyFilters(sights: sightsMock);
  }
}
