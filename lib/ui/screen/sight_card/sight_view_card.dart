import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_card/sight_card_action_buttons.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// в списке интересных мест
class SightViewCard extends SightCard {
  SightViewCard({
    required Sight sight,
    required VoidCallback onFavoritePressed,
    VoidCallback? onCardTapped,
    Key? key,
  }) : super(
          sight: sight,
          actionButtons:
              SightViewCardActionButtons(onFavoritePressed: onFavoritePressed),
          onCardTapped: onCardTapped,
          key: key,
        );
}
