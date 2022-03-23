import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

class SightCardBottom extends StatelessWidget {
  final String name;
  final String details;

  const SightCardBottom({
    required this.name,
    required this.details,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sightCardNameTextStyle,
          ),
          Text(
            details,
            style: AppTypography.sightCardDetailsTextStyle,
          ),
        ],
      ),
    );
  }
}
