import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/sight.dart';
import 'package:places/utils/string_utils.dart';

/// Виджет плитки найденного места для окна поиска мест
/// [searchString] - искомая строка (нужна для выделения в наименовании места)
/// [sight] - найденное место
/// [onTap] - обработчик нажатия на плитку
class SightSearchTile extends StatelessWidget {
  final String searchString;
  final Sight sight;
  final VoidCallback? onTap;

  const SightSearchTile({
    required this.sight,
    required this.searchString,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.defaultPaddingX0_75,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppConstants.cardBorderRadius),
              ),
              child: SizedBox(
                width: AppConstants.searchTileImageSize,
                height: AppConstants.searchTileImageSize,
                child: Image.network(
                  sight.url,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: AppConstants.defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: StringUtils.highlightPhrases(
                        source: sight.name,
                        toHighlight: searchString,
                        highlightColor: colorScheme.primary,
                      ),
                      style: AppTypography.textRegularTextStyle.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.defaultPaddingX0_5),
                  Text(
                    sight.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.smallTextStyle.copyWith(
                      color: colorScheme.secondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
