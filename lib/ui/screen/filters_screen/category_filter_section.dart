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
class CategoryFilterSection extends StatefulWidget {
  final FiltersManager filtersManager;
  final OnCategoryFilterTapped onCategoryFilterTapped;

  const CategoryFilterSection({
    required this.filtersManager,
    required this.onCategoryFilterTapped,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryFilterSection> createState() => _CategoryFilterSectionState();
}

class _CategoryFilterSectionState extends State<CategoryFilterSection> {
  bool _isSmallScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    setState(() {
      _isSmallScreen = MediaQuery.of(context).size.width * pixelRatio <=
              AppConstants.smallScreenWidth &&
          MediaQuery.of(context).size.height * pixelRatio <=
              AppConstants.smallScreenHeight;
    });
  }

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
            child: _isSmallScreen
                ? SizedBox(
                    height: AppConstants.categoryFilterHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.filtersManager.categoryFilters.length,
                      itemBuilder: (context, index) {
                        final categoryFilterEntity =
                            widget.filtersManager.categoryFilters[index];

                        return CategoryFilterItem(
                          filterEntity: categoryFilterEntity,
                          onSelected: () => widget.onCategoryFilterTapped(
                            categoryFilterEntity,
                            index,
                          ),
                        );
                      },
                    ),
                  )
                : Wrap(
                    spacing: AppConstants.defaultButtonHorizontalPadding,
                    runSpacing: AppConstants.categoryFilterRunSpace,
                    children: widget.filtersManager.categoryFilters
                        .mapIndexed(
                          (index, categoryFilterEntity) => CategoryFilterItem(
                            filterEntity: categoryFilterEntity,
                            onSelected: () => widget.onCategoryFilterTapped(
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
