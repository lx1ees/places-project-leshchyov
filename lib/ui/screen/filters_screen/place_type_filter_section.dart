import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/filters_manager.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';
import 'package:places/ui/screen/filters_screen/place_type_filter_item.dart';

typedef OnPlaceTypeFilterTapped = Function(
  PlaceTypeFilterEntity placeTypeFilterEntity,
  int index,
);

/// Виджет-секция фильтра по категориям
class PlaceTypeFilterSection extends StatefulWidget {
  final FiltersManager filtersManager;
  final OnPlaceTypeFilterTapped onPlaceTypeFilterTapped;

  const PlaceTypeFilterSection({
    required this.filtersManager,
    required this.onPlaceTypeFilterTapped,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceTypeFilterSection> createState() => _PlaceTypeFilterSectionState();
}

class _PlaceTypeFilterSectionState extends State<PlaceTypeFilterSection> {
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
            child: _isSmallScreen
                ? SizedBox(
                    height: AppConstants.placeTypeFilterHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.filtersManager.placeTypeFilters.length,
                      itemBuilder: (context, index) {
                        final placeTypeFilterEntity =
                            widget.filtersManager.placeTypeFilters[index];

                        return PlaceTypeFilterItem(
                          filterEntity: placeTypeFilterEntity,
                          onSelected: () => widget.onPlaceTypeFilterTapped(
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
                    children: widget.filtersManager.placeTypeFilters
                        .mapIndexed(
                          (index, placeTypeFilterEntity) => PlaceTypeFilterItem(
                            filterEntity: placeTypeFilterEntity,
                            onSelected: () => widget.onPlaceTypeFilterTapped(
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
