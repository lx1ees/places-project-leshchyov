import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/themes.dart';

/// Виджет индикатора боттомшита
class BottomSheetIndicator extends StatelessWidget {
  const BottomSheetIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppConstants.bottomSheetIndicatorWidth,
        height: AppConstants.bottomSheetIndicatorHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppConstants.indicatorBorderRadius,
          ),
          color: Theme.of(context).white,
        ),
      ),
    );
  }
}
