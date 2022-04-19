import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_description.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_image_gallery.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_title.dart';
import 'package:places/ui/widgets/custom_elevated_button.dart';
import 'package:places/ui/widgets/custom_icon_with_background_button.dart';
import 'package:places/ui/widgets/custom_text_icon_button.dart';

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
  @override
  Widget build(BuildContext context) {
    final sight = widget.sight;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SightDetailsImageGallery(urls: sight.urls),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                    vertical: AppConstants.defaultPaddingX1_5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
              ],
            ),
          ),
          Positioned(
            top: AppConstants.defaultPaddingX2,
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
