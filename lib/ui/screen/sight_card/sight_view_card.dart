import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// в списке интересных мест
class SightViewCard extends SightCard {
  const SightViewCard({
    required Sight sight,
    Key? key,
  }) : super(
          sight: sight,
          key: key,
        );
}
