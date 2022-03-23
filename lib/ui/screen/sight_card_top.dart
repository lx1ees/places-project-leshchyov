import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

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
      height: 96,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.sightCardImageMockColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.cardBorderRadius),
          topRight: Radius.circular(AppConstants.cardBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
              height: 20,
              width: 20,
              color: AppColors.sightCardIconMockColor,
            ),
          ],
        ),
      ),
    );
  }
}
