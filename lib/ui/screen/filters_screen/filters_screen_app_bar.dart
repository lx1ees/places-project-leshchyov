import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';

/// Кастомный аппбар экрана с фильтрами с обработчиком кнопки очестки фильтров
/// [onClearFilters]
class FilterScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onClearFilters;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const FilterScreenAppBar({
    required this.onClearFilters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: CustomIconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          size: AppConstants.defaultIcon2Size,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onClearFilters,
          style: TextButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: const Size(0, AppConstants.defaultTextButtonHeight),
            primary: Theme.of(context).colorScheme.secondary,
            textStyle: AppTypography.textTextStyle,
          ),
          child: const Text(AppStrings.clearFiltersButtonTitle),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
    );
  }
}
