import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/common/custom_divider.dart';
import 'package:places/ui/widget/place_search/place_search_tile.dart';

/// Виджет, отображающий список найденных мест [results] по запросу [searchString]
/// с обработчиком нажатия [onPlacePressed]
class PlaceSearchResultsList extends StatelessWidget {
  final String searchString;
  final List<Place> results;
  final ValueChanged<Place> onPlacePressed;

  const PlaceSearchResultsList({
    Key? key,
    required this.searchString,
    required this.results,
    required this.onPlacePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.defaultPaddingX2),
      child: ListView.separated(
        itemCount: results.length,
        itemBuilder: (_, index) {
          return PlaceSearchTile(
            place: results[index],
            searchString: searchString,
            onTap: () => onPlacePressed(results[index]),
          );
        },
        separatorBuilder: (_, __) => const CustomDivider(
          hasIndent: true,
          leftIndent: AppConstants.separatorStartIndent,
        ),
      ),
    );
  }
}
