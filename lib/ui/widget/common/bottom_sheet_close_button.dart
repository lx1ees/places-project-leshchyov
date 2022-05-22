import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';

/// Виджет кнопки закрытия боттомшита
class BottomSheetCloseButton extends StatelessWidget {
  const BottomSheetCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: SvgPicture.asset(
        AppAssets.clearIcon,
        color: Theme.of(context).white,
        width: AppConstants.closeButtonSize,
        height: AppConstants.closeButtonSize,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minHeight: AppConstants.closeButtonSize,
        minWidth: AppConstants.closeButtonSize,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
