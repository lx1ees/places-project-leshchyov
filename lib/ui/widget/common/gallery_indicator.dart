import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет индикатора в галлереи фото
/// [width] - фиксированная ширина индикатора
class GalleryIndicator extends StatelessWidget {
  final double width;

  const GalleryIndicator({
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.indicatorHeight,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(AppConstants.indicatorBorderRadius),
      ),
    );
  }
}
