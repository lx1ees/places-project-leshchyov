import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Обертка над стандартным дивайдером
class CustomDivider extends StatelessWidget {
  final bool hasIndent;
  final double? leftIndent;
  final double? rightIndent;

  const CustomDivider({
    this.hasIndent = false,
    this.leftIndent,
    this.rightIndent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      indent: hasIndent ? leftIndent ?? AppConstants.defaultPadding : 0,
      endIndent: hasIndent ? rightIndent ?? AppConstants.defaultPadding : 0,
      color: Theme.of(context).colorScheme.background,
    );
  }
}
