import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/no_items_placeholder.dart';

/// Виджет-плейсхолдер в случае отсутствии результатов при поиске мест
class SightSearchNoResultsPlaceholder extends StatelessWidget {
  const SightSearchNoResultsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NoItemsPlaceholder(
      iconPath: AppAssets.searchIcon,
      title: AppStrings.noSearchResultsPlaceholder,
      subtitle: AppStrings.noSearchResultsPlaceholderHint,
    );
  }
}
