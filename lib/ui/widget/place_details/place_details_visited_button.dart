import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';

/// Кнопка пройденного маршрута на экране детальной информации
class PlaceDetailsVisitedButton extends StatelessWidget {
  final VoidCallback onRoutePressed;

  const PlaceDetailsVisitedButton({
    required this.onRoutePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CustomElevatedButton(
            label: AppStrings.placeDetailsRouteFinishedButtonTitle,
            textColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).primaryColorLight,
            icon: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const SizedBox(
          width: AppConstants.defaultPadding,
        ),
        CustomElevatedButton(
          onPressed: onRoutePressed,
          shrink: false,
          icon: SvgPicture.asset(
            AppAssets.goIcon,
            // color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
