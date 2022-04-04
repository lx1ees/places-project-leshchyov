import 'package:flutter/material.dart';
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
              style: AppTypography.textTextStyle.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
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
                      ? AppTypography.smallTextStyle.copyWith(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        )
                      : AppTypography.smallTextStyle.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                shortDescription,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.smallTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
