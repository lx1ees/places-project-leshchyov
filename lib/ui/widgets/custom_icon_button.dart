import 'package:flutter/material.dart';

/// Виджет IconButton с риппл эффектом в виде круга
class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final EdgeInsets? padding;

  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        padding: padding ?? const EdgeInsets.all(8),
      ),
    );
  }
}
