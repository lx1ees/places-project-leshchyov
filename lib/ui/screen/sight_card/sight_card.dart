import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card_action_buttons.dart';
import 'package:places/ui/screen/sight_card/sight_card_bottom.dart';
import 'package:places/ui/screen/sight_card/sight_card_dismiss_background.dart';
import 'package:places/ui/screen/sight_card/sight_card_top.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// Если карточка предназначена для вывода достопримечательности в списке
/// для посещения, то передается флаг [isVisitable] в состоянии true.
/// Если достоиримечательность посещена, то передается флаг [isVisited] в
/// состоянии true.
/// [dateOfVisit] - дата визита (или запланированного, или уже состоявшегося)
/// [actionButtons] - виджет с кнопками действий
/// [onCardTapped] - обработчик нажатия на карточку
class SightCard extends StatelessWidget {
  final Sight sight;
  final bool isVisitable;
  final bool isVisited;
  final DateTime? dateOfVisit;
  final SightCardActionButtons actionButtons;
  final VoidCallback? onCardTapped;
  final VoidCallback? onDelete;

  const SightCard({
    required this.sight,
    required this.actionButtons,
    this.onCardTapped,
    this.isVisitable = false,
    this.isVisited = false,
    this.dateOfVisit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius =
        BorderRadius.circular(AppConstants.cardBorderRadius);
    final isDeletable = onDelete != null;
    final onDismiss = onDelete ?? () {};
    final imageUrl = sight.urls.isNotEmpty ? sight.urls[0] : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Stack(
        children: [
          const SightCardDismissBackground(),
          Dismissible(
            key: key ?? UniqueKey(),
            direction: isDeletable
                ? DismissDirection.endToStart
                : DismissDirection.none,
            onDismissed: (_) => onDismiss(),
            child: AspectRatio(
              aspectRatio: AppConstants.cardAspectRatio,
              child: Material(
                color: Theme.of(context).primaryColorLight,
                borderRadius: cardBorderRadius,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SightCardTop(
                          type: sight.category.name,
                          url: imageUrl,
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        SightCardBottom(
                          name: sight.name,
                          shortDescription: sight.details,
                          isVisitable: isVisitable,
                          isVisited: isVisited,
                          dateOfVisit: dateOfVisit,
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: cardBorderRadius,
                          highlightColor: Colors.transparent,
                          onTap: onCardTapped,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: actionButtons,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
