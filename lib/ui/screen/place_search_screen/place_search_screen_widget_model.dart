import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/app/di/app_scope.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen_model.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// Фабрика для [PlaceSearchScreenWidgetModel]
PlaceSearchScreenWidgetModel placeSearchScreenWidgetModelFactory(
  BuildContext context,
) {
  final dependencies = context.read<IAppScope>();
  final model = PlaceSearchScreenModel(
    errorHandler: dependencies.errorHandler,
    searchInteractor: dependencies.searchInteractor,
  );

  return PlaceSearchScreenWidgetModel(
    model: model,
    themeWrapper: dependencies.themeWrapper,
    navigator: Navigator.of(context),
  );
}

/// Виджет-модель для [PlaceSearchScreenModel]
class PlaceSearchScreenWidgetModel
    extends WidgetModel<PlaceSearchScreen, PlaceSearchScreenModel>
    implements IPlaceSearchScreenWidgetModel {
  /// Обертка над темой приложения
  final ThemeWrapper _themeWrapper;

  /// Цветовая схема текущей темы приложения
  late final ColorScheme _colorScheme;

  /// Текущая тема приложения
  late final ThemeData _theme;

  /// Контроллер ввода текста в строку поиска
  late final TextEditingController _searchController;

  /// Контроллер прокрутки списка с историей поиска
  late final ScrollController _scrollController;

  /// Поток вводимого текста для поиска (нужен для дебаунсинга)
  final _searchStream = PublishSubject<String>();

  /// Навигатор
  final NavigatorState _navigator;

  /// Фокус нода поисковой строки
  final FocusNode _focusNode = FocusNode();

  final _foundPlacesEntityState = EntityStateNotifier<List<Place>>();

  final _focusClearButtonState = StateNotifier<bool>();
  final _searchHistoryState = StateNotifier<List<String>>();

  @override
  ColorScheme get colorScheme => _colorScheme;

  @override
  ThemeData get theme => _theme;

  @override
  TextEditingController get searchController => _searchController;

  @override
  String get searchString => _searchString;

  @override
  ListenableState<EntityState<List<Place>>> get listFoundPlacesState =>
      _foundPlacesEntityState;

  @override
  ListenableState<bool> get searchBarClearButtonState => _focusClearButtonState;

  @override
  FocusNode get searchBarFocusNode => _focusNode;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  ListenableState<List<String>> get searchHistoryState => _searchHistoryState;

  /// Текущий поисковой запрос
  String _searchString = '';

  /// Предыдущий поисковой запрос
  String _previousSearchString = '';

  PlaceSearchScreenWidgetModel({
    required PlaceSearchScreenModel model,
    required ThemeWrapper themeWrapper,
    required NavigatorState navigator,
  })  : _themeWrapper = themeWrapper,
        _navigator = navigator,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _colorScheme = _themeWrapper.getTheme(context).colorScheme;
    _theme = _themeWrapper.getTheme(context);
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _searchController.addListener(_textChangesListener);
    _searchStream
        .debounceTime(const Duration(milliseconds: 500))
        .listen(_requestForSearchResults);
    _loadSearchHistory();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchStream.close();
    _searchController
      ..removeListener(_textChangesListener)
      ..dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void onBackButtonPressed() => _navigator.pop();

  @override
  void onPlaceCardPressed(Place place) => _navigateToPlaceDetailsScreen(place);

  @override
  void onHistoryItemPressed(String searchString) {
    _searchController
      ..text = searchString
      ..selection = TextSelection.collapsed(
        offset: searchString.length,
      );
  }

  @override
  Future<void> onHistoryCleared() async {
    await model.clearHistory();
    await _loadSearchHistory();
  }

  @override
  Future<void> onHistoryItemRemoved(String searchString) async {
    await model.removeFromHistory(searchString);
    await _loadSearchHistory();
  }

  /// Загрузка истории поиска мест
  Future<void> _loadSearchHistory() async {
    final searchHistory = await model.getHistory();
    _searchHistoryState.accept([...searchHistory]);
  }

  /// Поиск мест по запросу [searchString]
  Future<void> _requestForSearchResults(String searchString) async {
    _searchString = searchString;
    _foundPlacesEntityState.loading();
    try {
      final filtersManager = await model.getFiltersManager();
      final foundPlaces = await model.searchForPlaces(
        filtersManager: filtersManager,
        searchString: searchString,
        currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
      );
      _foundPlacesEntityState.content(foundPlaces);
    } on Exception catch (e) {
      _foundPlacesEntityState.error(e);
    }
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _navigateToPlaceDetailsScreen(Place place) async {
    await AppRoutes.navigateToPlaceDetailsScreen(
      context: context,
      place: place,
    );
  }

  void _textChangesListener() {
    if (_previousSearchString != _searchController.text) {
      _previousSearchString = _searchController.text;
      _textChangesHandler(_searchStream.add);
    }
  }

  void _textChangesHandler(ValueChanged<String>? onTextChangeListener) {
    final value = _searchController.text;
    if (onTextChangeListener != null) {
      onTextChangeListener(value);
      if (value.isEmpty) {
        _loadSearchHistory();
      }
    }
    _focusClearButtonState
        .accept(_focusNode.hasFocus && _searchController.text.isNotEmpty);
  }
}

abstract class IPlaceSearchScreenWidgetModel extends IWidgetModel {
  /// Цветовая схема текущей темы приложения
  ColorScheme get colorScheme;

  /// Текущая тема приложения
  ThemeData get theme;

  /// Контроллер ввода текста в строку поиска
  TextEditingController get searchController;

  /// Контроллер прокрутки истории поиска
  ScrollController get scrollController;

  /// Текущий поисковой запрос
  String get searchString;

  /// Фокус нода поисковой строки
  FocusNode get searchBarFocusNode;

  /// Состояние списка найденных мест
  ListenableState<EntityState<List<Place>>> get listFoundPlacesState;

  /// Состояние кнопки очистки строки поиска
  ListenableState<bool> get searchBarClearButtonState;

  /// Состояние истории поиска
  ListenableState<List<String>> get searchHistoryState;

  /// Обработчик нажатия на кнопку "Назад"
  void onBackButtonPressed();

  /// Обработчик нажатия на карточку места [place]
  void onPlaceCardPressed(Place place);

  /// Обработчик нажатия на позицию в истории поиска [searchString]
  void onHistoryItemPressed(String searchString);

  /// Обработчик удаления позиции в истории поиска [searchString]
  Future<void> onHistoryItemRemoved(String searchString);

  /// Обработчик очистки истории поиска
  Future<void> onHistoryCleared();
}
