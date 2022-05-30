import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/place_details_screen/place_details_screen.dart';
import 'package:places/ui/screen/place_details_screen/place_details_screen_model.dart';
import 'package:places/utils/datetime_utils.dart';
import 'package:places/utils/deffered_execution_provider.dart';
import 'package:provider/provider.dart';

/// Фабрика для [PlaceDetailsWidgetModel]
PlaceDetailsWidgetModel placeDetailsScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = PlaceDetailsScreenModel(
    placeInteractor: dependencies.placeInteractor,
    errorHandler: dependencies.errorHandler,
  );

  return PlaceDetailsWidgetModel(
    model: model,
    themeWrapper: dependencies.themeWrapper,
  );
}

/// Виджет-модель для [PlaceDetailsScreenModel]
class PlaceDetailsWidgetModel
    extends WidgetModel<PlaceDetailsScreen, PlaceDetailsScreenModel>
    with DefferedExecutionProvider
    implements IPlaceDetailsScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  final _currentPlaceState = EntityStateNotifier<Place>();

  final ScrollController _scrollController = ScrollController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  ListenableState<EntityState<Place>> get currentPlaceState =>
      _currentPlaceState;

  PlaceDetailsWidgetModel({
    required PlaceDetailsScreenModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _currentPlaceState.content(widget.place);
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
    _theme = _themeWrapper.getTheme(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // /// Даем возможность евентлупу сначала выполнить события отрисовки анимации hero,
    // /// а потом после его текущей итерации выполняем запрос в сеть за инфой по месту.
    // /// Иначе анимация hero не успевает проиграться
    // Future.delayed(Duration.zero, _requestForPlaceDetails);
  }

  @override
  void onPlanPlacePressed(Place place) {
    DateTimeUtils.pickPlanDate(context).then((planDate) {
      if (planDate != null) {
        model.setPlacePlanDate(place: place, planDate: planDate);
        _requestForPlaceDetails();
      }
    });
  }

  @override
  void onAddPlaceInFavoritesPressed() {
    final currentPlace = _currentPlaceState.value?.data;
    if (currentPlace == null) return;

    model.changeFavorite(currentPlace);
    _requestForPlaceDetails();
  }

  @override
  void onSharePlacePressed(Place place) {}

  /// Обновление места (временная мера пока нет стейтменеджмента)
  Future<void> _requestForPlaceDetails() async {
    final currentPlace = _currentPlaceState.value?.data;

    if (currentPlace == null) return;
    /// Выполняем лоадинг отложенно через 1 секунду (на случай, если данные
    /// придут мгновенно, чтобы не показывать лоадер и не создать эффект мерцания)
    deffered(_currentPlaceState.loading);

    final place = await model.getPlaceDetails(currentPlace);
    cancelDeffered();

    _currentPlaceState.content(place);
  }
}

abstract class IPlaceDetailsScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Контроллер прокрутки
  ScrollController get scrollController;

  /// Состояние текущего просматриваемого места
  ListenableState<EntityState<Place>> get currentPlaceState;

  /// Обработчик планирования даты посещения места [place]
  void onPlanPlacePressed(Place place);

  /// Обработчик шеринга места [place]
  void onSharePlacePressed(Place place);

  /// Обработчик добавления места в избранное
  void onAddPlaceInFavoritesPressed();
}
