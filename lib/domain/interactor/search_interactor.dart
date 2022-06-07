import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';

/// Интерактор фичи Поиск
class SearchInteractor {
  /// Список найденных мест
  final List<Place> _places = [];

  /// Репозиторий списка мест
  final PlaceRepository _repository;

  /// История поиска
  final List<String> _successSearches = [];

  SearchInteractor({
    required PlaceRepository repository,
  }) : _repository = repository;

  /// Метод для поиска мест по поисковому запросу [searchString], учитывая фильтры
  /// из [filtersManager]
  Future<List<Place>> getSearchResults({
    required FiltersManager filtersManager,
    required String searchString,
  }) async {
    late final List<PlaceDto> placeDtos;
    final currentLocation = _repository.currentUserLocation;

    placeDtos = currentLocation != null
        ? await _repository.getFilteredPlaces(
            locationPoint: currentLocation,
            filtersManager: filtersManager,
            searchString: searchString,
          )
        : await _repository.getFilteredPlacesWithoutLocation(
            filtersManager: filtersManager,
            searchString: searchString,
          )
      ..sort((a, b) => a.distance?.compareTo(b.distance ?? 0) ?? -1);

    final places = placeDtos.map(PlaceMapper.fromDto).toList();
    _places
      ..clear()
      ..addAll(places);

    if (_places.isNotEmpty && searchString.isNotEmpty) {
      await _addInHistory(searchString);
    }

    return places;
  }

  Future<List<String>> loadSearchHistory() async {
    final searchHistory = await _repository.getSearchHistoryValue() ?? [];
    _successSearches
      ..clear()
      ..addAll(searchHistory);

    return _successSearches;
  }

  /// Метод удаления элемента из истории поиска
  Future<void> remove(String searchString) async {
    _successSearches.remove(searchString);
    await _repository.saveSearchHistoryValue(_successSearches);
  }

  /// Метод очистки истории поиска
  Future<void> clearHistory() async {
    _successSearches.clear();
    await _repository.saveSearchHistoryValue(_successSearches);
  }

  /// Метод для получения значений фильтра из локального хранилища
  Future<FiltersManager> getFiltersManager() async {
    final distance = await _repository.getDistanceFilterValue();
    final activePlaceTypes = await _repository.getPlaceTypeFilterValue();
    final placeTypes = PlaceTypeFilterEntity.availablePlaceTypeFilters
        .map((e) => e.copyWith(isSelected: activePlaceTypes?.contains(e)))
        .toList();

    return FiltersManager.from(distance: distance, placeTypes: placeTypes);
  }

  /// Метод обновления истории поиска
  Future<void> _addInHistory(String searchString) async {
    final isAlreadyRegistered = _successSearches.contains(searchString);
    if (isAlreadyRegistered) {
      /// Удаляем существующую запись и вставляем снова, тем самым поднимая ее наверх
      _successSearches.remove(searchString);
    }
    _successSearches.insert(0, searchString);
    await _repository.saveSearchHistoryValue(_successSearches);
  }
}
