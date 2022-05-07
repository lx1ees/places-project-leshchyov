import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/custom_tab_bar.dart';
import 'package:places/ui/screen/no_items_placeholder.dart';
import 'package:places/ui/screen/place_card/place_to_visit_card.dart';
import 'package:places/ui/screen/place_card/place_visited_card.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/place_list.dart';
import 'package:places/ui/screen/res/themes.dart';

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
            PlaceList(
              onDragComplete: (fromIndex, toIndex) {
                _movePlace(
                  index: toIndex,
                  placeToMove: toVisitPlaces[fromIndex],
                  source: toVisitPlaces,
                );
              },
              placeCards: toVisitPlaces
                  .map((place) => PlaceToVisitCard(
                        key: ObjectKey(place),
                        place: place,
                        dateOfVisit: DateTime.now(),
                        onPlanPressed: _pickPlanDate,
                        onDeletePressed: () => _deletePlace(
                          placeToRemove: place,
                          source: toVisitPlaces,
                        ),
                        onCardTapped: () =>
                            _openPlaceDetailsBottomSheet(context, place),
                      ))
                  .toList(),
              emptyListPlaceholder: const NoItemsPlaceholder(
                iconPath: AppAssets.noToVisitPlacesIcon,
                title: AppStrings.placeholderNoItemsTitleText,
                subtitle: AppStrings.placeholderNoToVisitPlacesText,
              ),
            ),
            PlaceList(
              onDragComplete: (fromIndex, toIndex) {
                _movePlace(
                  index: toIndex,
                  placeToMove: visitedPlaces[fromIndex],
                  source: visitedPlaces,
                );
              },
              placeCards: visitedPlaces
                  .map((place) => PlaceVisitedCard(
                        key: ObjectKey(place),
                        place: place,
                        dateOfVisit: DateTime.now(),
                        onSharePressed: () {},
                        onDeletePressed: () => _deletePlace(
                          placeToRemove: place,
                          source: visitedPlaces,
                        ),
                        onCardTapped: () =>
                            _openPlaceDetailsBottomSheet(context, place),
                      ))
                  .toList(),
              emptyListPlaceholder: const NoItemsPlaceholder(
                iconPath: AppAssets.noVisitedPlacesIcon,
                title: AppStrings.placeholderNoItemsTitleText,
                subtitle: AppStrings.placeholderNoVisitedPlacesText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deletePlace({
    required Place placeToRemove,
    required List<Place> source,
  }) {
    setState(() {
      source.removeWhere((place) => place == placeToRemove);
    });
  }

  /// Метод перемещения картчочки в списке
  /// [index] - позиция, куда переместить
  /// [placeToMove] - объект перемещения
  /// [source] - список, где производится перемещение
  void _movePlace({
    required int index,
    required Place placeToMove,
    required List<Place> source,
  }) {
    setState(() {
      _deletePlace(placeToRemove: placeToMove, source: source);
      source.insert(index, placeToMove);
    });
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
      isDismissible: true,
      useRootNavigator: true,
      builder: (_) {
        return PlaceDetailsBottomSheet(place: place);
      },
    );
  }

  Future<void> _pickPlanDate() async {
    final nowDate = DateTime.now();
    final nowYear = nowDate.year;

    final date = Platform.isIOS
        ? await _cupertinoDatePicker(nowDate, nowYear)
        : await _materialDatePicker(nowDate, nowYear);
  }

  Future<DateTime?> _materialDatePicker(
    DateTime nowDate,
    int nowYear,
  ) {
    return showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: nowDate,
      lastDate: DateTime(nowYear + 3),
      locale: AppConstants.locale,
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.apply,
      helpText: AppStrings.datePickerHelpText,
      fieldLabelText: AppStrings.datePickerFieldLabelText,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Theme.of(context).white,
              onSurface: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<DateTime?> _cupertinoDatePicker(
    DateTime nowDate,
    int nowYear,
  ) {
    return showCupertinoModalPopup<DateTime?>(
      builder: (context) {
        DateTime? dateTime;

        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context, dateTime);

            return Future.value(true);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 300,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  backgroundColor: Theme.of(context).white,
                  minimumDate: nowDate,
                  initialDateTime: nowDate,
                  maximumDate: DateTime(nowYear + 3),
                  onDateTimeChanged: (dt) => dateTime = dt,
                ),
              ),
            ],
          ),
        );
      },
      context: context,
    );
  }
}
