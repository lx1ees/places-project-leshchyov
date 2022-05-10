import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет кастомной кнопки TextButton с острыми углами, иконкой [icon],
/// заголовком [label] и обработчиком нажатия [onPressed], [labelStyle] -
/// кастомный стиль текста кнопки
class CustomTextIconButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final TextStyle? labelStyle;
  final VoidCallback? onPressed;

  const CustomTextIconButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.labelStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultButtonHorizontalPadding,
        ),
        shadowColor: Colors.transparent,
        minimumSize: const Size(0, AppConstants.defaultTextButtonHeight),
        shape: const RoundedRectangleBorder(),
      ),
      label: Text(
        label,
        style: labelStyle ??
            AppTypography.smallTextStyle.copyWith(
              color: colorScheme.onPrimary,
            ),
      ),
      icon: icon,
    );
  }
}
