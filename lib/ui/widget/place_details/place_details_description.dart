import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения полного описания (деталей) [description] достопримечательности
class PlaceDetailsDescription extends StatelessWidget {
  final String description;

  const PlaceDetailsDescription({
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: AppTypography.smallTextStyle.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
