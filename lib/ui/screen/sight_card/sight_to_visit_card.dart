import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// в списке для запланированных на дату [dateOfVisit] посещений
class SightToVisitCard extends SightCard {
  const SightToVisitCard({
    required Sight sight,
    required DateTime dateOfVisit,
    Key? key,
  }) : super(
          sight: sight,
          isVisitable: true,
          dateOfVisit: dateOfVisit,
          key: key,
        );
}
