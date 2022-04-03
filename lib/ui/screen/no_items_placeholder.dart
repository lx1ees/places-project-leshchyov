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

  const NoItemsPlaceholder({
    required this.title,
    this.subtitle,
    this.iconPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIconPathProvided =
        iconPath != null && (iconPath?.isNotEmpty ?? false);
    final isSubtitleProvided =
        subtitle != null && (subtitle?.isNotEmpty ?? false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: isIconPathProvided,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: AppConstants.defaultPaddingX2),
            child: SvgPicture.asset(iconPath ?? ''),
          ),
        ),
        Text(
          title,
          style: AppTypography.placeholderNoItemsTitleStyle,
        ),
        Visibility(
          visible: isSubtitleProvided,
          child: Container(
            width: AppConstants.placeholderNoItemsSubtitleWidth,
            padding:
                const EdgeInsets.only(top: AppConstants.defaultPaddingX0_5),
            child: Text(
              subtitle ?? '',
              textAlign: TextAlign.center,
              style: AppTypography.placeholderNoItemsSubtitleStyle,
            ),
          ),
        ),
      ],
    );
  }
}
