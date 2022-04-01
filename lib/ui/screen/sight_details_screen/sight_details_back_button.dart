import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет кнопки 'Назад' на экране детальной информации о достопримечательности
class SightDetailsBackButton extends StatelessWidget {
  const SightDetailsBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.sightDetailsGalleryBackButtonSize,
      height: AppConstants.sightDetailsGalleryBackButtonSize,
      decoration: const BoxDecoration(
        color: AppColors.sightButtonMockColor,
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.buttonBorderRadius),
        ),
      ),
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        size: AppConstants.defaultButtonIconSize,
      ),
    );
  }
}
