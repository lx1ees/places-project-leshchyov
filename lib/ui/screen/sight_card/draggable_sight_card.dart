import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

typedef OnDragAcceptedCallback = Function(int, int);

/// Виджет карточки достопримечательности с возможностью перетаскивания
/// [index] - текущий индекс карточки в списке
class DraggableSightCard extends StatelessWidget {
  final int index;
  final OnDragAcceptedCallback onDragAccepted;
  final SightCard currentSightCard;

  const DraggableSightCard({
    required this.index,
    required this.onDragAccepted,
    required this.currentSightCard,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<int>(
      data: index,
      feedback: SizedBox(
        height: AppConstants.cardDragFeedbackHeight,
        width: AppConstants.cardDragFeedbackWidth,
        child: currentSightCard,
      ),
      maxSimultaneousDrags: 1,
      childWhenDragging: const SizedBox.shrink(),
      child: DragTarget<int>(
        onAccept: (fromIndex) => onDragAccepted(fromIndex, index),
        onWillAccept: (fromIndex) {
          return fromIndex != index;
        },
        builder: (
          context,
          candidateData,
          rejectedData,
        ) {
          return currentSightCard;
        },
        // child: sightCard,
      ),
    );
  }
}
