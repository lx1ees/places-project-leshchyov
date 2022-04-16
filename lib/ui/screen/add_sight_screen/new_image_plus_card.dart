import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';

class NewImagePlusCard extends StatelessWidget {
  final VoidCallback onPressed;

  const NewImagePlusCard({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: AppConstants.addNewSightImageSize,
        width: AppConstants.addNewSightImageSize,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.secondary.withOpacity(0.48),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppConstants.button2BorderRadius),
        ),
        padding: const EdgeInsets.all(AppConstants.defaultIcon3Size),
        child: SvgPicture.asset(
          AppAssets.plusIcon,
          color: colorScheme.secondary,
        ),
      ),
    );
  }
}
