import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/utils/extensions.dart';

/// Виджет для отображения нижней части карточки достопримечательности
/// с наименованием достопримечательности [name] и кратким
/// описанием [shortDescription]
class SightCardBottom extends StatelessWidget {
  final String name;
  final String shortDescription;
  final bool isVisitable;
  final bool isVisited;
  final DateTime? dateOfVisit;

  const SightCardBottom({
    required this.name,
    required this.shortDescription,
    this.isVisitable = false,
    this.isVisited = false,
    this.dateOfVisit,
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
            Visibility(
              visible: isVisitable && dateOfVisit != null,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: AppConstants.defaultPadding),
                child: Text(
                  isVisited
                      ? dateOfVisit.visitedString()
                      : dateOfVisit.toBeVisitedString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isVisited
                      ? AppTypography.sightCardVisitInfoTextStyle
                      : AppTypography.sightCardVisitInfoTextStyle.copyWith(
                          color: AppColors.sightCardVisitInfoTextColor,
                        ),
                ),
              ),
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
