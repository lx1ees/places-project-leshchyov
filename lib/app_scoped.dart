import 'package:flutter/material.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/widget/common/di_scope.dart';

/// Класс обертка над App с DI
class AppScoped extends StatefulWidget {
  final Widget child;

  const AppScoped({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<AppScoped> createState() => _AppScopedState();
}

class _AppScopedState extends State<AppScoped> {
  late final IAppScope _scope;

  @override
  void initState() {
    super.initState();
    _scope = AppScope();
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      factory: () => _scope,
      child: widget.child,
    );
  }
}
