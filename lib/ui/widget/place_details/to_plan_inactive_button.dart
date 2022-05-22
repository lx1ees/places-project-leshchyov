import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widget/common/custom_text_icon_button.dart';

/// Неактивая кнопка на экране детальной информации для планирования посещения
class ToPlanInactiveButton extends StatelessWidget {
  const ToPlanInactiveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextIconButton(
      label: AppStrings.placeDetailsPlanActionButtonTitle,
      labelStyle: AppTypography.smallTextStyle.copyWith(
        color: Theme.of(context).colorScheme.background,
      ),
      icon: SvgPicture.asset(
        AppAssets.calendarIcon,
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
