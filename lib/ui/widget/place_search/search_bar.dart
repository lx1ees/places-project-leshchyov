import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';

/// Виджет поискового бара
/// [isBlocked] - флаг, указывающий, блокировать ли поле на ввод значений;
/// [onOpenFiltersPressed] - обработчик нажатия на кнопку открытия окна с фильтрами,
/// актуален при [isBlocked] равным true;
/// [onTap] - обработчик нажатия на бар, актуален при [isBlocked] равным true;
/// [controller] - контроллер поля ввода
/// [theme] - текущая тема приложения
/// [focusNode] - фокус нода строки поиска
/// [isClearButtonActive] - флаг, определяющий, доступна ли кнопка очитки строки
/// поиска в данный момент или нет
class SearchBar extends StatelessWidget {
  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(
      AppConstants.textField2BorderRadius,
    )),
  );

  final ThemeData theme;
  final bool isBlocked;
  final TextEditingController? controller;
  final VoidCallback? onOpenFiltersPressed;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool? isClearButtonActive;

  const SearchBar({
    required this.theme,
    this.isClearButtonActive,
    this.focusNode,
    this.controller,
    this.isBlocked = false,
    this.onOpenFiltersPressed,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;

    return TextField(
      onTap: isBlocked ? onTap : null,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      cursorWidth: 1,
      focusNode: !isBlocked ? focusNode : null,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      style: AppTypography.textRegularTextStyle.copyWith(
        color: colorScheme.primary,
      ),
      readOnly: isBlocked,
      enableInteractiveSelection: !isBlocked,
      decoration: InputDecoration(
        fillColor: theme.primaryColorLight,
        hintText: AppStrings.searchTitle,
        hintStyle: AppTypography.textRegularTextStyle.copyWith(
          color: colorScheme.background,
        ),
        filled: true,
        isDense: true,
        enabledBorder: inputBorder,
        border: inputBorder,
        disabledBorder: inputBorder,
        errorBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppConstants.textFieldContentPadding,
          horizontal: AppConstants.defaultPadding,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: AppConstants.defaultIcon3Size,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPaddingX0_75,
          ),
          child: SvgPicture.asset(
            AppAssets.searchIcon,
            color: colorScheme.background,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: AppConstants.defaultTextFieldIconSize,
        ),
        suffixIcon: isBlocked
            ? CustomIconButton(
                icon: SvgPicture.asset(
                  AppAssets.filterIcon,
                  color: colorScheme.secondary,
                ),
                padding: EdgeInsets.zero,
                onPressed: onOpenFiltersPressed ?? () {},
              )
            : isClearButtonActive ?? false
                ? CustomIconButton(
                    icon: SvgPicture.asset(
                      AppAssets.clearIcon,
                      color: colorScheme.primary,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: controller?.clear ?? () {},
                  )
                : null,
      ),
    );
  }
}
