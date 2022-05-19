import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/bloc/visiting/visiting_bloc.dart';
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
        child: BlocBuilder<VisitingBloc, VisitingState>(
          builder: (context, state) {
            if (state is VisitingLoadedSuccessfully) {
              return TabBarView(
                controller: _tabController,
                children: [
                  PlaceList(
                    onDragComplete: (fromIndex, toIndex) {
                      context.read<VisitingBloc>().add(
                            PlaceChangedOrderInFavorites(
                              fromIndex: fromIndex,
                              toIndex: toIndex,
                            ),
                          );
                    },
                    placeCards: state.favoritePlaces
                        .map((place) => PlaceToVisitCard(
                              key: ObjectKey(place),
                              place: place,
                              dateOfVisit: place.planDate,
                              onPlanPressed: () => _pickPlanDate(place),
                              onDeletePressed: () {
                                context
                                    .read<VisitingBloc>()
                                    .add(PlaceInFavoritesToggled(place: place));
                              },
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
                      context.read<VisitingBloc>().add(
                            PlaceChangedOrderInVisited(
                              fromIndex: fromIndex,
                              toIndex: toIndex,
                            ),
                          );
                    },
                    placeCards: state.visitedPlaces
                        .map((place) => PlaceVisitedCard(
                              key: ObjectKey(place),
                              place: place,
                              dateOfVisit: place.planDate,
                              onSharePressed: () {},
                              onDeletePressed: () {
                                context
                                    .read<VisitingBloc>()
                                    .add(PlaceInVisitedRemoved(place: place));
                              },
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
              );
            } else if (state is VisitingLoadedWithFailure) {}

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
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
      isDismissible: true,
      useRootNavigator: true,
      builder: (_) {
        return PlaceDetailsBottomSheet(place: place);
      },
    );

    if (!mounted) return;
    context.read<VisitingBloc>().add(const PlacesRequested());
  }

  Future<void> _pickPlanDate(Place place) async {
    final nowDate = DateTime.now();
    final nowYear = nowDate.year;

    final planDate = Platform.isIOS
        ? await _cupertinoDatePicker(nowDate, nowYear)
        : await _materialDatePicker(nowDate, nowYear);

    if (!mounted) return;
    context.read<VisitingBloc>().add(
          PlacePlanDateIsSet(
            place: place,
            dateTime: planDate,
          ),
        );
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

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                backgroundColor: Theme.of(context).colorScheme.surface,
                minimumDate: nowDate,
                initialDateTime: nowDate,
                maximumDate: DateTime(nowYear + 3),
                onDateTimeChanged: (dt) => dateTime = dt,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.defaultPaddingX2,
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, dateTime ?? nowDate),
                child: const Text(AppStrings.apply),
              ),
            ),
          ],
        );
      },
      context: context,
    );
  }
}
