import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/res/themes.dart';

/// Виджет для отображения подложки карточки при удалении через свайп
class PlaceCardDismissBackground extends StatelessWidget {
  const PlaceCardDismissBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: AspectRatio(
        aspectRatio: AppConstants.cardAspectRatio,
        child: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: colorScheme.error,
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.bucketIcon,
                color: Theme.of(context).white,
              ),
              const SizedBox(height: AppConstants.defaultPaddingX0_5),
              Text(
                AppStrings.delete,
                style: AppTypography.superSmallBoldTextStyle.copyWith(
                  color: Theme.of(context).white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
