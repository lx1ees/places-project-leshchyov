import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет секции выбора категори [selectedCategoryName] на экране создания нового места
class SelectCategorySection extends StatelessWidget {
  final String? selectedCategoryName;
  final VoidCallback onSelectCategoryPressed;

  const SelectCategorySection({
    required this.onSelectCategoryPressed,
    this.selectedCategoryName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCategorySelected = selectedCategoryName != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: Text(
            AppStrings.categoryTitle.toUpperCase(),
            style: AppTypography.superSmallTextStyle.copyWith(
              color: colorScheme.background,
            ),
          ),
        ),
        ListTile(
          title: Text(
            isCategorySelected
                ? selectedCategoryName ?? ''
                : AppStrings.categoryNotSelected,
            style: AppTypography.textRegularTextStyle.copyWith(
              color: isCategorySelected
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
          onTap: onSelectCategoryPressed,
        ),
      ],
    );
  }
}
