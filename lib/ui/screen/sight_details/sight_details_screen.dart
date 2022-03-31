import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_details/sight_details_action_button.dart';
import 'package:places/ui/screen/sight_details/sight_details_back_button.dart';
import 'package:places/ui/screen/sight_details/sight_details_description.dart';
import 'package:places/ui/screen/sight_details/sight_details_image_gallery.dart';
import 'package:places/ui/screen/sight_details/sight_details_route_button.dart';
import 'package:places/ui/screen/sight_details/sight_details_title.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SightDetailsImageGallery(url: sight.url),
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
                        type: sight.type,
                        shortDescription: AppStrings.sightShortDescriptionMock,
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      SightDetailsDescription(description: sight.details),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      const SightDetailsRouteButton(),
                      const SizedBox(height: AppConstants.defaultPadding),
                      const Divider(
                        thickness: AppConstants.defaultDividerThickness,
                        height: AppConstants.defaultPadding,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: SightDetailsActionButton(
                              iconUrl: AppAssets.calendarIconAssetPath,
                              title:
                                  AppStrings.sightDetailsPlanActionButtonTitle,
                            ),
                          ),
                          Expanded(
                            child: SightDetailsActionButton(
                              iconUrl: AppAssets.heartIconAssetPath,
                              title:
                                  AppStrings.sightDetailsInFavActionButtonTitle,
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
          const Positioned(
            left: AppConstants.defaultPadding,
            top: AppConstants.defaultPaddingX2,
            child: SightDetailsBackButton(),
          ),
        ],
      ),
    );
  }
}
