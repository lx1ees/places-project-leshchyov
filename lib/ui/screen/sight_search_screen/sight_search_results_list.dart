import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_tile.dart';
import 'package:places/ui/widgets/custom_divider.dart';

/// Виджет, отображающий список найденных мест [results] по запросу [searchString]
/// с обработчиком нажатия [onSightPressed]
class SightSearchResultsList extends StatelessWidget {
  final String searchString;
  final List<Sight> results;
  final ValueChanged<Sight> onSightPressed;

  const SightSearchResultsList({
    Key? key,
    required this.searchString,
    required this.results,
    required this.onSightPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollPhysics = Platform.isAndroid
        ? const ClampingScrollPhysics()
        : const BouncingScrollPhysics();

    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.defaultPaddingX2),
      child: ListView.separated(
        itemCount: results.length,
        physics: scrollPhysics,
        itemBuilder: (_, index) {
          return SightSearchTile(
            sight: results[index],
            searchString: searchString,
            onTap: () => onSightPressed(results[index]),
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
