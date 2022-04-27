import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_description.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_screen_sliver_app_bar.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_title.dart';
import 'package:places/ui/widgets/bottom_sheet_close_button.dart';
import 'package:places/ui/widgets/bottom_sheet_indicator.dart';
import 'package:places/ui/widgets/custom_elevated_button.dart';
import 'package:places/ui/widgets/custom_text_icon_button.dart';

/// Виджет-окно для отображения полной информации о [sight] достопримечательности
/// и выполнения действий с ней.
/// [isExpanded] - флаг, указывающий как показывать экран - в развернутом виде или
/// свернутом
class SightDetailsBottomSheet extends StatefulWidget {
  final Sight sight;
  final bool isExpanded;

  const SightDetailsBottomSheet({
    required this.sight,
    this.isExpanded = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SightDetailsBottomSheet> createState() =>
      _SightDetailsBottomSheetState();
}

class _SightDetailsBottomSheetState extends State<SightDetailsBottomSheet> {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();
  var _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final sight = widget.sight;
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
                        SightDetailsScreenSliverAppBar(
                          sight: sight,
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
                                SightDetailsTitle(
                                  name: sight.name,
                                  type: sight.category.name,
                                  shortDescription:
                                      AppStrings.sightShortDescriptionMock,
                                ),
                                const SizedBox(
                                  height: AppConstants.defaultPaddingX1_5,
                                ),
                                SightDetailsDescription(
                                  description: sight.details,
                                ),
                                const SizedBox(
                                  height: AppConstants.defaultPaddingX1_5,
                                ),
                                CustomElevatedButton(
                                  onPressed: () {},
                                  label:
                                      AppStrings.sightDetailsRouteButtonTitle,
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
                                      child: CustomTextIconButton(
                                        label: AppStrings
                                            .sightDetailsPlanActionButtonTitle,
                                        icon: SvgPicture.asset(
                                          AppAssets.calendarIcon,
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextIconButton(
                                        label: AppStrings
                                            .sightDetailsInFavActionButtonTitle,
                                        icon: SvgPicture.asset(
                                          AppAssets.heartIcon,
                                          color: colorScheme.onPrimary,
                                        ),
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
    setState(() {
      if (_isExpanded != isExpanded) _isExpanded = isExpanded;
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          isExpanded ? Theme.of(context).backgroundColor : Colors.transparent,
    ));
  }
}
