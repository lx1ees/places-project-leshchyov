import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widget/common/custom_tab.dart';

/// Виджет кастомного таббара с подложкой и набором табов с текстом [labelTabs]
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> labelTabs;

  @override
  Size get preferredSize =>
      const Size.fromHeight(AppConstants.defaultTabHeight);

  const CustomTabBar({
    required this.controller,
    required this.labelTabs,
    Key? key,
  })  : assert(controller.length == labelTabs.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.defaultTabVerticalPadding,
      ),
      child: Stack(
        children: [
          Container(
            height: AppConstants.defaultTabHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultTabBorderRadius),
            ),
          ),
          TabBar(
            controller: controller,
            indicator: Theme.of(context).tabBarTheme.indicator,
            indicatorWeight: 0,
            labelPadding: EdgeInsets.zero,
            tabs: labelTabs
                .mapIndexed(
                  (index, label) => CustomTab(
                    controller: controller,
                    index: index,
                    label: label,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
