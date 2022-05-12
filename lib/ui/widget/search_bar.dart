import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widget/custom_icon_button.dart';

/// Виджет поискового бара
/// [isBlocked] - флаг, указывающий, блокировать ли поле на ввод значений;
/// [onOpenFiltersPressed] - обработчик нажатия на кнопку открытия окна с фильтрами,
/// актуален при [isBlocked] равным true;
/// [onTap] - обработчик нажатия на бар, актуален при [isBlocked] равным true;
/// [onSearch] - обработчик изменения вводимого текста, актуален при [isBlocked] равным false;
/// [controller] - контроллер поля ввода (временно, пока есть необходимость взаимодейстовать
/// с ним извне)
class SearchBar extends StatefulWidget {
  final bool isBlocked;
  final TextEditingController? controller;
  final VoidCallback? onOpenFiltersPressed;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSearch;

  const SearchBar({
    this.controller,
    this.isBlocked = false,
    this.onOpenFiltersPressed,
    this.onTap,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(
      AppConstants.textField2BorderRadius,
    )),
  );

  final FocusNode _focusNode = FocusNode();
  String previousTextValue = '';

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    widget.controller?.addListener(_textChangesListener);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_textChangesListener);
    widget.controller?.dispose();
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isBlocked = widget.isBlocked;
    final controller = widget.controller;

    return TextField(
      onTap: isBlocked ? widget.onTap : null,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      cursorWidth: 1,
      focusNode: !isBlocked ? _focusNode : null,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      style: AppTypography.textRegularTextStyle.copyWith(
        color: colorScheme.primary,
      ),
      readOnly: isBlocked,
      enableInteractiveSelection: !isBlocked,
      decoration: InputDecoration(
        fillColor: Theme.of(context).primaryColorLight,
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
                onPressed: widget.onOpenFiltersPressed ?? () {},
              )
            : _focusNode.hasFocus && (controller?.text.isNotEmpty ?? false)
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

  void _textChangesListener() {
    /// Так как коллбек дергается, когда меняется фокус у поля, неоходимо делать
    /// следующую проверку, что при каждом изменении фокуса и отсутствии
    /// реального изменения текста не слать запрос на поиск
    if (previousTextValue != widget.controller?.text) {
      previousTextValue = widget.controller?.text ?? '';
      _textChangesHandler(widget.onSearch);
    }
  }

  void _textChangesHandler(ValueChanged<String>? onTextChangeListener) {
    final value = widget.controller?.text;
    if (onTextChangeListener != null) {
      onTextChangeListener(value ?? '');
    }
    setState(() {});
  }

  void _onFocusChanged() {
    setState(() {});
  }
}
