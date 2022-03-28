import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения нижней части карточки достопримечательности
/// с наименованием достопримечательности [name] и кратким
/// описанием [shortDescription]
class SightCardBottom extends StatelessWidget {
  final String name;
  final String shortDescription;

  const SightCardBottom({
    required this.name,
    required this.shortDescription,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.defaultPadding,
          0,
          AppConstants.defaultPadding,
          AppConstants.defaultPadding,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.sightCardNameTextStyle,
            ),
            Flexible(
              child: Text(
                shortDescription,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sightCardDetailsTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
