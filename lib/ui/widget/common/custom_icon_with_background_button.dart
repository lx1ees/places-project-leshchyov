import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';

/// Виджет IconButton с риппл эффектом в виде круга и бэкграундом
class CustomIconWithBackgroundButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const CustomIconWithBackgroundButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: AppConstants.placeDetailsGalleryBackButtonSize,
          height: AppConstants.placeDetailsGalleryBackButtonSize,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppConstants.buttonBorderRadius),
            ),
          ),
        ),
        CustomIconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ],
    );
  }
}
