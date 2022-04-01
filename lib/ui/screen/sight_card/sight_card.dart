import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card_bottom.dart';
import 'package:places/ui/screen/sight_card/sight_card_top.dart';

/// Абстрактный виджет-карточка для отображения [sight] достопримечательности в кратком виде
/// Если карточка предназначена для вывода достопримечательности в списке
/// для посещения, то передается флаг [isVisitable] в состоянии true.
/// Если достоиримечательность посещена, то передается флаг [isVisited] в
/// состоянии true.
/// [dateOfVisit] - дата визита (или запланированного, или уже состоявшегося)
abstract class SightCard extends StatelessWidget {
  final Sight sight;
  final bool isVisitable;
  final bool isVisited;
  final DateTime? dateOfVisit;

  const SightCard({
    required this.sight,
    this.isVisitable = false,
    this.isVisited = false,
    this.dateOfVisit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Card(
        color: AppColors.sightCardBackgroundColor,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        child: Column(
          children: [
            SightCardTop(
              type: sight.type,
              url: sight.url,
              isVisitable: isVisitable,
              isVisited: isVisited,
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
      ),
    );
  }
}
