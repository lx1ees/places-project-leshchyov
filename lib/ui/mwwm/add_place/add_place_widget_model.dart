import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:relation/relation.dart';

/// Виджет-модель экрана Добавления нового места
class AddPlaceWidgetModel extends WidgetModel {
  /// 🆘 Не знаю, правильно ли выносить сюда ключ, примеров нигде не нашел, но кажется
  /// что widget должен быть максимально разгружен и все делегируется виджет модели,
  /// и хранение переменных, и обработка событий. Если не так, объясните, пожалуйста.
  final formKey = GlobalKey<FormState>();

  /// Стейты
  final imagesState = EntityStreamedState<List<String>>();
  final placeTypeState = StreamedState<PlaceType?>(null);
  final nameState = EntityStreamedState<String>();
  final latState = EntityStreamedState<double?>();
  final lonState = EntityStreamedState<double?>();
  final descriptionState = EntityStreamedState<String>();

  /// Намерения
  final addImageAction = StreamedAction<String>();
  final removeImageAction = StreamedAction<int>();
  final setPlaceTypeAction = StreamedAction<PlaceType?>();
  final setNameAction = StreamedAction<String>();
  final setLatAction = StreamedAction<double?>();
  final setLonAction = StreamedAction<double?>();
  final setDescriptionAction = StreamedAction<String>();
  final submitAddingPlaceAction = VoidAction();

  final PlaceInteractor _placeInteractor;
  final NavigatorState _navigator;

  AddPlaceWidgetModel(
    WidgetModelDependencies baseDependencies, {
    required PlaceInteractor placeInteractor,
    required NavigatorState navigator,
  })  : _placeInteractor = placeInteractor,
        _navigator = navigator,
        super(baseDependencies);

  @override
  void onLoad() {
    imagesState.content([]);
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();
    subscribeHandleError<String>(addImageAction.stream, (value) {
      final currentImages = imagesState.value.data ?? [];
      imagesState.content(currentImages..add(value));
    });

    subscribeHandleError<int>(removeImageAction.stream, (value) {
      final currentImages = imagesState.value.data ?? [];
      imagesState.content(currentImages..removeAt(value));
    });

    subscribeHandleError<PlaceType?>(
      setPlaceTypeAction.stream,
      placeTypeState.accept,
    );
    subscribeHandleError<String>(setNameAction.stream, nameState.content);
    subscribeHandleError<double?>(setLatAction.stream, latState.content);
    subscribeHandleError<double?>(setLonAction.stream, lonState.content);
    subscribeHandleError<String>(
      setDescriptionAction.stream,
      descriptionState.content,
    );

    subscribeHandleError<void>(submitAddingPlaceAction.stream, (_) async {
      if ((formKey.currentState?.validate() ?? false) &&
          _isAllFieldsFilledAndCorrect(
            placeType: placeTypeState.value,
            name: nameState.value.data,
            lat: latState.value.data,
            lon: lonState.value.data,
            description: descriptionState.value.data,
          )) {
        await _addNewPlace(
          placeType: placeTypeState.value!,
          name: nameState.value.data!,
          lon: lonState.value.data!,
          lat: latState.value.data!,
          description: descriptionState.value.data!,
        );

        _navigator.pop();
      }
    });
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

  /// Метод добавления нового места
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
    await _placeInteractor.addNewPlace(newPlace);
  }
}
