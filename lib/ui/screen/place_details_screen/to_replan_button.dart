import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widget/custom_text_icon_button.dart';
import 'package:places/utils/extensions.dart';

/// Кнопка на экране детальной информации для перепланирования посещения
class ToRePlanButton extends StatelessWidget {
  final DateTime currentPlanDate;
  final VoidCallback onPressed;

  const ToRePlanButton({
    required this.onPressed,
    required this.currentPlanDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextIconButton(
      label: currentPlanDate.toReVisitString(),
      labelStyle: AppTypography.smallBoldTextStyle.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
      icon: SvgPicture.asset(
        AppAssets.calendarFullIcon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: onPressed,
    );
  }
}