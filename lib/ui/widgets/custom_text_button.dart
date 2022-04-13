import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет кастомной кнопки TextButton без сплеша,
/// с заголовком [label], цветом заголовка [foregroundColor]
/// и обработчиком нажатия [onPressed]
class CustomTextButton extends StatelessWidget {
  final String label;
  final Color? foregroundColor;
  final VoidCallback? onPressed;

  const CustomTextButton({
    required this.label,
    this.foregroundColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
          (states) {
            return EdgeInsets.zero;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            final color =
                foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
            if (states.contains(MaterialState.hovered)) {
              return color.withOpacity(0.2);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return color.withOpacity(0.4);
            }

            return color;
          },
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (states) {
            return AppTypography.textTextStyle;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            return Colors.transparent;
          },
        ),
      ),
      child: Text(label),
    );
  }
}
