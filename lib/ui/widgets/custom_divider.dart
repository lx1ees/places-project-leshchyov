import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Обертка над стандартным дивайдером
class CustomDivider extends StatelessWidget {
  final bool hasIndent;

  const CustomDivider({
    this.hasIndent = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      indent: hasIndent ? AppConstants.defaultPadding : 0,
      endIndent: hasIndent ? AppConstants.defaultPadding : 0,
      color: Theme.of(context).colorScheme.background,
    );
  }
}
