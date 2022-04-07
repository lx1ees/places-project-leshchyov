import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';

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
          AppAssets.tickIconAssetPath,
          allowDrawingOutsideViewBox: true,
          color: Theme.of(context).primaryColor,
          fit: BoxFit.cover,
          height: 16,
          width: 16,
        ),
      ),
    );
  }
}