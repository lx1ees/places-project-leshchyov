import 'package:flutter/material.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/no_items_placeholder.dart';

/// Виджет-плейсхолдер в случае ошибки при поиске мест
class PlaceSearchErrorPlaceholder extends StatelessWidget {
  const PlaceSearchErrorPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NoItemsPlaceholder(
      title: AppStrings.error,
      subtitle: AppStrings.noSearchResultsPlaceholderHint,
    );
  }
}
