import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_screen_widget_model.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';
import 'package:places/ui/widget/common/custom_text_icon_button.dart';
import 'package:places/ui/widget/common/loading_indicator.dart';
import 'package:places/ui/widget/place_details/place_details_description.dart';
import 'package:places/ui/widget/place_details/place_details_dynamic_action_button.dart';
import 'package:places/ui/widget/place_details/place_details_screen_sliver_app_bar.dart';
import 'package:places/ui/widget/place_details/place_details_title.dart';

/// Виджет-окно для отображения полной информации о [place] достопримечательности
/// и выполнения действий с ней.
class PlaceDetailsScreen
    extends ElementaryWidget<IPlaceDetailsScreenWidgetModel> {
  static const String routeName = '/details';
  final Place place;

  const PlaceDetailsScreen({
    required WidgetModelFactory widgetModelFactory,
    required this.place,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IPlaceDetailsScreenWidgetModel wm) {
    return Scaffold(
      body: EntityStateNotifierBuilder<Place>(
        listenableEntityState: wm.currentPlaceState,
        loadingBuilder: (_, __) => const LoadingIndicator(),
        builder: (_, place) {
          if (place == null) return const SizedBox.shrink();

          return CustomScrollView(
            controller: wm.scrollController,
            slivers: [
              PlaceDetailsScreenSliverAppBar(
                place: place,
                scrollController: wm.scrollController,
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
                        shortDescription: AppStrings.placeShortDescriptionMock,
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
                        label: AppStrings.placeDetailsRouteButtonTitle,
                        icon: SvgPicture.asset(
                          AppAssets.goIcon,
                        ),
                      ),
                      const SizedBox(
                        height: AppConstants.defaultPadding,
                      ),
                      const Divider(
                        thickness: AppConstants.defaultDividerThickness,
                        height: AppConstants.defaultPadding,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PlaceDetailsDynamicActionButton(
                              place: place,
                              onPlanDate: wm.onPlanPlacePressed,
                              onShare: wm.onSharePlacePressed,
                            ),
                          ),
                          Expanded(
                            child: CustomTextIconButton(
                              label: place.isInFavorites
                                  ? AppStrings
                                      .placeDetailsInFavActionButtonTitle
                                  : AppStrings
                                      .placeDetailsToFavActionButtonTitle,
                              icon: SvgPicture.asset(
                                place.isInFavorites
                                    ? AppAssets.heartFullIcon
                                    : AppAssets.heartIcon,
                                color: wm.colorScheme.onPrimary,
                              ),
                              onPressed: wm.onAddPlaceInFavoritesPressed,
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
    );
  }
}
