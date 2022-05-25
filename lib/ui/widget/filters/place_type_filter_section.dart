import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';
import 'package:places/ui/widget/filters/place_type_filter_item.dart';

typedef OnPlaceTypeFilterTapped = Function(
  PlaceTypeFilterEntity placeTypeFilterEntity,
  int index,
);

/// Виджет-секция фильтра по категориям
class PlaceTypeFilterSection extends StatelessWidget {
  final List<PlaceTypeFilterEntity> placeTypeFilters;
  final OnPlaceTypeFilterTapped onPlaceTypeFilterTapped;
  final bool isSmallScreen;

  const PlaceTypeFilterSection({
    required this.placeTypeFilters,
    required this.onPlaceTypeFilterTapped,
    this.isSmallScreen = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.placeTypeFiltersTitle,
          style: AppTypography.superSmallTextStyle.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.defaultPaddingX1_5,
          ),
          child: Center(
            child: isSmallScreen
                ? SizedBox(
                    height: AppConstants.placeTypeFilterHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: placeTypeFilters.length,
                      itemBuilder: (context, index) {
                        final placeTypeFilterEntity = placeTypeFilters[index];

                        return PlaceTypeFilterItem(
                          filterEntity: placeTypeFilterEntity,
                          onSelected: () => onPlaceTypeFilterTapped(
                            placeTypeFilterEntity,
                            index,
                          ),
                        );
                      },
                    ),
                  )
                : Wrap(
                    spacing: AppConstants.defaultButtonHorizontalPadding,
                    runSpacing: AppConstants.placeTypeFilterRunSpace,
                    children: placeTypeFilters
                        .mapIndexed(
                          (index, placeTypeFilterEntity) => PlaceTypeFilterItem(
                            filterEntity: placeTypeFilterEntity,
                            onSelected: () => onPlaceTypeFilterTapped(
                              placeTypeFilterEntity,
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
