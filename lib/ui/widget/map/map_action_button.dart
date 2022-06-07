import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';

/// Кнопка действия на карте
class MapActionButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;

  const MapActionButton({
    required this.iconPath,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onPressed,
      shrink: false,
      withElevation: true,
      isCircular: true,
      icon: SvgPicture.asset(
        iconPath,
        color: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.onBackground,
    );
  }
}
