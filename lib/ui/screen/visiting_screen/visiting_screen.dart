import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/custom_tab_bar.dart';
import 'package:places/ui/screen/no_items_placeholder.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/screen/sight_card/sight_to_visit_card.dart';
import 'package:places/ui/screen/sight_card/sight_visited_card.dart';
import 'package:places/ui/screen/sight_list.dart';

/// Экран со списками посещения
class VisitingScreen extends StatefulWidget {
  static const String routeName = '/visiting';

  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            AppStrings.favoriteScreenAppBarTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight:
            kToolbarHeight + AppConstants.defaultTabVerticalPadding * 2,
        bottom: CustomTabBar(
          controller: _tabController,
          labelTabs: const [
            AppStrings.favoriteWantToVisitTabTitle,
            AppStrings.favoriteVisitedTabTitle,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: AppConstants.defaultPaddingX1_5),
        child: TabBarView(
          controller: _tabController,
          children: [
            SightList(
              onDragComplete: (fromIndex, toIndex) {
                _moveSight(
                  index: toIndex,
                  sightToMove: toVisitSights[fromIndex],
                  source: toVisitSights,
                );
              },
              sightCards: toVisitSights
                  .map((sight) => SightToVisitCard(
                        key: ObjectKey(sight),
                        sight: sight,
                        dateOfVisit: DateTime.now(),
                        onPlanPressed: () {},
                        onDeletePressed: () => _deleteSight(
                          sightToRemove: sight,
                          source: toVisitSights,
                        ),
                        onCardTapped: () =>
                            _openSightDetailsScreen(context, sight),
                      ))
                  .toList(),
              emptyListPlaceholder: const NoItemsPlaceholder(
                iconPath: AppAssets.noToVisitSightsIcon,
                title: AppStrings.placeholderNoItemsTitleText,
                subtitle: AppStrings.placeholderNoToVisitSightsText,
              ),
            ),
            SightList(
              onDragComplete: (fromIndex, toIndex) {
                _moveSight(
                  index: toIndex,
                  sightToMove: visitedSights[fromIndex],
                  source: visitedSights,
                );
              },
              sightCards: visitedSights
                  .map((sight) => SightVisitedCard(
                        key: ObjectKey(sight),
                        sight: sight,
                        dateOfVisit: DateTime.now(),
                        onSharePressed: () {},
                        onDeletePressed: () => _deleteSight(
                          sightToRemove: sight,
                          source: visitedSights,
                        ),
                        onCardTapped: () =>
                            _openSightDetailsScreen(context, sight),
                      ))
                  .toList(),
              emptyListPlaceholder: const NoItemsPlaceholder(
                iconPath: AppAssets.noVisitedSightsIcon,
                title: AppStrings.placeholderNoItemsTitleText,
                subtitle: AppStrings.placeholderNoVisitedSightsText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteSight({
    required Sight sightToRemove,
    required List<Sight> source,
  }) {
    setState(() {
      source.removeWhere((sight) => sight == sightToRemove);
    });
  }

  /// Метод перемещения картчочки в списке
  /// [index] - позиция, куда переместить
  /// [sightToMove] - объект перемещения
  /// [source] - список, где производится перемещение
  void _moveSight({
    required int index,
    required Sight sightToMove,
    required List<Sight> source,
  }) {
    setState(() {
      _deleteSight(sightToRemove: sightToMove, source: source);
      source.insert(index, sightToMove);
    });
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
}
