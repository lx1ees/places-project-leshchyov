import 'package:flutter/material.dart';

/// Вспомогательные методы для UI
abstract class UiUtils {
  /// Возвращает правильное значение типа [T] в зависимости от текущей темы
  static T getValueByTheme<T extends Object>({
    required BuildContext context,
    required T defaultValue,
    required T darkValue,
  }) {
    if (Theme.of(context).brightness == Brightness.light) return defaultValue;

    return darkValue;
  }
}
