import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/themes.dart';

/// Виджет-плейсхолдер изображения на время загрузки или отсутствия
class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppAssets.photoIcon,
        width: AppConstants.defaultIconBigSize,
        height: AppConstants.defaultIconBigSize,
        color: Theme.of(context).white,
      ),
    );
  }
}
