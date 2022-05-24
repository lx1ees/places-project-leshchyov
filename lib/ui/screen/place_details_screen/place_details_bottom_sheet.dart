import 'dart:ui';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet_widget_model.dart';
import 'package:places/ui/widget/common/bottom_sheet_close_button.dart';
import 'package:places/ui/widget/common/bottom_sheet_indicator.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';
import 'package:places/ui/widget/common/custom_text_icon_button.dart';
import 'package:places/ui/widget/place_details/place_details_description.dart';
import 'package:places/ui/widget/place_details/place_details_dynamic_action_button.dart';
import 'package:places/ui/widget/place_details/place_details_screen_sliver_app_bar.dart';
import 'package:places/ui/widget/place_details/place_details_title.dart';

/// Виджет-окно для отображения полной информации о [place] достопримечательности
/// и выполнения действий с ней.
/// [isExpanded] - флаг, указывающий как показывать экран - в развернутом виде или
/// свернутом
class PlaceDetailsBottomSheet
    extends ElementaryWidget<IPlaceDetailsBottomSheetWidgetModel> {
  final Place place;
  final bool isExpanded;

  const PlaceDetailsBottomSheet({
    required WidgetModelFactory widgetModelFactory,
    required this.place,
    this.isExpanded = false,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IPlaceDetailsBottomSheetWidgetModel wm) {
    return Padding(
      padding:
          EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: wm.onDraggableScrollableNotification,
        child: StateNotifierBuilder<bool>(
          listenableState: wm.isExpandedState,
          builder: (_, isExpandedFromState) {
            final isExpanded = isExpandedFromState ?? false;

            return DraggableScrollableSheet(
              controller: wm.scrollController,
              initialChildSize: isExpanded
                  ? 1
                  : AppConstants.initialDraggableBottomSheetHeight,
              minChildSize: AppConstants.minDraggableBottomSheetHeight,
              builder: (_, scrollController) {
                final cornerRadius = Radius.circular(
                  isExpanded ? 0 : AppConstants.button3BorderRadius,
                );

                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: cornerRadius,
                    topRight: cornerRadius,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: wm.theme.backgroundColor,
                        child: StateNotifierBuilder<Place>(
                          listenableState: wm.currentPlaceState,
                          builder: (_, place) {
                            if (place == null) return const SizedBox.shrink();

                            return CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                PlaceDetailsScreenSliverAppBar(
                                  place: place,
                                  scrollController: scrollController,
                                  isBackButtonVisible: isExpanded,
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.defaultPadding,
                                    vertical: AppConstants.defaultPaddingX1_5,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildListDelegate(
                                      [
                                        PlaceDetailsTitle(
                                          name: place.name,
                                          type: place.placeType.name,
                                          shortDescription: AppStrings
                                              .placeShortDescriptionMock,
                                        ),
                                        const SizedBox(
                                          height:
                                              AppConstants.defaultPaddingX1_5,
                                        ),
                                        PlaceDetailsDescription(
                                          description: place.description,
                                        ),
                                        const SizedBox(
                                          height:
                                              AppConstants.defaultPaddingX1_5,
                                        ),
                                        CustomElevatedButton(
                                          onPressed: () {},
                                          label: AppStrings
                                              .placeDetailsRouteButtonTitle,
                                          icon: SvgPicture.asset(
                                            AppAssets.goIcon,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppConstants.defaultPadding,
                                        ),
                                        const Divider(
                                          thickness: AppConstants
                                              .defaultDividerThickness,
                                          height: AppConstants.defaultPadding,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  PlaceDetailsDynamicActionButton(
                                                place: place,
                                                onPlanDate:
                                                    wm.onPlanPlacePressed,
                                                onShare: wm.onSharePlacePressed,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextIconButton(
                                                label: AppStrings
                                                    .placeDetailsInFavActionButtonTitle,
                                                icon: SvgPicture.asset(
                                                  place.isInFavorites
                                                      ? AppAssets.heartFullIcon
                                                      : AppAssets.heartIcon,
                                                  color:
                                                      wm.colorScheme.onPrimary,
                                                ),
                                                onPressed: wm
                                                    .onAddPlaceInFavoritesPressed,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: !isExpanded,
                        child: const Positioned(
                          top: AppConstants.defaultPaddingX0_75,
                          left: 0,
                          right: 0,
                          child: BottomSheetIndicator(),
                        ),
                      ),
                      Visibility(
                        visible: !isExpanded,
                        child: const Positioned(
                          top: AppConstants.defaultPadding,
                          right: AppConstants.defaultPadding,
                          child: BottomSheetCloseButton(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
