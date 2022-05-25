import 'package:flutter/material.dart';
import 'package:places/ui/widget/common/custom_focus_manager.dart';

/// Виджет, который провайдит CustomFocusManager своим чайлдам - CustomTextField'ам
/// Является InheritedWidget'ом для "дешевого" поиска этого виджета в дереве
class FocusManagerHolder extends InheritedWidget {
  final _focusManager = CustomFocusManager();

  CustomFocusManager get focusManager => _focusManager;

  FocusManagerHolder({
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static FocusManagerHolder? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<FocusManagerHolder>();
  }
}
