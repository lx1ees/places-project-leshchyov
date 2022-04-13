import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/res/themes.dart';

/// Кастомный виджет FAB с градиентной заливкой
class GradientExtendedFab extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Color startColor;
  final Color endColor;
  final VoidCallback? onPressed;

  const GradientExtendedFab({
    required this.label,
    required this.startColor,
    required this.endColor,
    this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
          ),
        ],
        borderRadius: BorderRadius.circular(AppConstants.button3BorderRadius),
        gradient: LinearGradient(
          colors: [
            startColor,
            endColor,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          transform: const GradientRotation(4.5),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: startColor.withOpacity(0.3),
        ),
        child: FloatingActionButton.extended(
          onPressed: onPressed,
          elevation: 0,
          highlightElevation: 0,
          backgroundColor: Colors.transparent,
          icon: icon,
          extendedPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.extendedFabHorizontalPadding,
          ),
          label: Text(
            label,
            style: AppTypography.buttonTextStyle.copyWith(
              color: Theme.of(context).white,
            ),
          ),
        ),
      ),
    );
  }
}
