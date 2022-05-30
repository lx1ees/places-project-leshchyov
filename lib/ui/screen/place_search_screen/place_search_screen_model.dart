import 'package:elementary/elementary.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/search_history_manager.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen.dart';

/// Модель для [PlaceSearchScreen]
class PlaceSearchScreenModel extends ElementaryModel {
  final SearchInteractor _searchInteractor;

  /// Менеджер истории поиска
  SearchHistoryManager get searchHistoryManager =>
      _searchInteractor.searchHistoryManager;

  PlaceSearchScreenModel({
    required SearchInteractor searchInteractor,
    required ErrorHandler errorHandler,
  })  : _searchInteractor = searchInteractor,
        super(errorHandler: errorHandler);

  /// Поиск мест по запросу [searchString] в текущем местоположении [currentLocation]
  /// и с учетом фильтров [filtersManager]
  Future<List<Place>> searchForPlaces({
    required FiltersManager filtersManager,
    required String searchString,
    LocationPoint? currentLocation,
  }) {
    try {
      return _searchInteractor.getSearchResults(
        filtersManager: filtersManager,
        currentLocation: currentLocation,
        searchString: searchString,
      );
    } on NetworkException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Получение истории поиска
  List<String> getHistory() => searchHistoryManager.load();

  /// Очистка истории поиска
  List<String> clearHistory() => searchHistoryManager.clearHistory();

  /// Удаление элемента [toRemove] в истории поиска
  List<String> removeFromHistory(String toRemove) =>
      searchHistoryManager.remove(toRemove);

  /// Метод получения фильтров
  Future<FiltersManager> getFiltersManager() async =>
      _searchInteractor.getFiltersManager();
}
