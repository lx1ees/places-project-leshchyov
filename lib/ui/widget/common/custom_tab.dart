import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет кастомного таба с лейблом [label] с возможностью отображать ripple эффект на нем
/// Поскольку коллбек 'onTap' у [InkWell] перехватывает событие нажатия и не прокидывает его
/// родителю, то необходимо передать [controller] в виджет, чтобы вручную
/// переключиться на таб с индексом равным [index].
class CustomTab extends StatefulWidget {
  final TabController controller;
  final int index;
  final String label;

  const CustomTab({
    required this.controller,
    required this.index,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    /// Поскольку controller.index меняется только после того, как отыграет
    /// анимация перелистывания, то в смене цвета текста таба появляется задержка,
    /// поэтому здесь _currentIndex, от которого зависит смена цвета текста,
    /// меняется сразу, как только значение анимации (от 0 до 1) переваливает
    /// за 0.5, достигается путем окгугления
    widget.controller.animation?.addListener(() {
      setState(() {
        final value = (widget.controller.animation?.value)?.round();
        if (value != null && value != _currentIndex) {
          _currentIndex = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTabSelected = _currentIndex == widget.index;

    return Tab(
      height: AppConstants.defaultTabHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.controller.animateTo(widget.index),
          highlightColor: Colors.transparent,
          borderRadius:
              BorderRadius.circular(AppConstants.defaultTabBorderRadius),
          child: Center(
            child: Text(
              widget.label,
              style: isTabSelected
                  ? AppTypography.smallBoldTextStyle.copyWith(
                      color: Theme.of(context).tabBarTheme.labelColor,
                    )
                  : AppTypography.smallBoldTextStyle.copyWith(
                      color: Theme.of(context).tabBarTheme.unselectedLabelColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
