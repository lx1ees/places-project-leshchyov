import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_typography.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTypography.appBarTitleTextStyle,
        children: [
          TextSpan(
            text: 'С',
            style: AppTypography.appBarTitleTextStyle.copyWith(
              color: AppColors.appBarTitleFirstLetterOneColor,
            ),
          ),
          const TextSpan(
            text: 'писок\n',
          ),
          TextSpan(
            text: 'и',
            style: AppTypography.appBarTitleTextStyle.copyWith(
              color: AppColors.appBarTitleFirstLetterTwoColor,
            ),
          ),
          const TextSpan(
            text: 'нтересных мест',
          ),
        ],
      ),
    );
  }
}
