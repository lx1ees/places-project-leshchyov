import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/custom_icon_button.dart';

/// Виджет кнопок действий на карточке достопримечательности, для каждого типа карточки свой
abstract class PlaceCardActionButtons extends StatelessWidget {
  const PlaceCardActionButtons({Key? key}) : super(key: key);
}

class PlaceToVisitCardActionButtons extends PlaceCardActionButtons {
  final VoidCallback onDeletePressed;
  final VoidCallback onPlanPressed;

  const PlaceToVisitCardActionButtons({
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
            AppAssets.calendarIcon,
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

class PlaceVisitedCardActionButtons extends PlaceCardActionButtons {
  final VoidCallback onDeletePressed;
  final VoidCallback onSharePressed;

  const PlaceVisitedCardActionButtons({
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
            AppAssets.shareIcon,
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

class PlaceViewCardActionButtons extends PlaceCardActionButtons {
  final VoidCallback onFavoritePressed;

  const PlaceViewCardActionButtons({
    required this.onFavoritePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onFavoritePressed,
      icon: SvgPicture.asset(
        AppAssets.heartIcon,
        height: AppConstants.defaultIconSize,
        width: AppConstants.defaultIconSize,
        color: Theme.of(context).white,
      ),
    );
  }
}
