import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_card/sight_card_action_buttons.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// в списке для запланированных на дату [dateOfVisit] посещений
class SightToVisitCard extends SightCard {
  SightToVisitCard({
    required Sight sight,
    required DateTime dateOfVisit,
    required VoidCallback onDeletePressed,
    required VoidCallback onPlanPressed,
    required Key key,
    VoidCallback? onCardTapped,
  }) : super(
          sight: sight,
          isVisitable: true,
          dateOfVisit: dateOfVisit,
          onDelete: onDeletePressed,
          actionButtons: SightToVisitCardActionButtons(
            onDeletePressed: onDeletePressed,
            onPlanPressed: onPlanPressed,
          ),
          onCardTapped: onCardTapped,
          key: key,
        );
}
