import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

/// Виджет-список карточек достопримечательностей [sightCards]
/// Если список пустой, выводится виджет-заглушка [emptyListPlaceholder]
class SightList extends StatelessWidget {
  final List<SightCard> sightCards;
  final Widget? emptyListPlaceholder;

  const SightList({
    required this.sightCards,
    this.emptyListPlaceholder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isListEmpty = sightCards.isEmpty;
    final isEmptyListPlaceholderProvided = emptyListPlaceholder != null;

    if (isListEmpty) {
      if (isEmptyListPlaceholderProvided) {
        return Center(
          child: emptyListPlaceholder,
        );
      }

      return const SizedBox();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
        ),
        child: Column(
          children: sightCards
              .map(
                (sightCard) => Column(
                  children: [
                    sightCard,
                    const SizedBox(height: AppConstants.defaultPadding),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
