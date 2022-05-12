import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/widget/custom_text_icon_button.dart';

/// Кнопка на экране детальной информации для шеринга
class ToShareButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ToShareButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextIconButton(
      label: AppStrings.placeDetailsShareActionButtonTitle,
      icon: SvgPicture.asset(
        AppAssets.shareIcon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: onPressed,
    );
  }
}
