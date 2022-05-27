import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';

/// Кастомный индикатор загрузки
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  double turns = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _changeTurns();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).colorScheme.brightness;

    return Center(
      child: AnimatedRotation(
        turns: turns,
        duration: const Duration(seconds: AppConstants.circleLoaderTimeInSec),
        child: Image.asset(
          brightness == Brightness.light
              ? AppAssets.loadIndicator
              : AppAssets.loadIndicatorDark,
        ),
      ),
    );
  }

  Future<void> _changeTurns() async {
    await Future.delayed(Duration.zero, () {});
    setState(() {
      turns = AppConstants.circleLoaderTimeInSec /
          AppConstants.circleLoaderTurnsInOneSec;
    });
  }
}
