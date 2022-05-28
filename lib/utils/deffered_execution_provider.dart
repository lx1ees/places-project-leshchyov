import 'dart:async';

import 'package:flutter/material.dart';

/// Миксин с методами для отложенного выполнения действий с возможностью отменить
mixin DefferedExecutionProvider {
  Timer? _timer;

  /// Метод отложенного выполнения [onExecute] через [delay] секунд
  void deffered(VoidCallback onExecute, {int delay = 1}) {
    _timer = Timer(Duration(seconds: delay), onExecute);
  }

  /// Метод отмены отложенного выполнения
  void cancelDeffered() {
    if (_timer != null && (_timer?.isActive ?? false)) {
      _timer?.cancel();
    }
  }
}
