import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/filters_manager.dart';
import 'package:places/utils/extensions.dart';

/// Виджет-секция фильтра по дистанции
class DistanceFilterSection extends StatelessWidget {
  final ValueChanged<RangeValues> onDistanceChanged;
  final ValueChanged<RangeValues> onDistanceChangeEnded;
  final FiltersManager filtersManager;

  const DistanceFilterSection({
    required this.filtersManager,
    required this.onDistanceChanged,
    required this.onDistanceChangeEnded,
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
                _distanceTitleRepresentation(
                  filtersManager.distanceLeftThreshold,
                  filtersManager.distanceRightThreshold,
                ),
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
                filtersManager.distanceLeftThreshold,
                filtersManager.distanceRightThreshold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Формирование строки с информацией о выбранной дистанции
  String _distanceTitleRepresentation(
    double leftThreshold,
    double rightThreshold,
  ) {
    const oneKmInMeters = 1000;
    String _rightMeasure(double value, {bool addPostfix = false}) {
      if (value < oneKmInMeters) {
        return '${value.round()}${addPostfix ? ' ${AppStrings.meter}' : ''}';
      }
      final km = (value / oneKmInMeters).toPrecision(1);

      return '${km.isWhole ? km.round() : km}${addPostfix ? ' ${AppStrings.km}' : ''}';
    }

    if (leftThreshold < oneKmInMeters && rightThreshold < oneKmInMeters) {
      return '${AppStrings.prepositionFrom} ${_rightMeasure(leftThreshold)} ${AppStrings.prepositionTo} ${_rightMeasure(
        rightThreshold,
        addPostfix: true,
      )}';
    }
    if (leftThreshold > oneKmInMeters && rightThreshold > oneKmInMeters) {
      return '${AppStrings.prepositionFrom} ${_rightMeasure(leftThreshold)} ${AppStrings.prepositionTo} ${_rightMeasure(
        rightThreshold,
        addPostfix: true,
      )}';
    }

    return '${AppStrings.prepositionFrom} ${_rightMeasure(
      leftThreshold,
      addPostfix: true,
    )} ${AppStrings.prepositionTo} ${_rightMeasure(
      rightThreshold,
      addPostfix: true,
    )}';
  }
}
