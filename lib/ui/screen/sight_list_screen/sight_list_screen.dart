import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/custom_app_bar.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/sight_card/sight_view_card.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/widgets/gradient_extended_fab.dart';
import 'package:places/ui/widgets/search_bar.dart';

/// Виджет, описывающий экран списка интересных мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final FiltersManager filtersManager = FiltersManager();
  final SearchHistoryManager searchHistoryManager = SearchHistoryManager();
  late List<Sight> filteredSights;

  @override
  void initState() {
    super.initState();
    filteredSights = [...sightsMock];
    _applyFilters(filtersManager);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          AppStrings.appBarTitle,
          style: AppTypography.largeTitleTextStyle.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),
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
      body: Column(
        children: [
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
          const SizedBox(height: AppConstants.defaultPadding),
          Expanded(
            child: SightList(
              sightCards: filteredSights
                  .map((sight) => SightViewCard(
                        sight: sight,
                        onFavoritePressed: () {},
                        onCardTapped: () {},
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Метод открытия окна добавления нового места
  Future<void> _openAddNewPlaceScreen(
    BuildContext context,
  ) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddSightScreen(),
      ),
    );

    setState(() {});
  }

  /// Метода открытия окна с фильтрами
  Future<void> _openFiltersScreen(
    BuildContext context,
  ) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => FiltersScreen(
          filtersManager: filtersManager,
        ),
      ),
    );

    _applyFilters(filtersManager);

    setState(() {});
  }

  /// Метода открытия окна поиска
  Future<void> _openSearchScreen(
    BuildContext context,
  ) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => SightSearchScreen(
          filtersManager: filtersManager,
          searchHistoryManager: searchHistoryManager,
        ),
      ),
    );

    setState(() {});
  }

  void _applyFilters(FiltersManager filtersManager) {
    filteredSights = filtersManager.applyFilters(sights: sightsMock);
  }
}
