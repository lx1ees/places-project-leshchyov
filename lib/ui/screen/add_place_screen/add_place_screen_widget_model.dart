import 'dart:math';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen_model.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widget/add_place/add_image_dialog.dart';
import 'package:places/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

/// Фабрика для [AddPlaceScreenWidgetModel]
AddPlaceScreenWidgetModel addPlaceScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = AddPlaceScreenModel(
    errorHandler: dependencies.errorHandler,
    placeInteractor: dependencies.placeInteractor,
  );

  return AddPlaceScreenWidgetModel(
    model: model,
    themeWrapper: dependencies.themeWrapper,
    navigator: Navigator.of(context),
  );
}

/// Виджет-модель для [AddPlaceScreenModel]
class AddPlaceScreenWidgetModel
    extends WidgetModel<AddPlaceScreen, AddPlaceScreenModel>
    implements IAddPlaceScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Ключ формы
  final _formKey = GlobalKey<FormState>();

  /// Навигатор
  final NavigatorState _navigator;

  /// Помощник выбора изображения (из камеры или галереи)
  final ImagePicker _imagePicker = ImagePicker();

  final _currentPlaceTypeState = StateNotifier<PlaceType?>();
  final _listImagesState = StateNotifier<List<String>>();

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  bool get isKeyboardOpened => MediaQuery.of(context).viewInsets.bottom != 0.0;

  @override
  ListenableState<PlaceType?> get currentPlaceTypeState =>
      _currentPlaceTypeState;

  @override
  GlobalKey<State<StatefulWidget>> get formKey => _formKey;

  @override
  ListenableState<List<String>> get listImagesState => _listImagesState;

  @override
  FormFieldValidator<String> get validatorNumber => _validateNumber;

  @override
  FormFieldValidator<String> get validatorText => _validateText;

  /// Введенное наименование места
  String? _name;

  /// Введенная широта места
  double? _lat;

  /// Введенная долгота места
  double? _lon;

  /// Введенное описание места
  String? _description;

  AddPlaceScreenWidgetModel({
    required AddPlaceScreenModel model,
    required ThemeWrapper themeWrapper,
    required NavigatorState navigator,
  })  : _themeWrapper = themeWrapper,
        _navigator = navigator,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
  }

  @override
  void onAddImagePressed() {
    _openAddImageDialog((image) {
      final currentImages = _listImagesState.value ?? [];
      _listImagesState.accept([...currentImages..add(image)]);
    });
  }

  @override
  void onCancelButtonPressed() => _navigator.pop();

  @override
  void onDeleteImagePressed(int index) {
    final currentImages = _listImagesState.value ?? [];
    _listImagesState.accept([...currentImages..removeAt(index)]);
  }

  @override
  void onDescriptionChanged(String description) => _description = description;

  @override
  void onLatChanged(String lat) => _lat = double.tryParse(lat);

  @override
  void onLonChanged(String lon) => _lon = double.tryParse(lon);

  @override
  void onNameChanged(String name) => _name = name;

  @override
  Future<void> onSelectPlaceTypePressed(PlaceType? placeType) async {
    final selectedPlaceType =
        await _openPlaceTypeSelectionScreenAndGetPlaceType(placeType);
    _currentPlaceTypeState.accept(selectedPlaceType);
  }

  @override
  Future<void> onSubmitAddingPlace() async {
    if ((_formKey.currentState?.validate() ?? false) &&
        _isAllFieldsFilledAndCorrect(
          placeType: _currentPlaceTypeState.value,
          name: _name,
          lat: _lat,
          lon: _lon,
          description: _description,
        )) {
      try {
        await model.addNewPlace(
          placeType: _currentPlaceTypeState.value!,
          name: _name!,
          lon: _lon!,
          lat: _lat!,
          description: _description!,
          imagesPaths: _listImagesState.value ?? [],
        );

        _navigator.pop();
      } on Exception catch (_) {
        DialogUtils.showSnackBar(
          context: context,
          title: AppStrings.errorWhileAddingPlace,
        );
      }
    }
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

  /// Открытие диалога добавления изображения с коллбеком [onImageAdded]
  Future<void> _openAddImageDialog(ValueChanged<String> onImageAdded) async {
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'barrier',
      transitionDuration: const Duration(
        milliseconds:
            AppConstants.imagePickerDialogAppearanceAnimationDurationInMillis,
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AddImageDialog(
          onCameraPressed: () async {
            final imagePath = await _pickImageFrom(ImageSource.camera);
            if (imagePath != null) onImageAdded(imagePath);
          },
          onPhotoPressed: () async {
            final imagePath = await _pickImageFrom(ImageSource.gallery);
            if (imagePath != null) onImageAdded(imagePath);
          },
          onFilePressed: () => onImageAdded(_randomImage()),
        );
      },
    );
  }

  /// Метод получения изображения из истоника [source]
  Future<String?> _pickImageFrom(ImageSource source) async {
    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 512,
      maxHeight: 512,
    );

    return image?.path;
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
}

abstract class IAddPlaceScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Признак открытой клавиатуры
  bool get isKeyboardOpened;

  /// Ключ формы
  GlobalKey get formKey;

  /// Валидатор вводимого текста
  FormFieldValidator<String> get validatorText;

  /// Валидатор вводимого числа
  FormFieldValidator<String> get validatorNumber;

  /// Состояние списка добавленных изображений
  ListenableState<List<String>> get listImagesState;

  /// Состояние текущего выбранного типа места
  ListenableState<PlaceType?> get currentPlaceTypeState;

  /// Обработчик нажатия на кнопку "Отмена"
  void onCancelButtonPressed();

  /// Обработчик нажатия на кнопку для добавления изображения
  void onAddImagePressed();

  /// Обработчик удаления изображения в списке по индексу [index]
  void onDeleteImagePressed(int index);

  /// Обработчик нажатия на кнопку для открытия окна выбора типа места
  /// [placeType] - ранее выбранное место
  Future<void> onSelectPlaceTypePressed(PlaceType? placeType);

  /// Обработчик изменения имени [name]
  void onNameChanged(String name);

  /// Обработчик изменения широты [lat]
  void onLatChanged(String lat);

  /// Обработчик изменения долготы [lon]
  void onLonChanged(String lon);

  /// Обработчик изменения описания [description]
  void onDescriptionChanged(String description);

  /// Обработчик нажатия на кнопку добавления нового места
  Future<void> onSubmitAddingPlace();
}
