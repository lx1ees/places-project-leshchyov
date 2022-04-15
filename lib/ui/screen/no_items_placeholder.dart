import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет плейсхолдера в любом списке
/// Представляет собой текст [title], выведенный на экран.
/// Опционально может быть выведено изображение по пути из ресурсов [iconPath]
/// и подзаголовок [subtitle]
class NoItemsPlaceholder extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String? subtitle;
  final bool isBigIcon;

  const NoItemsPlaceholder({
    required this.title,
    this.subtitle,
    this.iconPath,
    this.isBigIcon = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIconPathProvided =
        iconPath != null && (iconPath?.isNotEmpty ?? false);
    final isSubtitleProvided =
        subtitle != null && (subtitle?.isNotEmpty ?? false);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: isIconPathProvided,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: AppConstants.defaultPaddingX1_5),
            child: SvgPicture.asset(
              iconPath ?? '',
              color: colorScheme.background,
              width: isBigIcon
                  ? AppConstants.defaultIconBigSize
                  : AppConstants.defaultIconSize,
            ),
          ),
        ),
        Text(
          title,
          style: AppTypography.subtitleTextStyle.copyWith(
            color: colorScheme.background,
          ),
        ),
        Visibility(
          visible: isSubtitleProvided,
          child: Padding(
            padding:
                const EdgeInsets.only(top: AppConstants.defaultPaddingX0_5),
            child: Text(
              subtitle ?? '',
              textAlign: TextAlign.center,
              style: AppTypography.smallTextStyle.copyWith(
                color: colorScheme.background,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
