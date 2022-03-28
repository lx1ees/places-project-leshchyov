import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет кнопки построения маршрута
class SightDetailsRouteButton extends StatelessWidget {
  const SightDetailsRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppConstants.sightDetailsRouteButtonHeight,
      decoration: const BoxDecoration(
        color: AppColors.sightButton2MockColor,
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.button2BorderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppConstants.goIconAssetPath),
          const SizedBox(width: 10),
          Text(
            AppStrings.sightDetailsRouteButtonTitle.toUpperCase(),
            style: AppTypography.sightDetailsRouteButtonTextStyle,
          ),
        ],
      ),
    );
  }
}
