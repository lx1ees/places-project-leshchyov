import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения верхней части карточки достопримечательности
/// с информацией о типе [type] и картинкой по ссылке [url]
class SightCardTop extends StatelessWidget {
  final String type;
  final String url;

  const SightCardTop({
    required this.type,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.sightCardImageHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.sightImageMockColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.cardBorderRadius),
          topRight: Radius.circular(AppConstants.cardBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.defaultPadding,
          AppConstants.defaultPadding,
          AppConstants.defaultPadding,
          0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sightCardTypeTextStyle,
              ),
            ),
            Container(
              height: AppConstants.defaultIconSize,
              width: AppConstants.defaultIconSize,
              color: AppColors.sightButtonMockColor,
            ),
          ],
        ),
      ),
    );
  }
}
