import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет для отображения галереи достопримечательности
class SightDetailsImageGallery extends StatelessWidget {
  const SightDetailsImageGallery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppConstants.sightDetailsGalleryHeight,
      color: AppColors.sightImageMockColor,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: AppConstants.sightDetailsGalleryBackButtonSize,
          height: AppConstants.sightDetailsGalleryBackButtonSize,
          color: AppColors.sightButtonMockColor,
          margin: const EdgeInsets.only(
            left: AppConstants.defaultPadding,
            top: AppConstants.defaultPaddingX2,
          ),
        ),
      ),
    );
  }
}
