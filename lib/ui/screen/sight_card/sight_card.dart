import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card_bottom.dart';
import 'package:places/ui/screen/sight_card/sight_card_top.dart';

/// Виджет-карточка для отображения [sight] достопримечательности в кратком виде
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
          ),
          SightCardBottom(
            name: sight.name,
            shortDescription: sight.shortDescription,
          ),
        ],
      ),
    );
  }
}
