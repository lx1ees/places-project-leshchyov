import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/utils/widget_utils.dart';

/// Аппбар окна со списком достопримечательностей на сливерах с эффектом сворачивания
/// двустрочного заголовка в однострочный при скролле
class PlaceListScreenSliverAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final String extraTitle;

  const PlaceListScreenSliverAppBar({
    required this.scrollController,
    required this.extraTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceListScreenSliverAppBar> createState() =>
      _PlaceListScreenSliverAppBarState();
}

class _PlaceListScreenSliverAppBarState
    extends State<PlaceListScreenSliverAppBar> {
  static const expandedTitleScale = 1.78;
  double maxTitleHeight = 0;
  double minTitleHeight = 0;
  double maxTitleWidth = 0;
  double minTitleWidth = 0;
  double maxTitleContainerWidth = 0;
  double minTitleContainerWidth = 0;

  double _moveFactor = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// При отрисовке первого кадра инициализируем ограничения заголовка аппбара
      /// и его контейнера
      _initConstraints(context);
      setState(() {});
    });
    widget.scrollController.addListener(_onScrolled);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrolled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    maxTitleContainerWidth = screenWidth;

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      expandedHeight: AppConstants.appbarHeight,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: expandedTitleScale,
        titlePadding: const EdgeInsets.all(
          AppConstants.defaultPadding,
        ),
        title: SizedBox(
          width: screenWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: _getTitleContainerWidth(),
                child: SizedBox(
                  height: _getTitleHeight(),
                  width: _getTitleWidth(),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          AppStrings.placeListAppBarFirstLineTitle,
                          style: AppTypography.subtitleBoldTextStyle.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Text(
                          AppStrings.placeListAppBarSecondLineTitle,
                          style: AppTypography.subtitleBoldTextStyle.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.extraTitle.isNotEmpty,
                child: Text(
                  widget.extraTitle,
                  style: AppTypography.smallTextStyle.copyWith(fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onScrolled() {
    setState(() {
      _moveFactor = _calculateMoveFactor();
    });
  }

  /// Метод для вычисления фактора скролла аппбара
  double _calculateMoveFactor() {
    final deltaHeight =
        AppConstants.appbarHeight - widget.scrollController.offset;
    final currentScrollOffset = deltaHeight > AppConstants.appbarHeight
        ? AppConstants.appbarHeight
        : deltaHeight < kToolbarHeight
            ? kToolbarHeight
            : deltaHeight;

    return 1 -
        (currentScrollOffset - kToolbarHeight) /
            (AppConstants.appbarHeight - kToolbarHeight);
  }

  /// Метод для вычисления высоты заголовка аппбара в зависимости от позиции скролла
  double _getTitleHeight() =>
      max(minTitleHeight, maxTitleHeight * (1 - _moveFactor));

  /// Метод для вычисления ширины заголовка аппбара в зависимости от позиции скролла
  double _getTitleWidth() {
    const speedFactor = 0.9;
    final delta = (maxTitleWidth - minTitleWidth).abs();
    final correctedModeFactor =
        min(_moveFactor + speedFactor * (1 - _moveFactor), 1);

    return minTitleWidth + delta * correctedModeFactor;
  }

  /// Метод для вычисления ширины контейнера заголовка аппбара в зависимости от позиции скролла
  /// Необходима, чтобы центрировать заголовок относительно его контейнера
  double _getTitleContainerWidth() {
    final delta = (maxTitleContainerWidth - minTitleContainerWidth).abs();

    return minTitleContainerWidth + delta * _moveFactor;
  }

  /// Метод для инициализации ограничений заголовка аппбара и его контейнера
  void _initConstraints(BuildContext context) {
    final twoLineTitleSize = WidgetUtils.calculateTitleSize(
      context: context,
      text: AppStrings.placeListAppBarTwoLineTitle,
      style: AppTypography.largeTitleTextStyle,
    );
    final oneLineTitleSize = WidgetUtils.calculateTitleSize(
      context: context,
      text: AppStrings.placeListAppBarOneLineTitle,
      style: AppTypography.subtitleBoldTextStyle,
    );
    final longestLineTitleSize = WidgetUtils.calculateTitleSize(
      context: context,
      text: AppStrings.placeListAppBarSecondLineTitle,
      style: AppTypography.subtitleBoldTextStyle,
    );

    maxTitleHeight = twoLineTitleSize.height * 1.2;
    minTitleHeight = oneLineTitleSize.height;
    maxTitleWidth = oneLineTitleSize.width;
    minTitleWidth = longestLineTitleSize.width;
    minTitleContainerWidth = minTitleWidth;
  }
}
