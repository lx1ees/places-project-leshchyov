import 'package:flutter/material.dart';

/// Класс, который держит ссылки на фокус ноды и осуществляет последовательное
/// изменение фокуса на последующий зарегистрированный FocusNode в списке по запросу
class CustomFocusManager {
  final List<FocusNode> _focusNodes = [];

  void registerFocusNode(FocusNode focusNode) {
    if (!_focusNodes.contains(focusNode)) {
      _focusNodes.add(focusNode);
    }
  }

  void unregisterFocusNode(FocusNode focusNode) {
    _focusNodes.remove(focusNode);
  }

  void requestNextFocus(FocusNode focusNode) {
    final currentIndex = _focusNodes.indexWhere(
      (curFocusNode) => curFocusNode.hashCode == focusNode.hashCode,
    );
    if (currentIndex != -1) {
      (currentIndex < _focusNodes.length - 1
              ? _focusNodes[currentIndex + 1]
              : _focusNodes.last)
          .requestFocus();
    }
  }
}
