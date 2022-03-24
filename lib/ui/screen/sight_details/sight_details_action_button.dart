import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения кнопки действия на экране деталей достопримечательности
/// с наименованием [title]
class SightDetailsActionButton extends StatelessWidget {
  final String title;

  const SightDetailsActionButton({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.sightDetailsActionButtonWidth,
      height: AppConstants.sightDetailsActionButtonHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppConstants.sightDetailsActionButtonIconSize,
            height: AppConstants.sightDetailsActionButtonIconSize,
            decoration: BoxDecoration(
              /// временно, не стал выносить цвет в константы
              color: Colors.white,
              border: Border.all(
                /// временно, не стал выносить цвет в константы
                color: Colors.grey,

                /// временно, не стал выносить в константы
                width: 3,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.defaultIconTextPadding),

          /// Обернул в Flexible в случае, если текст кнопки будет длинный
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.sightDetailsButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
