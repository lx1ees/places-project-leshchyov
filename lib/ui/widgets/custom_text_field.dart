import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/widgets/custom_focus_manager.dart';
import 'package:places/ui/widgets/focus_manager_holder.dart';
import 'package:places/utils/typedefs.dart';

/// Кастомный виджет TextField с заголовком [title] над полем ввода, подсказкой
/// [hint], обработчиком ввода текста [onTextChange], кнопкой подтверждения ввода
/// на клавиатуре [textInputAction], флагом [isMultiline], который предусматривает
/// высоту поля ввода в 3 строки, с [textInputType] - типом вводимого текста, валидатором
/// вводимого текста [validator] и обработчиком подтверждения введенного текста [onFieldSubmitted]
class CustomTextField extends StatefulWidget {
  final String title;
  final String? hint;
  final OnTextChanged? onTextChange;
  final TextInputAction? textInputAction;
  final bool isMultiline;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onFieldSubmitted;

  const CustomTextField({
    required this.title,
    this.onTextChange,
    this.isMultiline = false,
    this.hint,
    this.validator,
    this.onFieldSubmitted,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    Key? key,
  })  : textInputAction = textInputAction ?? TextInputAction.done,
        textInputType = isMultiline
            ? TextInputType.multiline
            : textInputType ?? TextInputType.text,
        super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late final CustomFocusManager? _focusManager;
  String? errorText;

  FocusNode get focusNode => _focusNode;

  @override
  void initState() {
    super.initState();

    /// Находим FocusManagerHolder выше в дереве и инициализируем CustomFocusManager
    /// для обеспечения перемещения фокуса к следующему CustomTextField
    _focusManager = FocusManagerHolder.of(context)?.focusManager;
    _focusManager?.registerFocusNode(focusNode);
    _controller = TextEditingController()..addListener(_textChangesListener);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_textChangesListener)
      ..dispose();
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    _focusManager?.unregisterFocusNode(focusNode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onFieldSubmitted = widget.onFieldSubmitted ?? () {};
    final validator = widget.validator ?? (value) => null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypography.superSmallTextStyle.copyWith(
            color: colorScheme.background,
          ),
        ),
        const SizedBox(height: AppConstants.defaultPaddingX0_75),
        TextFormField(
          style: AppTypography.textRegularTextStyle.copyWith(
            color: colorScheme.primary,
          ),
          focusNode: _focusNode,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          maxLines: widget.isMultiline ? 3 : 1,
          controller: _controller,
          cursorWidth: 1,
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            /// Не даем валидатору переопределить errorText и осуществляем валидацию вручную
            /// методом _validate
            _validate(validator, _controller.text);

            return null;
          },
          decoration: InputDecoration(
            isDense: true,
            errorText: errorText,
            errorMaxLines: 2,
            hintText: widget.hint,
            hintStyle: AppTypography.textRegularTextStyle.copyWith(
              color: colorScheme.background,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: colorScheme.error,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(
                AppConstants.textFieldBorderRadius,
              )),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.error,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(
                AppConstants.textFieldBorderRadius,
              )),
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: AppConstants.defaultTextFieldIconSize,
            ),
            suffixIcon: _controller.text.isNotEmpty && _focusNode.hasFocus
                ? IconButton(
                    icon: SvgPicture.asset(
                      AppAssets.clearIcon,
                      color: colorScheme.primary,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: _controller.clear,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppConstants.textFieldContentPadding,
              horizontal: AppConstants.defaultPadding,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: colorScheme.secondary.withOpacity(0.4),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(
                AppConstants.textFieldBorderRadius,
              )),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.secondary.withOpacity(0.4),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(
                AppConstants.textFieldBorderRadius,
              )),
            ),
          ),
          onFieldSubmitted: (value) {
            /// Если кнопка подтверждения ввода текста имеет тип go, что
            /// означает, что необходимо перейти к следующему полю ввода, переводим фокус,
            /// иначе скрываем клавиатуру и убираем фокус с поля ввода.
            if (widget.textInputAction == TextInputAction.go) {
              _focusManager?.requestNextFocus(focusNode);
            } else {
              focusNode.unfocus();
            }

            /// Валидируем поле ввода
            _validate(validator, _controller.text);

            onFieldSubmitted();
          },
        ),
      ],
    );
  }

  /// Метод валидации введенного текста с помощью переданного извне валидатора
  void _validate(FormFieldValidator<String> validator, String? value) {
    setState(() {
      errorText = validator(value);
    });
  }

  void _textChangesListener() {
    _textChangesHandler(widget.onTextChange);
  }

  void _textChangesHandler(OnTextChanged? onTextChangeListener) {
    final value = _controller.text;
    errorText = null;
    if (onTextChangeListener != null) {
      onTextChangeListener(value);
    }
    setState(() {});
  }

  void _onFocusChanged() {
    setState(() {});
  }
}
