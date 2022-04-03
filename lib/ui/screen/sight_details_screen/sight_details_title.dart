import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения имени [name], типа [type] и краткой информации [shortDescription]
/// достопримечательности
class SightDetailsTitle extends StatelessWidget {
  final String name;
  final String type;
  final String shortDescription;

  const SightDetailsTitle({
    required this.name,
    required this.type,
    required this.shortDescription,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTypography.sightDetailsNameTextStyle,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sightDetailsTypeTextStyle,
              ),
            ),
            const SizedBox(width: AppConstants.defaultPadding),
            Text(
              shortDescription,
              style: AppTypography.sightDetailsScheduleStyle,
            ),
          ],
        ),
      ],
    );
  }
}
