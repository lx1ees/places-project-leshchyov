import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';
import 'package:places/ui/widget/place_card/place_card_action_buttons.dart';
import 'package:places/ui/widget/place_card/place_card_top.dart';

/// Виджет-карточка для отображения [place] достопримечательности на карте с возможностью
/// проложить маршрут
/// [onFavoritePressed] - обработчик нажатия на кнопку Добавить в избранное
/// [onCardTapped] - обработчик нажатия на карточку
/// [onRoutePressed] - обработчик нажатия на кнопку построения маршрута
class MapPlaceCard extends StatelessWidget {
  final Place place;
  final ValueChanged<Place> onFavoritePressed;
  final ValueChanged<Place> onRoutePressed;
  final ValueChanged<Place> onCardTapped;

  const MapPlaceCard({
    required this.place,
    required this.onFavoritePressed,
    required this.onRoutePressed,
    required this.onCardTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius =
        BorderRadius.circular(AppConstants.cardBorderRadius);
    final imageUrl = place.urls.isNotEmpty ? place.urls[0] : null;
    final onCardTappedCallback = onCardTapped;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Stack(
        children: [
          Material(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: cardBorderRadius,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: AppConstants.defaultCardElevation,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PlaceCardTop(
                      type: place.placeType.name,
                      url: imageUrl,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(
                          AppConstants.defaultPadding,
                          0,
                          AppConstants.defaultPadding,
                          AppConstants.defaultPadding,
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: AppConstants.defaultPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      place.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          AppTypography.textTextStyle.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      AppStrings.placeShortDescriptionMock,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          AppTypography.smallTextStyle.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomElevatedButton(
                              shrink: false,
                              icon: SvgPicture.asset(
                                AppAssets.goIcon,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: cardBorderRadius,
                      highlightColor: Colors.transparent,
                      onTap: () => onCardTappedCallback(place),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: PlaceViewCardActionButtons(
                    onFavoritePressed: onFavoritePressed,
                    place: place,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: CustomElevatedButton(
                      onPressed: () => onRoutePressed(place),
                      shrink: false,
                      icon: SvgPicture.asset(
                        AppAssets.goIcon,
                        // color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
