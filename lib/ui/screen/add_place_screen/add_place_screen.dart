import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/ui/screen/add_place_screen/add_image_dialog.dart';
import 'package:places/ui/screen/add_place_screen/add_image_section.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen_app_bar.dart';
import 'package:places/ui/screen/add_place_screen/select_place_type_section.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widget/bottom_screen_submit_button.dart';
import 'package:places/ui/widget/custom_divider.dart';
import 'package:places/ui/widget/custom_text_button.dart';
import 'package:places/ui/widget/custom_text_field.dart';
import 'package:places/ui/widget/focus_manager_holder.dart';
import 'package:provider/provider.dart';

/// Экран добавления нового места
class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/addPlace';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _imagePaths = [];
  PlaceType? _placeType;
  String? _name;
  double? _lat;
  double? _lon;
  String? _description;

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
              key: _formKey,
              child: FocusManagerHolder(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      AddImageSection(
                        images: _imagePaths,
                        onAddImagePressed: _openAddImageDialog,
                        onDeleteImagePressed: (index) {
                          setState(() {
                            _imagePaths.removeAt(index);
                          });
                        },
                      ),
                      const SizedBox(height: AppConstants.defaultPaddingX1_5),
                      SelectPlaceTypeSection(
                        selectedPlaceTypeName: _placeType?.name,
                        onSelectPlaceTypePressed: () async {
                          final selectedPlaceType =
                              await _openPlaceTypeSelectionScreenAndGetPlaceType(
                            context,
                          );
                          setState(() {
                            _placeType = selectedPlaceType;
                          });
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
                            _name = value;
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
                                  _lat = double.tryParse(value);
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
                                  _lon = double.tryParse(value);
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
                            _description = value;
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
            Visibility(
              visible: !isKeyboardOpened,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BottomScreenSubmitButton(
                  label: AppStrings.create,
                  onAddPressed: () async {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        _isAllFieldsFilledAndCorrect(
                          placeType: _placeType,
                          name: _name,
                          lat: _lat,
                          lon: _lon,
                          description: _description,
                        )) {
                      await _addNewPlace(
                        placeType: _placeType!,
                        name: _name!,
                        lon: _lon!,
                        lat: _lat!,
                        description: _description!,
                      );

                      if (!mounted) return;
                      Navigator.pop(context);
                    }
                  },
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

  /// Метода добавления нового места
  Future<void> _addNewPlace({
    required PlaceType placeType,
    required String name,
    required double lat,
    required double lon,
    required String description,
  }) async {
    final newPlace = Place(
      name: name,
      point: LocationPoint(lat: lat, lon: lon),
      description: description,
      placeType: placeType,
    );
    await context.read<PlaceInteractor>().addNewPlace(newPlace);
  }

  /// Функция проверки заполненности и корректности всех обязательных для заполнения
  /// полей
  bool _isAllFieldsFilledAndCorrect({
    PlaceType? placeType,
    String? name,
    double? lat,
    double? lon,
    String? description,
  }) {
    final isPlaceTypeSelected = placeType != null;
    final isNameProvided = name != null && name.isNotEmpty;
    final isLatProvided = lat != null;
    final isLonProvided = lon != null;
    final isDescriptionProvided = description != null && description.isNotEmpty;

    if (isPlaceTypeSelected &&
        isNameProvided &&
        isLatProvided &&
        isLonProvided &&
        isDescriptionProvided) {
      return true;
    }

    return false;
  }

  /// Метод открытия окна выбора категории и возврата выбранной категории
  Future<PlaceType?> _openPlaceTypeSelectionScreenAndGetPlaceType(
    BuildContext context,
  ) async {
    final result = await AppRoutes.navigateToCategoriesScreen(
      context: context,
      selectedPlaceType: _placeType,
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

  Future<void> _openAddImageDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AddImageDialog(
          onCameraPressed: () {
            setState(() {
              _imagePaths.add(_randomImage());
            });
          },
          onPhotoPressed: () {},
          onFilePressed: () {},
        );
      },
    );
  }
}
