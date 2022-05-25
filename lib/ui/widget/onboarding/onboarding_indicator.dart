import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет индикатора цвета [color] и ширины [width] в окне онбординга
class OnboardingIndicator extends StatelessWidget {
  final Color color;
  final double width;

  const OnboardingIndicator({
    required this.color,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          AppConstants.indicatorBorderRadius,
        ),
      ),
      margin: const EdgeInsets.only(
        right: AppConstants.defaultPaddingX0_5,
      ),
      height: AppConstants.indicatorHeight,
      width: width,
    );
  }
}
