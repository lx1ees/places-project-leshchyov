import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет элемента списка в диалоге выбора способа добавления изображения
/// [iconAsset] - путь до иконки в ресурсах
/// [title] - заголовок
/// [onPressed] - обработчик нажатия
class AddImageDialogItem extends StatelessWidget {
  final String iconAsset;
  final String title;
  final VoidCallback onPressed;

  const AddImageDialogItem({
    required this.iconAsset,
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(
          title,
          style: AppTypography.textRegularTextStyle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onTap: onPressed,
        horizontalTitleGap: 0,
        leading: SvgPicture.asset(
          iconAsset,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
