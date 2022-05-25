import 'package:elementary/elementary.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/domain/settings_manager.dart';
import 'package:places/utils/default_error_handler.dart';

/// Окружение зависимостей, которые нужны на протяжении всего жизненного цикла приложения
class AppScope implements IAppScope {
  late final ErrorHandler _errorHandler;

  late final ThemeWrapper _themeWrapper;

  late final FiltersManager _filtersManager;

  late final SearchHistoryManager _searchHistoryManager;

  late final PlaceInteractor _placeInteractor;

  late final SearchInteractor _searchInteractor;

  late final SettingsManager _settingsManager;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  FiltersManager get filtersManager => _filtersManager;

  @override
  PlaceInteractor get placeInteractor => _placeInteractor;

  @override
  SearchHistoryManager get searchHistoryManager => _searchHistoryManager;

  @override
  SearchInteractor get searchInteractor => _searchInteractor;

  @override
  SettingsManager get settingsManager => _settingsManager;

  @override
  ThemeWrapper get themeWrapper => _themeWrapper;

  AppScope() {
    final placeRepository = PlaceRepository(NetworkService());
    _errorHandler = DefaultErrorHandler();
    _themeWrapper = ThemeWrapper();
    _filtersManager = FiltersManager();
    _searchHistoryManager = SearchHistoryManager();
    _placeInteractor = PlaceInteractor(
      repository: placeRepository,
    );
    _searchInteractor = SearchInteractor(
      repository: placeRepository,
      filtersManager: filtersManager,
      searchHistoryManager: searchHistoryManager,
    );
    _settingsManager = SettingsManager();
  }
}

/// Зависимости приложения
abstract class IAppScope {
  /// Обработчик ошибок
  ErrorHandler get errorHandler;

  /// Тема
  ThemeWrapper get themeWrapper;

  /// Менеджер фильтров
  FiltersManager get filtersManager;

  /// Менеджер истории поиска
  SearchHistoryManager get searchHistoryManager;

  /// Бизнес-логика фичи Места
  PlaceInteractor get placeInteractor;

  /// Бизнес-логика фичи Поиск
  SearchInteractor get searchInteractor;

  /// Бизнес-логика фичи Настройки
  SettingsManager get settingsManager;
}
