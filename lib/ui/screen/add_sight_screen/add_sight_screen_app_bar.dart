import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';

/// Кастомный аппбар экрана добавления нового местк с обработчиком кнопки Отмена
/// [onCancel]
class AddSightScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onCancel;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const AddSightScreenAppBar({
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(
        AppStrings.newPlaceTitle,
        style: AppTypography.subtitleTextStyle.copyWith(
          color: colorScheme.primary,
        ),
      ),
      leadingWidth: AppConstants.defaultAppBarButtonLeadingWidth,
      centerTitle: true,
      leading: TextButton(
        onPressed: onCancel,
        style: TextButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          primary: colorScheme.secondaryContainer,
          textStyle: AppTypography.textTextStyle,
        ),
        child: const Text(AppStrings.cancel),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
    );
  }
}
