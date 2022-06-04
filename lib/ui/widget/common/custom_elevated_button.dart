import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/res/themes.dart';

/// Виджет кастомного ElevatedButton с опциональным заголовком [label],
/// опциональной иконкой [icon], обработчиком нажатия [onPressed] и
/// флагом [shrink], который растягивает кнопку на всю доступную ей ширину в
/// случае, если он в состоянии true, и ужимает кнопку до минимальной
/// доступной ширины, если он в состоянии false.
/// [isCircular] - признак, является ли кнопка круглой
/// ВАЖНО: в виджет как минимум должен быть передан [label] или [icon]
class CustomElevatedButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool shrink;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isCircular;
  final bool withElevation;

  const CustomElevatedButton({
    this.onPressed,
    this.label,
    this.icon,
    this.shrink = true,
    this.backgroundColor,
    this.textColor,
    this.isCircular = false,
    this.withElevation = false,
    Key? key,
  })  : assert(label != null || icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: withElevation ? 4.0 : 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultButtonHorizontalPadding,
        ),
        shadowColor: withElevation ? null : Colors.transparent,
        minimumSize: Size(
          shrink ? double.infinity : 0,
          AppConstants.defaultElevatedButtonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              isCircular ? 1000 : AppConstants.button2BorderRadius,
            ),
          ),
        ),
        primary: backgroundColor ?? Theme.of(context).colorScheme.secondary,
        textStyle: AppTypography.buttonTextStyle.copyWith(
          color: textColor ?? Theme.of(context).white,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const SizedBox(),
          Visibility(
            visible: icon != null && label != null,
            child: const SizedBox(width: AppConstants.defaultPaddingX0_5),
          ),
          if (label != null)
            Text(
              label?.toUpperCase() ?? '',
              style: AppTypography.buttonTextStyle.copyWith(
                color: textColor ?? Theme.of(context).white,
              ),
            ),
        ],
      ),
    );
  }
}
