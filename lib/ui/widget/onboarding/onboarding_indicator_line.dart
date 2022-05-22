import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widget/onboarding/onboarding_indicator.dart';

/// Виджет полоски индикатора онбординга
/// [currentPage] - индекс текущей страницы
/// [numberOfSegments] - число сегменов линии индикатора
class OnboardingIndicatorLine extends StatelessWidget {
  final int currentPage;
  final int numberOfSegments;

  const OnboardingIndicatorLine({
    required this.currentPage,
    required this.numberOfSegments,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfSegments, (index) {
        final isActive = index == currentPage;
        final width = isActive
            ? AppConstants.onboardingActiveIndicatorWidth
            : AppConstants.indicatorHeight;
        final color = isActive ? colorScheme.secondary : colorScheme.background;

        return OnboardingIndicator(
          color: color,
          width: width,
        );
      }),
    );
  }
}
