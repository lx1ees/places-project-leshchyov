import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';

/// Полоса индикатора, по которой он "ездит"
/// [indicator] - виджет индикатора
/// [scrollController] - контроллер прокрутки
/// [numberOfSegments] - число сегментов полосы индикатора
class IndicatorLine extends StatefulWidget {
  final Widget indicator;
  final ScrollController scrollController;
  final int numberOfSegments;

  const IndicatorLine({
    required this.indicator,
    required this.scrollController,
    required this.numberOfSegments,
    Key? key,
  }) : super(key: key);

  @override
  State<IndicatorLine> createState() => _IndicatorLineState();
}

class _IndicatorLineState extends State<IndicatorLine> {
  double _indicatorLeftPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScrolledListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrolledListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.indicatorHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(),
          Visibility(
            visible: widget.numberOfSegments > 1,
            child: Positioned(
              left: _indicatorLeftPosition,
              bottom: 0,
              child: widget.indicator,
            ),
          ),
        ],
      ),
    );
  }

  void _onScrolledListener() {
    setState(() {
      _indicatorLeftPosition =
          widget.scrollController.offset / widget.numberOfSegments;
    });
  }
}
