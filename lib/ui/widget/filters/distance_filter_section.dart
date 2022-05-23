import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/filters_manager.dart';

/// Виджет-секция фильтра по дистанции
class DistanceFilterSection extends StatelessWidget {
  final ValueChanged<RangeValues> onDistanceChanged;
  final ValueChanged<RangeValues> onDistanceChangeEnded;
  final DistanceFilter distanceFilter;
  final String distanceTitleRepresentation;

  const DistanceFilterSection({
    required this.distanceFilter,
    required this.onDistanceChanged,
    required this.onDistanceChangeEnded,
    required this.distanceTitleRepresentation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.defaultPaddingX0_25,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.distanceFilterTitle,
                style: AppTypography.textRegularTextStyle,
              ),
              Text(
                distanceTitleRepresentation,
                style: AppTypography.textRegularTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.defaultPaddingX0_25,
            ),
            child: RangeSlider(
              min: AppConstants.distanceFilterMinValue,
              max: AppConstants.distanceFilterMaxValue,
              onChanged: onDistanceChanged,
              onChangeEnd: onDistanceChangeEnded,
              values: RangeValues(
                distanceFilter.distanceLeftThreshold,
                distanceFilter.distanceRightThreshold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
