import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения кнопки действия на экране деталей достопримечательности
/// с наименованием [title]
class SightDetailsActionButton extends StatelessWidget {
  final String title;
  final String iconUrl;

  const SightDetailsActionButton({
    required this.title,
    required this.iconUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.sightDetailsActionButtonWidth,
      height: AppConstants.sightDetailsActionButtonHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppConstants.sightDetailsActionButtonIconSize,
            height: AppConstants.sightDetailsActionButtonIconSize,
            child: SvgPicture.asset(
              iconUrl,
              color: AppColors.defaultIconColor,
            ),
          ),
          const SizedBox(width: AppConstants.defaultIconTextPadding),
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.sightDetailsButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
