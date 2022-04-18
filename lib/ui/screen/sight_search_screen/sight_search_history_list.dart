import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/ui/widgets/custom_divider.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';
import 'package:places/ui/widgets/custom_text_button.dart';

/// Виджет, отображающий список историю поиска с обработчиком нажатия [onHistoryPressed]
/// [searchHistoryManager] - менеджер истории поиска
class SightSearchHistoryList extends StatefulWidget {
  final SearchHistoryManager searchHistoryManager;
  final ValueChanged<String> onHistoryPressed;

  const SightSearchHistoryList({
    required this.searchHistoryManager,
    required this.onHistoryPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<SightSearchHistoryList> createState() => _SightSearchHistoryListState();
}

class _SightSearchHistoryListState extends State<SightSearchHistoryList> {
  late final ScrollController _scrollController;
  late final SearchHistoryManager _searchHistoryManager;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchHistoryManager = widget.searchHistoryManager;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final history = _searchHistoryManager.load();
    final scrollPhysics = Platform.isAndroid
        ? const ClampingScrollPhysics()
        : const BouncingScrollPhysics();

    if (history.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: AppConstants.defaultPaddingX2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppConstants.defaultPadding),
              child: Text(
                AppStrings.historyTitle,
                style: AppTypography.superSmallTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            Flexible(
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: ListView.separated(
                  itemCount: history.length,
                  shrinkWrap: true,
                  physics: scrollPhysics,
                  controller: _scrollController,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(
                        history[index],
                        style: AppTypography.textRegularTextStyle.copyWith(
                          color: colorScheme.secondaryContainer,
                        ),
                      ),
                      trailing: CustomIconButton(
                        icon: SvgPicture.asset(
                          AppAssets.deleteIcon,
                          color: colorScheme.secondaryContainer,
                          width: AppConstants.defaultIcon4Size,
                          height: AppConstants.defaultIcon4Size,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _searchHistoryManager.remove(history[index]);
                          setState(() {});
                        },
                      ),
                      onTap: () => widget.onHistoryPressed(history[index]),
                    );
                  },
                  separatorBuilder: (_, __) => const CustomDivider(
                    hasIndent: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                AppConstants.defaultPadding,
              ),
              child: CustomTextButton(
                label: AppStrings.clearHistory,
                foregroundColor: colorScheme.secondary,
                onPressed: () {
                  _searchHistoryManager.clearHistory();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
