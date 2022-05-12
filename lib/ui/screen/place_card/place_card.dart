import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_card/place_card_action_buttons.dart';
import 'package:places/ui/screen/place_card/place_card_bottom.dart';
import 'package:places/ui/screen/place_card/place_card_dismiss_background.dart';
import 'package:places/ui/screen/place_card/place_card_top.dart';

/// Виджет-карточка для отображения [place] достопримечательности в кратком виде
/// Если карточка предназначена для вывода достопримечательности в списке
/// для посещения, то передается флаг [isVisitable] в состоянии true.
/// Если достоиримечательность посещена, то передается флаг [isVisited] в
/// состоянии true.
/// [dateOfVisit] - дата визита (или запланированного, или уже состоявшегося)
/// [actionButtons] - виджет с кнопками действий
/// [onCardTapped] - обработчик нажатия на карточку
class PlaceCard extends StatelessWidget {
  final Place place;
  final bool isVisitable;
  final bool isVisited;
  final DateTime? dateOfVisit;
  final PlaceCardActionButtons actionButtons;
  final VoidCallback? onCardTapped;
  final VoidCallback? onDelete;

  const PlaceCard({
    required this.place,
    required this.actionButtons,
    this.onCardTapped,
    this.isVisitable = false,
    this.isVisited = false,
    this.dateOfVisit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius =
        BorderRadius.circular(AppConstants.cardBorderRadius);
    final isDeletable = onDelete != null;
    final onDismiss = onDelete ?? () {};
    final imageUrl = place.urls.isNotEmpty ? place.urls[0] : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Stack(
        children: [
          const PlaceCardDismissBackground(),
          Dismissible(
            key: key ?? UniqueKey(),
            direction: isDeletable
                ? DismissDirection.endToStart
                : DismissDirection.none,
            onDismissed: (_) => onDismiss(),
            child: AspectRatio(
              aspectRatio: AppConstants.cardAspectRatio,
              child: Material(
                color: Theme.of(context).primaryColorLight,
                borderRadius: cardBorderRadius,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        PlaceCardTop(
                          type: place.placeType.name,
                          url: imageUrl,
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        PlaceCardBottom(
                          name: place.name,
                          shortDescription: place.description,
                          isVisitable: isVisitable,
                          isVisited: isVisited,
                          dateOfVisit: dateOfVisit,
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: cardBorderRadius,
                          highlightColor: Colors.transparent,
                          onTap: onCardTapped,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: actionButtons,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
