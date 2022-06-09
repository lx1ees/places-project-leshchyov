import 'package:elementary/elementary.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/storage/database/database.dart';
import 'package:places/data/storage/places_storage.dart';
import 'package:places/data/storage/search_history_storage.dart';
import 'package:places/data/storage/shared_preferences_storage.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/settings_manager.dart';
import 'package:places/environment/environment.dart';
import 'package:places/utils/default_error_handler.dart';

/// Окружение зависимостей, которые нужны на протяжении всего жизненного цикла приложения
class AppScope implements IAppScope {
  late final ErrorHandler _errorHandler;

  late final ThemeWrapper _themeWrapper;

  late final PlaceInteractor _placeInteractor;

  late final SearchInteractor _searchInteractor;

  late final SettingsManager _settingsManager;

  late final PlacesDatabase _database;

  late final Environment _environment;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  PlaceInteractor get placeInteractor => _placeInteractor;

  @override
  SearchInteractor get searchInteractor => _searchInteractor;

  @override
  SettingsManager get settingsManager => _settingsManager;

  @override
  ThemeWrapper get themeWrapper => _themeWrapper;

  @override
  Environment get environment => _environment;

  AppScope() {
    _environment = Environment.instance();
    _database = PlacesDatabase();
    final preferencesStorage = SharedPreferencesStorage();
    final searchHistoryStorage = SearchHistoryStorage(database: _database);
    final placeRepository = PlaceRepository(
      networkService: NetworkService(),
      filtersStorage: preferencesStorage,
      searchHistoryStorage: searchHistoryStorage,
      placesStorage: PlacesStorage(database: _database),
    );
    _errorHandler = DefaultErrorHandler();
    _themeWrapper = ThemeWrapper();
    _placeInteractor = PlaceInteractor(
      repository: placeRepository,
    );
    _searchInteractor = SearchInteractor(
      repository: placeRepository,
    );
    _settingsManager = SettingsManager(settingsStorage: preferencesStorage);
  }

  @override
  void dispose() {
    _database.close();
  }
}

/// Зависимости приложения
abstract class IAppScope {
  /// Обработчик ошибок
  ErrorHandler get errorHandler;

  /// Тема
  ThemeWrapper get themeWrapper;

  /// Бизнес-логика фичи Места
  PlaceInteractor get placeInteractor;

  /// Бизнес-логика фичи Поиск
  SearchInteractor get searchInteractor;

  /// Бизнес-логика фичи Настройки
  SettingsManager get settingsManager;

  /// Окружение
  Environment get environment;

  /// Обработчик очистки ресурсов (нужен для вызова очистки БД)
  void dispose();
}
