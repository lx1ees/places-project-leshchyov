import 'package:elementary/elementary.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_search_screen/place_search_screen.dart';

/// Модель для [PlaceSearchScreen]
class PlaceSearchScreenModel extends ElementaryModel {
  final SearchInteractor _searchInteractor;

  PlaceSearchScreenModel({
    required SearchInteractor searchInteractor,
    required ErrorHandler errorHandler,
  })  : _searchInteractor = searchInteractor,
        super(errorHandler: errorHandler);

  /// Поиск мест по запросу [searchString] в текущем местоположении
  /// и с учетом фильтров [filtersManager]
  Future<List<Place>> searchForPlaces({
    required FiltersManager filtersManager,
    required String searchString,
  }) {
    try {
      return _searchInteractor.getSearchResults(
        filtersManager: filtersManager,
        searchString: searchString,
      );
    } on NetworkException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Получение истории поиска
  Future<List<String>> getHistory() async => _searchInteractor.loadSearchHistory();

  /// Очистка истории поиска
  Future<void> clearHistory() => _searchInteractor.clearHistory();

  /// Удаление элемента [toRemove] в истории поиска
  Future<void> removeFromHistory(String toRemove) =>
      _searchInteractor.remove(toRemove);

  /// Метод получения фильтров
  Future<FiltersManager> getFiltersManager() async =>
      _searchInteractor.getFiltersManager();
}
