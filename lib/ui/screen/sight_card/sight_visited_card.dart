import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// в списке для посещенных достопримечательностей датой [dateOfVisit]
class SightVisitedCard extends SightCard {
  const SightVisitedCard({
    required Sight sight,
    required DateTime dateOfVisit,
    Key? key,
  }) : super(
          sight: sight,
          isVisitable: true,
          isVisited: true,
          dateOfVisit: dateOfVisit,
          key: key,
        );
}
