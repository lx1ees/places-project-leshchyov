import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет-иконка галочки в залитом круге
class TickInCircleIcon extends StatelessWidget {
  const TickInCircleIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.tickIcon,
          allowDrawingOutsideViewBox: true,
          color: Theme.of(context).primaryColor,
          fit: BoxFit.cover,
          height: AppConstants.defaultMiniIconSize,
          width: AppConstants.defaultMiniIconSize,
        ),
      ),
    );
  }
}
