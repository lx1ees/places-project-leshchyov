import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_model.dart';
import 'package:places/utils/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Фабрика для [VisitingScreenWidgetModel]
VisitingScreenWidgetModel visitingScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = VisitingScreenModel(
    errorHandler: context.read<DefaultErrorHandler>(),
    placeInteractor: context.read<PlaceInteractor>(),
  );

  return VisitingScreenWidgetModel(
    model: model,
    themeWrapper: context.read<ThemeWrapper>(),
  );
}

/// Виджет-модель для [VisitingScreenModel]
class VisitingScreenWidgetModel
    extends WidgetModel<VisitingScreen, VisitingScreenModel>
    with TickerProviderWidgetModelMixin
    implements IVisitingScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Контроллер табов
  late final TabController _tabController;

  final _listFavoritePlacesEntityState = EntityStateNotifier<List<Place>>();
  final _listVisitedPlacesEntityState = EntityStateNotifier<List<Place>>();

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  TabController get tabController => _tabController;

  @override
  ListenableState<EntityState<List<Place>>> get listFavoritePlacesState =>
      _listFavoritePlacesEntityState;

  @override
  ListenableState<EntityState<List<Place>>> get listVisitedPlacesState =>
      _listVisitedPlacesEntityState;

  VisitingScreenWidgetModel({
    required VisitingScreenModel model,
    required ThemeWrapper themeWrapper,
  })  : _themeWrapper = themeWrapper,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
    _theme = _themeWrapper.getTheme(context);
    _tabController = TabController(length: 2, vsync: this);
    _requestForPlaces();
    _tabController.addListener(_requestForPlaces);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void onChangeOrderInFavorites(int fromIndex, int toIndex) {
    model.changeOrderInFavorites(
      fromIndex: fromIndex,
      toIndex: toIndex,
    );
    _requestForFavoritesPlaces();
  }

  @override
  void onChangeOrderInVisited(int fromIndex, int toIndex) {
    model.changeOrderInVisited(
      fromIndex: fromIndex,
      toIndex: toIndex,
    );
    _requestForVisitedPlaces();
  }

  @override
  void onDeleteFavoritePlacePressed(Place place) {
    model.removePlaceFromFavorites(place: place);
    _requestForFavoritesPlaces();
  }

  @override
  void onDeleteVisitedPlacePressed(Place place) {
    model.removePlaceFromVisited(place: place);
    _requestForVisitedPlaces();
  }

  @override
  void onPlaceCardPressed(Place place) {
    _openPlaceDetailsBottomSheet(place).then((_) {
      if (place.isInFavorites) {
        _requestForFavoritesPlaces();
      } else if (place.isVisited) {
        _requestForVisitedPlaces();
      }
    });
  }

  @override
  void onPlanPlacePressed(Place place) {
    _pickPlanDate().then((planDate) {
      if (planDate != null) {
        model.setPlacePlanDate(place: place, planDate: planDate);
        _requestForFavoritesPlaces();
      }
    });
  }

  /// Получение списков всех мест
  void _requestForPlaces() {
    _requestForFavoritesPlaces();
    _requestForVisitedPlaces();
  }

  /// Получение списка избранных мест
  void _requestForFavoritesPlaces() {
    _listFavoritePlacesEntityState.loading();
    try {
      final favoritePlaces = model.favoritePlaces();
      _listFavoritePlacesEntityState.content(favoritePlaces);
    } on Exception catch (e) {
      _listFavoritePlacesEntityState.error(e);
    }
  }

  /// Получение списка посещенных мест
  void _requestForVisitedPlaces() {
    _listVisitedPlacesEntityState.loading();
    try {
      final visitedPlaces = model.visitedPlaces();
      _listVisitedPlacesEntityState.content(visitedPlaces);
    } on Exception catch (e) {
      _listVisitedPlacesEntityState.error(e);
    }
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _openPlaceDetailsBottomSheet(
    Place place,
  ) async {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Theme.of(context).colorScheme.primary.withOpacity(0.24),
      isScrollControlled: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (_) {
        return PlaceDetailsBottomSheet(place: place);
      },
    );
  }

  Future<DateTime?> _pickPlanDate() async {
    final nowDate = DateTime.now();
    final nowYear = nowDate.year;

    return Platform.isIOS
        ? await _cupertinoDatePicker(nowDate, nowYear)
        : await _materialDatePicker(nowDate, nowYear);
  }

  Future<DateTime?> _materialDatePicker(
    DateTime nowDate,
    int nowYear,
  ) {
    return showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: nowDate,
      lastDate: DateTime(nowYear + 3),
      locale: AppConstants.locale,
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.apply,
      helpText: AppStrings.datePickerHelpText,
      fieldLabelText: AppStrings.datePickerFieldLabelText,
      builder: (context, child) {
        return Theme(
          data: _theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: _colorScheme.secondary,
              onPrimary: _theme.white,
              onSurface: _colorScheme.secondary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<DateTime?> _cupertinoDatePicker(
    DateTime nowDate,
    int nowYear,
  ) {
    return showCupertinoModalPopup<DateTime?>(
      builder: (context) {
        DateTime? dateTime;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                backgroundColor: Theme.of(context).colorScheme.surface,
                minimumDate: nowDate,
                initialDateTime: nowDate,
                maximumDate: DateTime(nowYear + 3),
                onDateTimeChanged: (dt) => dateTime = dt,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.defaultPaddingX2,
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, dateTime ?? nowDate),
                child: const Text(AppStrings.apply),
              ),
            ),
          ],
        );
      },
      context: context,
    );
  }
}

abstract class IVisitingScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Контроллер табов
  TabController get tabController;

  /// Состояние списка "Хочу посетить"
  ListenableState<EntityState<List<Place>>> get listFavoritePlacesState;

  /// Состояние списка "Посещенные места"
  ListenableState<EntityState<List<Place>>> get listVisitedPlacesState;

  /// Обработчик перемещения карточки в списке "Хочу посетить" с индекса
  /// [fromIndex] на индекс [toIndex]
  void onChangeOrderInFavorites(
    int fromIndex,
    int toIndex,
  );

  /// Обработчик перемещения карточки в списке "Посещенные места" с индекса
  /// [fromIndex] на индекс [toIndex]
  void onChangeOrderInVisited(
    int fromIndex,
    int toIndex,
  );

  /// Обработчик планирования даты посещения места [place]
  void onPlanPlacePressed(Place place);

  /// Обработчик удаления места [place] из списка избранного
  void onDeleteFavoritePlacePressed(Place place);

  /// Обработчик удаления места [place] из списка посещенных мест
  void onDeleteVisitedPlacePressed(Place place);

  /// Обработчик нажатия на карточку места [place]
  void onPlaceCardPressed(Place place);
}
