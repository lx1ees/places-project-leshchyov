import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/place_card/place_card.dart';
import 'package:places/ui/widget/place_card/place_card_action_buttons.dart';

/// Виджет-карточка для отображения [place] достопримечательности в кратком виде
/// в списке для посещенных достопримечательностей датой [dateOfVisit]
class PlaceVisitedCard extends PlaceCard {
  PlaceVisitedCard({
    required Place place,
    required ValueChanged<Place> onDeletePressed,
    required ValueChanged<Place> onSharePressed,
    required Key key,
    DateTime? dateOfVisit,
    ValueChanged<Place>? onCardTapped,
  }) : super(
          place: place,
          isVisitable: true,
          isVisited: true,
          dateOfVisit: dateOfVisit,
          onDelete: onDeletePressed,
          actionButtons: PlaceVisitedCardActionButtons(
            onDeletePressed: () => onDeletePressed(place),
            onSharePressed: () => onSharePressed(place),
          ),
          onCardTapped: onCardTapped,
          key: key,
        );
}
