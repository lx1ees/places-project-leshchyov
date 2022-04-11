import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/ui/screen/filters_screen/category_filter_item.dart';

typedef OnCategoryFilterTapped = Function(
  CategoryFilterEntity categoryFilterEntity,
  int index,
);

/// Виджет-секция фильтра по категориям
class CategoryFilterSection extends StatelessWidget {
  final FiltersManager filtersManager;
  final OnCategoryFilterTapped onCategoryFilterTapped;

  const CategoryFilterSection({
    required this.filtersManager,
    required this.onCategoryFilterTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.categoryFiltersTitle,
          style: AppTypography.superSmallTextStyle.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.defaultPaddingX1_5,
          ),
          child: Center(
            child: Wrap(
              spacing: AppConstants.defaultButtonHorizontalPadding,
              runSpacing: AppConstants.categoryFilterRunSpace,
              children: filtersManager.categoryFilters
                  .mapIndexed(
                    (index, categoryFilterEntity) => CategoryFilterItem(
                      filterEntity: categoryFilterEntity,
                      onSelected: () => onCategoryFilterTapped(
                        categoryFilterEntity,
                        index,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
