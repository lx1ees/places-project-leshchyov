import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place_type.dart';

/// Виджет секции выбора категори [selectedPlaceType] на экране создания нового места
class SelectPlaceTypeSection extends StatelessWidget {
  final PlaceType? selectedPlaceType;
  final ValueChanged<PlaceType?> onSelectPlaceTypePressed;

  const SelectPlaceTypeSection({
    required this.onSelectPlaceTypePressed,
    this.selectedPlaceType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaceTypeSelected = selectedPlaceType != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: Text(
            AppStrings.placeTypeTitle.toUpperCase(),
            style: AppTypography.superSmallTextStyle.copyWith(
              color: colorScheme.background,
            ),
          ),
        ),
        ListTile(
          title: Text(
            isPlaceTypeSelected
                ? selectedPlaceType?.name ?? ''
                : AppStrings.placeTypeNotSelected,
            style: AppTypography.textRegularTextStyle.copyWith(
              color: isPlaceTypeSelected
                  ? colorScheme.primary
                  : colorScheme.secondaryContainer,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(AppConstants.infoIconPadding),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: colorScheme.primary,
              size: AppConstants.defaultMiniIconSize,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          onTap: () => onSelectPlaceTypePressed(selectedPlaceType),
        ),
      ],
    );
  }
}
