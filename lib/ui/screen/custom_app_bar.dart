import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Кастомный AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.appbarHeight);

  const CustomAppBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
