import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/search_history_manager.dart';

class SearchInteractor {
  final List<Place> _places = [];
  final PlaceRepository _repository;
  final FiltersManager _filtersManager;
  final SearchHistoryManager _searchHistoryManager = SearchHistoryManager();

  FiltersManager get filtersManager => _filtersManager;

  SearchHistoryManager get searchHistoryManager => _searchHistoryManager;

  SearchInteractor({
    required PlaceRepository repository,
    required FiltersManager filtersManager,
  })  : _repository = repository,
        _filtersManager = filtersManager;

  Future<List<Place>> getSearchResults({
    required FiltersManager filtersManager,
    required String searchString,
    LocationPoint? currentLocation,
  }) async {
    late final List<PlaceDto> placeDtos;
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

    final places = placeDtos.map(Place.fromDto).toList();
    _places
      ..clear()
      ..addAll(places);

    if (_places.isNotEmpty && searchString.isNotEmpty) {
      _searchHistoryManager.addInHistory(searchString);
    }

    return places;
  }
}
