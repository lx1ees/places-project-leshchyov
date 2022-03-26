import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет кнопки построения маршрута
class SightDetailsRouteButton extends StatelessWidget {
  const SightDetailsRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sightButton2MockColor,
      width: double.infinity,
      height: AppConstants.sightDetailsRouteButtonHeight,
    );
  }
}
