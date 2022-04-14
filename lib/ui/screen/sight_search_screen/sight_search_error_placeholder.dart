import 'package:flutter/material.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/no_items_placeholder.dart';

/// Виджет-плейсхолдер в случае ошибки при поиске мест
class SightSearchErrorPlaceholder extends StatelessWidget {
  const SightSearchErrorPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NoItemsPlaceholder(
      title: AppStrings.error,
      subtitle: AppStrings.noSearchResultsPlaceholderHint,
    );
  }
}
