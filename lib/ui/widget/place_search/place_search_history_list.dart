import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widget/common/custom_divider.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';
import 'package:places/ui/widget/common/custom_text_button.dart';

/// Виджет, отображающий список историю поиска [history] с обработчикоми нажатия [onHistoryItemPressed],
/// удаления [onHistoryItemRemoved] и очистки всей истории [onHistoryCleared]
class PlaceSearchHistoryList extends StatelessWidget {
  final ScrollController scrollController;
  final ValueChanged<String> onHistoryItemPressed;
  final ValueChanged<String> onHistoryItemRemoved;
  final VoidCallback onHistoryCleared;
  final Iterable<String>? history;
  final ColorScheme colorScheme;

  const PlaceSearchHistoryList({
    required this.scrollController,
    required this.onHistoryItemPressed,
    required this.onHistoryItemRemoved,
    required this.onHistoryCleared,
    required this.history,
    required this.colorScheme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyList = history;

    if (historyList != null && historyList.isNotEmpty) {
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
                thumbVisibility: true,
                controller: scrollController,
                child: ListView.separated(
                  itemCount: historyList.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(
                        historyList.elementAt(index),
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
                        onPressed: () => onHistoryItemRemoved(
                          historyList.elementAt(index),
                        ),
                      ),
                      onTap: () =>
                          onHistoryItemPressed(historyList.elementAt(index)),
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
                onPressed: onHistoryCleared,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
