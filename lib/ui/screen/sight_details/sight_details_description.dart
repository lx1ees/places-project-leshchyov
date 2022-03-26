import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения полного описания (деталей) [description] достопримечательности
class SightDetailsDescription extends StatelessWidget {
  final String description;

  const SightDetailsDescription({
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: AppTypography.sightDetailsDescriptionTextStyle,
    );
  }
}
