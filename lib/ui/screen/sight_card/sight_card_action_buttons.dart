import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';

/// Виджет кнопок действий на карточке достопримечательности, для каждого типа карточки свой
abstract class SightCardActionButtons extends StatelessWidget {
  const SightCardActionButtons({Key? key}) : super(key: key);
}

class SightToVisitCardActionButtons extends SightCardActionButtons {
  final VoidCallback onDeletePressed;
  final VoidCallback onPlanPressed;

  const SightToVisitCardActionButtons({
    required this.onDeletePressed,
    required this.onPlanPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onPressed: onPlanPressed,
          icon: SvgPicture.asset(
            AppAssets.calendarIconAssetPath,
            height: AppConstants.defaultIconSize,
            width: AppConstants.defaultIconSize,
            color: Theme.of(context).white,
          ),
        ),
        CustomIconButton(
          onPressed: onDeletePressed,
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).white,
          ),
        ),
      ],
    );
  }
}

class SightVisitedCardActionButtons extends SightCardActionButtons {
  final VoidCallback onDeletePressed;
  final VoidCallback onSharePressed;

  const SightVisitedCardActionButtons({
    required this.onDeletePressed,
    required this.onSharePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onPressed: onSharePressed,
          icon: SvgPicture.asset(
            AppAssets.shareIconAssetPath,
            height: AppConstants.defaultIconSize,
            width: AppConstants.defaultIconSize,
            color: Theme.of(context).white,
          ),
        ),
        CustomIconButton(
          onPressed: onDeletePressed,
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).white,
          ),
        ),
      ],
    );
  }
}

class SightViewCardActionButtons extends SightCardActionButtons {
  final VoidCallback onFavoritePressed;

  const SightViewCardActionButtons({
    required this.onFavoritePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onFavoritePressed,
      icon: SvgPicture.asset(
        AppAssets.heartIconAssetPath,
        height: AppConstants.defaultIconSize,
        width: AppConstants.defaultIconSize,
        color: Theme.of(context).white,
      ),
    );
  }
}
