import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/res/themes.dart';

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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppConstants.button2BorderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.goIconAssetPath),
          const SizedBox(width: 10),
          Text(
            AppStrings.sightDetailsRouteButtonTitle.toUpperCase(),
            style: AppTypography.buttonTextStyle.copyWith(
              color: Theme.of(context).white,
            ),
          ),
        ],
      ),
    );
  }
}
