import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/widget/add_place/add_image_dialog_item.dart';
import 'package:places/ui/widget/common/custom_divider.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';

/// Виджет диалога выбора способа добавления изображения с обработчиками
class AddImageDialog extends StatelessWidget {
  final VoidCallback onCameraPressed;
  final VoidCallback onPhotoPressed;
  final VoidCallback onFilePressed;

  const AddImageDialog({
    required this.onCameraPressed,
    required this.onPhotoPressed,
    required this.onFilePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0,
      alignment: Alignment.bottomCenter,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.defaultPaddingX0_5,
      ),
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: AppConstants.infinity),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(AppConstants.button2BorderRadius),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                AddImageDialogItem(
                  title: AppStrings.camera,
                  iconAsset: AppAssets.cameraIcon,
                  onPressed: onCameraPressed,
                ),
                const CustomDivider(hasIndent: true),
                AddImageDialogItem(
                  title: AppStrings.photo,
                  iconAsset: AppAssets.photoIcon,
                  onPressed: onPhotoPressed,
                ),
                const CustomDivider(hasIndent: true),
                AddImageDialogItem(
                  title: AppStrings.file,
                  iconAsset: AppAssets.fileIcon,
                  onPressed: onFilePressed,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        CustomElevatedButton(
          label: AppStrings.cancel,
          textColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
