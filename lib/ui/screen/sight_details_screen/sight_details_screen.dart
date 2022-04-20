import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_description.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_image_gallery.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_screen_sliver_app_bar.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_title.dart';
import 'package:places/ui/widgets/custom_elevated_button.dart';
import 'package:places/ui/widgets/custom_icon_with_background_button.dart';
import 'package:places/ui/widgets/custom_text_icon_button.dart';
import 'package:places/utils/extensions.dart';

/// Виджет-окно для отображения полной информации о [sight] достопримечательности
/// и выполнения действий с ней
class SightDetailsScreen extends StatefulWidget {
  final Sight sight;

  const SightDetailsScreen({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sight = widget.sight;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SightDetailsScreenSliverAppBar(
                sight: sight,
                scrollController: _scrollController,
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
                        shortDescription: AppStrings.sightShortDescriptionMock,
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      SightDetailsDescription(description: sight.details),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      CustomElevatedButton(
                        onPressed: () {},
                        label: AppStrings.sightDetailsRouteButtonTitle,
                        icon: SvgPicture.asset(AppAssets.goIcon),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      const Divider(
                        thickness: AppConstants.defaultDividerThickness,
                        height: AppConstants.defaultPadding,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextIconButton(
                              label:
                                  AppStrings.sightDetailsPlanActionButtonTitle,
                              icon: SvgPicture.asset(
                                AppAssets.calendarIcon,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomTextIconButton(
                              label:
                                  AppStrings.sightDetailsInFavActionButtonTitle,
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
          Positioned(
            top: AppConstants.defaultPaddingX3 + 4,
            left: AppConstants.defaultPaddingX0_5,
            child: CustomIconWithBackgroundButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: AppConstants.defaultButtonIconSize,
                color: colorScheme.onPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
