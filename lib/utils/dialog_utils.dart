import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

/// Обертки над диалогами
abstract class DialogUtils {
  /// Показывает snackbar с текстом [title] и кнопкой [actionTitle] с обработчиком
  /// [onPressedAction] (опционально)
  static void showSnackBar({
    required BuildContext context,
    required String title,
    String? actionTitle,
    VoidCallback? onPressedAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: AppTypography.smallTextStyle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        action: actionTitle != null && onPressedAction != null
            ? SnackBarAction(
                label: actionTitle,
                textColor: Theme.of(context).colorScheme.secondary,
                onPressed: onPressedAction,
              )
            : null,
      ),
    );
  }
}
