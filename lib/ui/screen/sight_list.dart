import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

typedef OnDragComplete = void Function(int fromIndex, int toIndex);

/// Виджет-список карточек достопримечательностей [sightCards]
/// Если список пустой, выводится виджет-заглушка [emptyListPlaceholder]
class SightList extends StatelessWidget {
  final List<SightCard> sightCards;
  final Widget? emptyListPlaceholder;
  final OnDragComplete? onDragComplete;

  const SightList({
    required this.sightCards,
    this.emptyListPlaceholder,
    this.onDragComplete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isListEmpty = sightCards.isEmpty;
    final isEmptyListPlaceholderProvided = emptyListPlaceholder != null;
    final isDraggable = onDragComplete != null;
    final onDragAccepted = onDragComplete ?? (_, __) {};

    if (isListEmpty) {
      if (isEmptyListPlaceholderProvided) {
        return Center(
          child: emptyListPlaceholder,
        );
      }

      return const SizedBox();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        0,
        AppConstants.defaultPadding,
        AppConstants.defaultPaddingX4,
      ),
      itemCount: sightCards.length,
      itemBuilder: (context, index) {
        final currentSightCard = sightCards[index];
        if (!isDraggable) {
          return currentSightCard;
        }

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
      },
    );
  }
}
