import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/place_card/place_card.dart';

typedef OnDragAcceptedCallback = Function(int, int);

/// Виджет карточки достопримечательности с возможностью перетаскивания
/// [index] - текущий индекс карточки в списке
class DraggablePlaceCard extends StatelessWidget {
  final int index;
  final OnDragAcceptedCallback onDragAccepted;
  final PlaceCard currentPlaceCard;

  const DraggablePlaceCard({
    required this.index,
    required this.onDragAccepted,
    required this.currentPlaceCard,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<int>(
      data: index,
      feedback: SizedBox(
        height: AppConstants.cardDragFeedbackHeight,
        width: AppConstants.cardDragFeedbackWidth,
        child: currentPlaceCard,
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
          return currentPlaceCard;
        },
      ),
    );
  }
}
