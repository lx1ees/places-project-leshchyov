import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/place_card/place_card.dart';
import 'package:places/ui/widget/place_card/place_card_action_buttons.dart';

/// Виджет-карточка для отображения [place] достопримечательности в кратком виде
/// в списке интересных мест
class PlaceViewCard extends PlaceCard {
  PlaceViewCard({
    required Place place,
    required ValueChanged<Place> onFavoritePressed,
    ValueChanged<Place>? onCardTapped,
    Key? key,
  }) : super(
          place: place,
          actionButtons: PlaceViewCardActionButtons(
            onFavoritePressed: onFavoritePressed,
            place: place,
          ),
          onCardTapped: onCardTapped,
          key: key,
        );
}
