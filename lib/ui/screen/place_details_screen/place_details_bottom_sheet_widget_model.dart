import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet_model.dart';
import 'package:places/utils/datetime_utils.dart';
import 'package:places/utils/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Фабрика для [PlaceDetailsBottomSheetWidgetModel]
PlaceDetailsBottomSheetWidgetModel placeDetailsBottomSheetWidgetModelFactory(
  BuildContext context,
) {
  final model = PlaceDetailsBottomSheetModel(
    placeInteractor: context.read<PlaceInteractor>(),
    errorHandler: context.read<DefaultErrorHandler>(),
  );

  return PlaceDetailsBottomSheetWidgetModel(
    model: model,
    themeWrapper: context.read<ThemeWrapper>(),
  );
}

/// Виджет-модель для [PlaceDetailsBottomSheetModel]
class PlaceDetailsBottomSheetWidgetModel
    extends WidgetModel<PlaceDetailsBottomSheet, PlaceDetailsBottomSheetModel>
    implements IPlaceDetailsBottomSheetWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  final _isExpandedState = StateNotifier<bool>();

  final _currentPlaceState = StateNotifier<Place>();

  final DraggableScrollableController _scrollController =
      DraggableScrollableController();

  @override
  DraggableScrollableController get scrollController => _scrollController;

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  ListenableState<Place> get currentPlaceState => _currentPlaceState;

  @override
  ListenableState<bool> get isExpandedState => _isExpandedState;

  PlaceDetailsBottomSheetWidgetModel({
    required PlaceDetailsBottomSheetModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _currentPlaceState.accept(widget.place);
    _isExpandedState.accept(widget.isExpanded);
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
    _theme = _themeWrapper.getTheme(context);
    _requestForPlaceDetails();
  }

  @override
  bool onDraggableScrollableNotification(
    DraggableScrollableNotification notification,
  ) {
    _setExpanded(notification.maxExtent - notification.extent < 0.001);

    return true;
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
    final currentPlace = _currentPlaceState.value;
    if (currentPlace == null) return;

    model.changeFavorite(currentPlace);
    _requestForPlaceDetails();
  }

  @override
  void onSharePlacePressed(Place place) {}

  /// Обновление места (временная мера пока нет стейтменеджмента)
  Future<void> _requestForPlaceDetails() async {
    final currentPlace = _currentPlaceState.value;

    if (currentPlace == null) return;

    final place = await model.getPlaceDetails(currentPlace);
    _currentPlaceState.accept(place);
  }

  /// Установка состояния признака развертки боттом шита
  void _setExpanded(bool isExpanded) {
    if (_isExpandedState.value != isExpanded) {
      _isExpandedState.accept(isExpanded);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            isExpanded ? _theme.backgroundColor : Colors.transparent,
      ));
    }
  }
}

abstract class IPlaceDetailsBottomSheetWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Контроллер боттом шита
  DraggableScrollableController get scrollController;

  /// Состояние развертки боттом шита на весь экран
  ListenableState<bool> get isExpandedState;

  /// Состояние текущего просматриваемого места
  ListenableState<Place> get currentPlaceState;

  /// Обработчик нотификации о скролле боттом шита
  bool onDraggableScrollableNotification(
    DraggableScrollableNotification notification,
  );

  /// Обработчик планирования даты посещения места [place]
  void onPlanPlacePressed(Place place);

  /// Обработчик шеринга места [place]
  void onSharePlacePressed(Place place);

  /// Обработчик добавления места в избранное
  void onAddPlaceInFavoritesPressed();
}
