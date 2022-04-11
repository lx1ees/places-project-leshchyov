import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_card/sight_card_action_buttons.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// в списке для посещенных достопримечательностей датой [dateOfVisit]
class SightVisitedCard extends SightCard {
  SightVisitedCard({
    required Sight sight,
    required DateTime dateOfVisit,
    required VoidCallback onDeletePressed,
    required VoidCallback onSharePressed,
    VoidCallback? onCardTapped,
    Key? key,
  }) : super(
          sight: sight,
          isVisitable: true,
          isVisited: true,
          dateOfVisit: dateOfVisit,
          actionButtons: SightVisitedCardActionButtons(
            onDeletePressed: onDeletePressed,
            onSharePressed: onSharePressed,
          ),
          onCardTapped: onCardTapped,
          key: key,
        );
}
