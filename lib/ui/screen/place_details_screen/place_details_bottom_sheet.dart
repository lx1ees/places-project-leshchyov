import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_description.dart';
import 'package:places/ui/screen/place_details_screen/place_details_dynamic_action_button.dart';
import 'package:places/ui/screen/place_details_screen/place_details_screen_sliver_app_bar.dart';
import 'package:places/ui/screen/place_details_screen/place_details_title.dart';
import 'package:places/ui/widget/bottom_sheet_close_button.dart';
import 'package:places/ui/widget/bottom_sheet_indicator.dart';
import 'package:places/ui/widget/custom_elevated_button.dart';
import 'package:places/ui/widget/custom_text_icon_button.dart';
import 'package:provider/provider.dart';

/// Виджет-окно для отображения полной информации о [place] достопримечательности
/// и выполнения действий с ней.
/// [isExpanded] - флаг, указывающий как показывать экран - в развернутом виде или
/// свернутом
class PlaceDetailsBottomSheet extends StatefulWidget {
  final Place place;
  final bool isExpanded;

  const PlaceDetailsBottomSheet({
    required this.place,
    this.isExpanded = false,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceDetailsBottomSheet> createState() =>
      _PlaceDetailsBottomSheetState();
}

class _PlaceDetailsBottomSheetState extends State<PlaceDetailsBottomSheet> {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();
  Place? _place;
  var _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _place = widget.place;
    _isExpanded = widget.isExpanded;
    _requestForPlaceDetails();
  }

  @override
  Widget build(BuildContext context) {
    final place = _place;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding:
          EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          if (notification.maxExtent - notification.extent < 0.001) {
            _setExpanded(true);
          } else {
            _setExpanded(false);
          }

          return true;
        },
        child: DraggableScrollableSheet(
          controller: _scrollController,
          initialChildSize: widget.isExpanded
              ? 1
              : AppConstants.initialDraggableBottomSheetHeight,
          minChildSize: AppConstants.minDraggableBottomSheetHeight,
          builder: (context, scrollController) {
            final cornerRadius = Radius.circular(
              _isExpanded ? 0 : AppConstants.button3BorderRadius,
            );

            if (place == null) return const SizedBox.shrink();

            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: cornerRadius,
                topRight: cornerRadius,
              ),
              child: Stack(
                children: [
                  Container(
                    color: Theme.of(context).backgroundColor,
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        PlaceDetailsScreenSliverAppBar(
                          place: place,
                          scrollController: scrollController,
                          isBackButtonVisible: _isExpanded,
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
                                  shortDescription:
                                      AppStrings.placeShortDescriptionMock,
                                ),
                                const SizedBox(
                                  height: AppConstants.defaultPaddingX1_5,
                                ),
                                PlaceDetailsDescription(
                                  description: place.description,
                                ),
                                const SizedBox(
                                  height: AppConstants.defaultPaddingX1_5,
                                ),
                                CustomElevatedButton(
                                  onPressed: () {},
                                  label:
                                      AppStrings.placeDetailsRouteButtonTitle,
                                  icon: SvgPicture.asset(AppAssets.goIcon),
                                ),
                                const SizedBox(
                                  height: AppConstants.defaultPadding,
                                ),
                                const Divider(
                                  thickness:
                                      AppConstants.defaultDividerThickness,
                                  height: AppConstants.defaultPadding,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PlaceDetailsDynamicActionButton(
                                        place: place,
                                        onPressed: _requestForPlaceDetails,
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
                                          color: colorScheme.onPrimary,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<PlaceInteractor>()
                                              .changeFavorite(place);
                                          _requestForPlaceDetails();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !_isExpanded,
                    child: const Positioned(
                      top: AppConstants.defaultPaddingX0_75,
                      left: 0,
                      right: 0,
                      child: BottomSheetIndicator(),
                    ),
                  ),
                  Visibility(
                    visible: !_isExpanded,
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
        ),
      ),
    );
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
      });
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            isExpanded ? Theme.of(context).backgroundColor : Colors.transparent,
      ));
    }
  }

  /// Обновление места (временная мера пока нет стейтменеджмента)
  Future<void> _requestForPlaceDetails() async {
    final place = await context.read<PlaceInteractor>().getPlaceDetails(
          place: widget.place,
        );
    setState(() {
      _place = place;
    });
  }
}
