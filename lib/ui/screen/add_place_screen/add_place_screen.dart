import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen_widget_model.dart';
import 'package:places/ui/widget/add_place/add_image_section.dart';
import 'package:places/ui/widget/add_place/add_place_screen_app_bar.dart';
import 'package:places/ui/widget/add_place/select_place_type_section.dart';
import 'package:places/ui/widget/common/bottom_screen_submit_button.dart';
import 'package:places/ui/widget/common/custom_divider.dart';
import 'package:places/ui/widget/common/custom_text_button.dart';
import 'package:places/ui/widget/common/custom_text_field.dart';
import 'package:places/ui/widget/common/focus_manager_holder.dart';

/// Экран добавления нового места
class AddPlaceScreen extends ElementaryWidget<IAddPlaceScreenWidgetModel> {
  static const String routeName = '/addPlace';

  const AddPlaceScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IAddPlaceScreenWidgetModel wm) {
    return Scaffold(
      appBar: AddPlaceScreenAppBar(
        onCancel: wm.onCancelButtonPressed,
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
                      StateNotifierBuilder<List<String>>(
                        listenableState: wm.listImagesState,
                        builder: (context, images) {
                          final imagePaths = images ?? [];

                          return AddImageSection(
                            images: imagePaths,
                            onAddImagePressed: wm.onAddImagePressed,
                            onDeleteImagePressed: wm.onDeleteImagePressed,
                          );
                        },
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      StateNotifierBuilder<PlaceType?>(
                        listenableState: wm.currentPlaceTypeState,
                        builder: (context, placeType) {
                          return SelectPlaceTypeSection(
                            selectedPlaceType: placeType,
                            onSelectPlaceTypePressed:
                                wm.onSelectPlaceTypePressed,
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
                          onTextChange: wm.onNameChanged,
                          validator: wm.validatorText,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: StateNotifierBuilder<LocationPoint?>(
                          listenableState: wm.currentGeolocationState,
                          builder: (_, geolocation) {
                            final lat = geolocation?.lat.toString() ?? '';
                            final lon = geolocation?.lon.toString() ?? '';

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    title: AppStrings.placeLatTitle,
                                    initialValue: lat,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.go,
                                    onTextChange: wm.onLatChanged,
                                    validator: wm.validatorNumber,
                                  ),
                                ),
                                const SizedBox(
                                  width: AppConstants.defaultPadding,
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    title: AppStrings.placeLonTitle,
                                    initialValue: lon,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.go,
                                    onTextChange: wm.onLonChanged,
                                    validator: wm.validatorNumber,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: CustomTextButton(
                          label: AppStrings.pointLocationOnMap,
                          foregroundColor: wm.colorScheme.secondary,
                          onPressed: wm.onSelectGeolocationPressed,
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
                          onTextChange: wm.onDescriptionChanged,
                          validator: wm.validatorText,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX4),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !wm.isKeyboardOpened,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BottomScreenSubmitButton(
                  label: AppStrings.create,
                  onAddPressed: wm.onSubmitAddingPlace,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
