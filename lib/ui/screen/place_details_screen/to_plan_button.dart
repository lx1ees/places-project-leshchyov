import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/widget/custom_text_icon_button.dart';

/// Кнопка на экране детальной информации для планирования посещения
class ToPlanButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ToPlanButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextIconButton(
      label: AppStrings.placeDetailsPlanActionButtonTitle,
      icon: SvgPicture.asset(
        AppAssets.calendarIcon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: onPressed,
    );
  }
}
