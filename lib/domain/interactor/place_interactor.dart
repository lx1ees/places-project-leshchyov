import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';

class PlaceInteractor {
  final List<Place> _places = [];
  final PlaceRepository _repository;

  PlaceInteractor({
    required PlaceRepository repository,
  }) : _repository = repository;

  Future<List<Place>> getPlaces({
    required FiltersManager filtersManager,
    LocationPoint? currentLocation,
  }) async {
    late final List<PlaceDto> placeDtos;
    if (currentLocation != null) {
      placeDtos = await _repository.getFilteredPlaces(
        locationPoint: currentLocation,
        filtersManager: filtersManager,
      );
    } else if (filtersManager.isFiltersApplied) {
      placeDtos = await _repository.getFilteredPlacesWithoutLocation(
        filtersManager: filtersManager,
      );
    } else {
      placeDtos = await _repository.getPlaces();
    }
    placeDtos.sort((a, b) => a.distance?.compareTo(b.distance ?? 0) ?? -1);

    final remotePlaces = placeDtos.map(Place.fromDto).toList();
    final modifiedRemotePlaces = _compareAndModifyPlaces(
      localPlaces: _places,
      remotePlaces: remotePlaces,
    );

    _places
      ..clear()
      ..addAll(modifiedRemotePlaces);

    return _places;
  }

  List<Place> getLocalPlaces() => _places;

  Future<Place> getPlaceDetails({required String placeId}) async {
    final placeDto = await _repository.getPlace(placeId);

    return Place.fromDto(placeDto);
  }

  Future<Place> addNewPlace(Place newPlace) async {
    final addedPlaceDto = await _repository.addPlace(newPlace.toDto());

    return Place.fromDto(addedPlaceDto);
  }

  List<Place> getFavoritePlaces() {
    return _places.where((place) => place.isInFavorites).toList();
  }

  List<Place> getVisitedPlaces() {
    return _places.where((place) => place.isVisited).toList();
  }


  void addPlaceInVisited(Place place) {
    final index = _places.indexOf(place);
    if (index != -1) {
      _places[index] = place.copyWith(isVisited: true);
    }
  }

  void removePlaceFromVisited(Place place) {
    final index = _places.indexOf(place);
    if (index != -1) {
      _places[index] = place.copyWith(isVisited: false);
    }
  }

  void changeFavorite(Place place){
    if (place.isInFavorites){
      _removePlaceFromFavorites(place);
    } else {
      _addPlaceInFavorites(place);
    }
  }

  void _addPlaceInFavorites(Place place) {
    final index = _places.indexOf(place);
    if (index != -1) {
      _places[index] = place.copyWith(isInFavorites: true);
    }
  }

  void _removePlaceFromFavorites(Place place) {
    final index = _places.indexOf(place);
    if (index != -1) {
      _places[index] = place.copyWith(isInFavorites: false);
    }
  }

  List<Place> _compareAndModifyPlaces({
    required List<Place> localPlaces,
    required List<Place> remotePlaces,
  }) {
    return remotePlaces.map((remotePlace) {
      final localPlaceIndex = localPlaces
          .indexWhere((localPlace) => localPlace.id == remotePlace.id);
      if (localPlaceIndex != -1) {
        final localPlace = localPlaces[localPlaceIndex];

        return remotePlace.copyWith(
          isInFavorites: localPlace.isInFavorites,
          isVisited: localPlace.isVisited,
          planDate: localPlace.planDate,
        );
      }

      return remotePlace;
    }).toList();
  }
}
