import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widget/custom_elevated_button.dart';

/// Виджет кнопки, которая располагается внизу экрана и предназначена для подтверждения
/// какого-то действия на экране.
/// [label] - текст кнопки
/// [onAddPressed] - обработчик нажатия на кнопку
class BottomScreenSubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback? onAddPressed;

  const BottomScreenSubmitButton({
    required this.label,
    required this.onAddPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.defaultPaddingX4,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      child: Center(
        child: CustomElevatedButton(
          label: label,
          onPressed: onAddPressed,
        ),
      ),
    );
  }
}
