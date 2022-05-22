import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/ui/screen/place_details_screen/place_details_bottom_sheet.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen_model.dart';
import 'package:places/utils/default_error_handler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// Фабрика для [PlaceSearchScreenWidgetModel]
PlaceSearchScreenWidgetModel placeSearchScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = PlaceSearchScreenModel(
    errorHandler: context.read<DefaultErrorHandler>(),
    searchInteractor: context.read<SearchInteractor>(),
  );

  return PlaceSearchScreenWidgetModel(
    model: model,
    themeWrapper: context.read<ThemeWrapper>(),
    navigator: Navigator.of(context),
    filtersManager: context.read<FiltersManager>(),
  );
}

/// Виджет-модель для [PlaceSearchScreenModel]
class PlaceSearchScreenWidgetModel
    extends WidgetModel<PlaceSearchScreen, PlaceSearchScreenModel>
    implements IPlaceSearchScreenWidgetModel {
  /// Менеджер фильтров
  final FiltersManager _filtersManager;

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
  SearchHistoryManager get searchHistoryManager => model.searchHistoryManager;

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
    required FiltersManager filtersManager,
    required ThemeWrapper themeWrapper,
    required NavigatorState navigator,
  })  : _themeWrapper = themeWrapper,
        _filtersManager = filtersManager,
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
    _searchHistoryState.accept([...model.getHistory()]);
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
  void onPlaceCardPressed(Place place) => _openPlaceDetailsBottomSheet(place);

  @override
  void onHistoryItemPressed(String searchString) {
    _searchController
      ..text = searchString
      ..selection = TextSelection.collapsed(
        offset: searchString.length,
      );
  }

  @override
  void onHistoryCleared() {
    final history = model.clearHistory();
    _searchHistoryState.accept([...history]);
  }

  @override
  void onHistoryItemRemoved(String searchString) {
    final history = model.removeFromHistory(searchString);
    _searchHistoryState.accept([...history]);
  }

  /// Поиск мест по запросу [searchString]
  Future<void> _requestForSearchResults(String searchString) async {
    _searchString = searchString;
    _foundPlacesEntityState.loading();
    try {
      final foundPlaces = await model.searchForPlaces(
        filtersManager: _filtersManager,
        searchString: searchString,
        currentLocation: const LocationPoint(lat: 55.752881, lon: 37.604459),
      );
      _foundPlacesEntityState.content(foundPlaces);
    } on Exception catch (e) {
      _foundPlacesEntityState.error(e);
    }
  }

  /// Метод открытия окна детальной информации о месте
  Future<void> _openPlaceDetailsBottomSheet(Place place) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: _colorScheme.primary.withOpacity(0.24),
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) {
        return PlaceDetailsBottomSheet(place: place, isExpanded: true);
      },
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
        _searchHistoryState.accept([...model.getHistory()]);
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

  /// Менеджер истории поиска
  SearchHistoryManager get searchHistoryManager;

  /// Обработчик нажатия на кнопку "Назад"
  void onBackButtonPressed();

  /// Обработчик нажатия на карточку места [place]
  void onPlaceCardPressed(Place place);

  /// Обработчик нажатия на позицию в истории поиска [searchString]
  void onHistoryItemPressed(String searchString);

  /// Обработчик удаления позиции в истории поиска [searchString]
  void onHistoryItemRemoved(String searchString);

  /// Обработчик очистки истории поиска
  void onHistoryCleared();
}
