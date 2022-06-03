import 'package:flutter/material.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:provider/provider.dart';

/// Фабрика для [T] - класса-обертки с зависимостями
typedef ScopeFactory<T> = T Function();

/// Обертка над виджетом с предоставлением класса с зависимости вниз по дереву
class DiScope<T extends IAppScope> extends StatefulWidget {
  final ScopeFactory<T> factory;

  final Widget child;

  const DiScope({
    required this.factory,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<DiScope> createState() => _DiScopeState<T>();
}

class _DiScopeState<T extends IAppScope> extends State<DiScope<T>> {
  late final T scope;

  @override
  void initState() {
    super.initState();
    scope = widget.factory();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: (_) => scope,
      child: widget.child,
      dispose: (_, T) => T.dispose(),
    );
  }
}
