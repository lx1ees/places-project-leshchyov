import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет IconButton с риппл эффектом в виде круга
class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color backgroundColor;

  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    this.padding,
    this.constraints,
    this.backgroundColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        constraints: constraints,
        padding:
            padding ?? const EdgeInsets.all(AppConstants.defaultPaddingX0_5),
      ),
    );
  }
}
