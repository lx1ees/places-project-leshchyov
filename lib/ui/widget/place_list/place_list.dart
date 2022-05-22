import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widget/place_card/draggable_place_card.dart';
import 'package:places/ui/widget/place_card/place_card.dart';

typedef OnDragComplete = void Function(int fromIndex, int toIndex);

/// Виджет-список карточек достопримечательностей [placeCards]
/// Если список пустой, выводится виджет-заглушка [emptyListPlaceholder]
class PlaceList extends StatelessWidget {
  final List<PlaceCard> placeCards;
  final Widget? emptyListPlaceholder;
  final OnDragComplete? onDragComplete;

  const PlaceList({
    required this.placeCards,
    this.emptyListPlaceholder,
    this.onDragComplete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isListEmpty = placeCards.isEmpty;
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

    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppConstants.defaultPadding,
                  crossAxisSpacing: AppConstants.defaultPaddingX2,
                  childAspectRatio: 1.4,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.defaultPadding,
                  0,
                  AppConstants.defaultPadding,
                  AppConstants.defaultPaddingX4,
                ),
                itemCount: placeCards.length,
                itemBuilder: (context, index) {
                  final currentPlaceCard = placeCards[index];
                  if (!isDraggable) {
                    return currentPlaceCard;
                  }

                  return DraggablePlaceCard(
                    index: index,
                    onDragAccepted: onDragAccepted,
                    currentPlaceCard: currentPlaceCard,
                  );
                },
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.defaultPadding,
                0,
                AppConstants.defaultPadding,
                AppConstants.defaultPaddingX4,
              ),
              itemCount: placeCards.length,
              itemBuilder: (context, index) {
                final currentPlaceCard = placeCards[index];
                if (!isDraggable) {
                  return currentPlaceCard;
                }

                return DraggablePlaceCard(
                  index: index,
                  onDragAccepted: onDragAccepted,
                  currentPlaceCard: currentPlaceCard,
                );
              },
            );
    });
  }
}
