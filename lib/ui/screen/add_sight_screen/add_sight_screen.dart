import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_category.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen/add_image_dialog.dart';
import 'package:places/ui/screen/add_sight_screen/add_image_section.dart';
import 'package:places/ui/screen/add_sight_screen/add_new_sight_button.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen_app_bar.dart';
import 'package:places/ui/screen/add_sight_screen/select_category_section.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widgets/custom_divider.dart';
import 'package:places/ui/widgets/custom_elevated_button.dart';
import 'package:places/ui/widgets/custom_text_button.dart';
import 'package:places/ui/widgets/custom_text_field.dart';
import 'package:places/ui/widgets/focus_manager_holder.dart';

/// Экран добавления нового места
class AddSightScreen extends StatefulWidget {
  static const String routeName = '/addSight';

  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _imagePaths = [];
  SightCategory? _category;
  String? _name;
  double? _lat;
  double? _lon;
  String? _details;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      appBar: AddSightScreenAppBar(
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
                      SelectCategorySection(
                        selectedCategoryName: _category?.name,
                        onSelectCategoryPressed: () async {
                          final selectedSightCategory =
                              await _openCategorySelectionScreenAndGetCategory(
                            context,
                          );
                          setState(() {
                            _category = selectedSightCategory;
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
                          title: AppStrings.placeDetailsTitle,
                          isMultiline: true,
                          hint: AppStrings.enterTextHint,
                          onTextChange: (value) {
                            _details = value;
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
                  onAddPressed: () {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        _isAllFieldsFilledAndCorrect(
                          category: _category,
                          name: _name,
                          lat: _lat,
                          lon: _lon,
                          details: _details,
                        )) {
                      _addNewPlace(
                        category: _category!,
                        name: _name!,
                        lon: _lon!,
                        lat: _lat!,
                        details: _details!,
                      );
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
  void _addNewPlace({
    required SightCategory category,
    required String name,
    required double lat,
    required double lon,
    required String details,
  }) {
    final newPlace = Sight(
      name: name,
      point: LocationPoint(lat: lat, lon: lon),
      details: details,
      category: category,
    );
    sightsMock.insert(0, newPlace);
  }

  /// Функция проверки заполненности и корректности всех обязательных для заполнения
  /// полей
  bool _isAllFieldsFilledAndCorrect({
    SightCategory? category,
    String? name,
    double? lat,
    double? lon,
    String? details,
  }) {
    final isCategorySelected = category != null;
    final isNameProvided = name != null && name.isNotEmpty;
    final isLatProvided = lat != null;
    final isLonProvided = lon != null;
    final isDetailsProvided = details != null && details.isNotEmpty;

    if (isCategorySelected &&
        isNameProvided &&
        isLatProvided &&
        isLonProvided &&
        isDetailsProvided) {
      return true;
    }

    return false;
  }

  /// Метод открытия окна выбора категории и возврата выбранной категории
  Future<SightCategory?> _openCategorySelectionScreenAndGetCategory(
    BuildContext context,
  ) async {
    final result = await AppRoutes.navigateToCategoriesScreen(
      context: context,
      selectedCategory: _category,
    );

    return result as SightCategory?;
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
