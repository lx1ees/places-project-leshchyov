import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/ui/mwwm/add_place/add_place_widget_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widget/add_place/add_image_dialog.dart';
import 'package:places/ui/widget/add_place/add_image_section.dart';
import 'package:places/ui/widget/add_place/add_place_screen_app_bar.dart';
import 'package:places/ui/widget/add_place/select_place_type_section.dart';
import 'package:places/ui/widget/common/bottom_screen_submit_button.dart';
import 'package:places/ui/widget/common/custom_divider.dart';
import 'package:places/ui/widget/common/custom_text_button.dart';
import 'package:places/ui/widget/common/custom_text_field.dart';
import 'package:places/ui/widget/common/focus_manager_holder.dart';
import 'package:relation/relation.dart';

/// Экран добавления нового места
class AddPlaceScreen extends CoreMwwmWidget<AddPlaceWidgetModel> {
  static const String routeName = '/addPlace';

  const AddPlaceScreen({
    required WidgetModelBuilder<AddPlaceWidgetModel> widgetModelBuilder,
    Key? key,
  }) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<AddPlaceScreen, AddPlaceWidgetModel> createWidgetState() =>
      _AddPlaceScreenState();
}

class _AddPlaceScreenState
    extends WidgetState<AddPlaceScreen, AddPlaceWidgetModel> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      appBar: AddPlaceScreenAppBar(
        onCancel: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: wm.formKey,
              child: FocusManagerHolder(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      EntityStateBuilder<List<String>>(
                        streamedState: wm.imagesState,
                        builder: (context, images) {
                          return AddImageSection(
                            images: images,
                            onAddImagePressed: () => _openAddImageDialog(
                              addImageAction: wm.addImageAction,
                            ),
                            onDeleteImagePressed: (index) {
                              wm.removeImageAction.call(index);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      StreamedStateBuilder<PlaceType?>(
                        streamedState: wm.placeTypeState,
                        builder: (context, placeType) {
                          return SelectPlaceTypeSection(
                            selectedPlaceTypeName: placeType?.name,
                            onSelectPlaceTypePressed: () async {
                              final selectedPlaceType =
                                  await _openPlaceTypeSelectionScreenAndGetPlaceType(
                                placeType,
                              );
                              await wm.setPlaceTypeAction
                                  .call(selectedPlaceType);
                            },
                          );
                        },
                      ),
                      const CustomDivider(hasIndent: true),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: CustomTextField(
                          title: AppStrings.placeNameTitle,
                          textInputAction: TextInputAction.go,
                          onTextChange: (value) {
                            wm.setNameAction.call(value);
                          },
                          validator: _validateText,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                title: AppStrings.placeLatTitle,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.go,
                                onTextChange: (value) {
                                  wm.setLatAction.call(double.tryParse(value));
                                },
                                validator: _validateNumber,
                              ),
                            ),
                            const SizedBox(width: AppConstants.defaultPadding),
                            Expanded(
                              child: CustomTextField(
                                title: AppStrings.placeLonTitle,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.go,
                                onTextChange: (value) {
                                  wm.setLonAction(double.tryParse(value));
                                },
                                validator: _validateNumber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: CustomTextButton(
                          label: AppStrings.pointLocationOnMap,
                          foregroundColor: colorScheme.secondary,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX2_25),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: CustomTextField(
                          title: AppStrings.placeDescriptionTitle,
                          isMultiline: true,
                          hint: AppStrings.enterTextHint,
                          onTextChange: (value) {
                            wm.setDescriptionAction.call(value);
                          },
                          validator: _validateText,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX4),
                    ],
                  ),
                ),
              ),
            ),

            /// Кнопку добавления оставляю всегда активной. При нажатии, если есть незаполненные поля,
            /// пользователю показывается где и что незаполнено. Если все заполнено корректно,
            /// то место добавляется.
            Visibility(
              visible: !isKeyboardOpened,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BottomScreenSubmitButton(
                  label: AppStrings.create,
                  onAddPressed: () => wm.submitAddingPlaceAction.call(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Валидация вводимого текста в инпут типа Строка
  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorNotFilled;
    }

    return null;
  }

  /// Валидация вводимого текста в инпут типа Вещественное число
  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorNotFilled;
    }

    if (double.tryParse(value) == null) {
      return AppStrings.errorIncorrect;
    }

    return null;
  }

  /// Метод открытия окна выбора категории и возврата выбранной категории
  Future<PlaceType?> _openPlaceTypeSelectionScreenAndGetPlaceType(
    PlaceType? selectedPlaceType,
  ) async {
    final result = await AppRoutes.navigateToCategoriesScreen(
      context: context,
      selectedPlaceType: selectedPlaceType,
    );

    return result as PlaceType?;
  }

  /// Временный метод, который возвращает рандомную заглушку картинки места
  String _randomImage() {
    final images = [
      AppAssets.newImageMock,
      AppAssets.newImageMock2,
      AppAssets.newImageMock3,
    ];

    return images[Random().nextInt(images.length)];
  }

  Future<void> _openAddImageDialog({
    required StreamedAction<String> addImageAction,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AddImageDialog(
          onCameraPressed: () {
            addImageAction.call(_randomImage());
          },
          onPhotoPressed: () {},
          onFilePressed: () {},
        );
      },
    );
  }
}
