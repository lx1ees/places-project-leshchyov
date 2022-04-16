import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';

/// Виджет карточки добавляемого изображения
class NewImageCard extends StatelessWidget {
  final String path;
  final VoidCallback onDelete;

  const NewImageCard({
    required Key key,
    required this.path,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key ?? UniqueKey(),
      direction: DismissDirection.up,
      onDismissed: (direction) => onDelete(),
      child: Padding(
        padding: const EdgeInsets.only(
          right: AppConstants.defaultPadding,
        ),
        child: Stack(children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(AppConstants.button2BorderRadius),
            child: SizedBox(
              height: AppConstants.addNewSightImageSize,
              width: AppConstants.addNewSightImageSize,
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: AppConstants.defaultPaddingX0_25,
            top: AppConstants.defaultPaddingX0_25,
            child: CustomIconButton(
              icon: SvgPicture.asset(
                AppAssets.clearIcon,
                color: Theme.of(context).white,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onDelete,
            ),
          ),
        ]),
      ),
    );
  }
}
