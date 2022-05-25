import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/place_details/to_plan_button.dart';
import 'package:places/ui/widget/place_details/to_plan_inactive_button.dart';
import 'package:places/ui/widget/place_details/to_replan_button.dart';
import 'package:places/ui/widget/place_details/to_share_button.dart';

/// Экшн кнопка на экране детальной информации места, которая меняется в зависимости
/// от типа карточки
class PlaceDetailsDynamicActionButton extends StatelessWidget {
  final ValueChanged<Place> onPlanDate;
  final ValueChanged<Place> onShare;
  final Place place;

  const PlaceDetailsDynamicActionButton({
    Key? key,
    required this.place,
    required this.onPlanDate,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardLook = place.cardLook;

    if (cardLook == CardLook.view ||
        (cardLook == CardLook.toVisit && !place.isInFavorites)) {
      return const ToPlanInactiveButton();
    } else if (cardLook == CardLook.toVisit) {
      if (place.planDate != null) {
        return ToRePlanButton(
          currentPlanDate: place.planDate!,
          onPressed: () => onPlanDate(place),
        );
      }

      return ToPlanButton(
        onPressed: () => onPlanDate(place),
      );
    } else {
      return ToShareButton(
        onPressed: () => onShare(place),
      );
    }
  }
}
