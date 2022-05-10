import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_card/place_card.dart';
import 'package:places/ui/screen/place_card/place_card_action_buttons.dart';

/// Виджет-карточка для отображения [place] достопримечательности в кратком виде
/// в списке для запланированных на дату [dateOfVisit] посещений
class PlaceToVisitCard extends PlaceCard {
  PlaceToVisitCard({
    required Place place,
    required VoidCallback onDeletePressed,
    required VoidCallback onPlanPressed,
    required Key key,
    DateTime? dateOfVisit,
    VoidCallback? onCardTapped,
  }) : super(
          place: place,
          isVisitable: true,
          dateOfVisit: dateOfVisit,
          onDelete: onDeletePressed,
          actionButtons: PlaceToVisitCardActionButtons(
            onDeletePressed: onDeletePressed,
            onPlanPressed: onPlanPressed,
          ),
          onCardTapped: onCardTapped,
          key: key,
        );
}
