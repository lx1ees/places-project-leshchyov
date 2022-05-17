import 'dart:async';

import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';

/// Интерастор фичи Список мест
class PlaceInteractor {
  /// Список мест для отображения на экране Список мест
  final List<Place> _places = [];

  /// Список мест, которые находятся в Избранном
  final List<Place> _favoritePlaces = [];

  /// Список мест, которые находятся в Посетил
  final List<Place> _visitedPlaces = [];

  /// Репозиторий списка мест
  final PlaceRepository _repository;

  Stream<List<Place>> get placesStream => _placesController.stream;

  StreamController<List<Place>> _placesController =
      StreamController<List<Place>>();

  PlaceInteractor({
    required PlaceRepository repository,
  }) : _repository = repository;

  void disposePlacesStream() {
    _placesController.close();
  }

  /// Метод для получения списка мест от сервера на основе фильтров [filtersManager]
  /// и текущего местоположения [currentLocation]
  Future<void> requestPlaces({
    required FiltersManager filtersManager,
    LocationPoint? currentLocation,
  }) async {
    try {
      _initPlacesStreamController();
      _placesController.sink.add([]);
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

      final remotePlaces = placeDtos.map(PlaceMapper.fromDto).toList();

      /// Получили свежие места от сервера -> обновили их флаги (Избранное, Посетил)
      /// на основе существующего списка мест
      final modifiedRemotePlaces = _compareAndModifyPlaces(
        favoritePlaces: _favoritePlaces,
        visitedPlaces: _visitedPlaces,
        remotePlaces: remotePlaces,
        cardLook: CardLook.view,
      );

      _places
        ..clear()
        ..addAll(modifiedRemotePlaces);

      _placesController.sink.add(_places);
    } on NetworkException catch (e) {
      _placesController.sink.addError(e);
    }
  }

  /// Оставил пока старый метод для совместимости на других экранах
  /// Метод для получения списка мест от сервера на основе фильтров [filtersManager]
  /// и текущего местоположения [currentLocation]
  Future<List<Place>> getPlaces({
    required FiltersManager filtersManager,
    LocationPoint? currentLocation,
  }) async {
    try {
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

      final remotePlaces = placeDtos.map(PlaceMapper.fromDto).toList();

      /// Получили свежие места от сервера -> обновили их флаги (Избранное, Посетил)
      /// на основе существующего списка мест
      final modifiedRemotePlaces = _compareAndModifyPlaces(
        favoritePlaces: _favoritePlaces,
        visitedPlaces: _visitedPlaces,
        remotePlaces: remotePlaces,
        cardLook: CardLook.view,
      );

      _places
        ..clear()
        ..addAll(modifiedRemotePlaces);

      return _places;
    } on NetworkException catch (_) {
      return [];
    }
  }

  /// Оставил пока старый метод для совместимости на других экранах
  /// Метод получения списка мест для отображения на жкране Список мест
  List<Place> getLocalPlaces() => _places;

  /// Метод получения списка мест для отображения на жкране Список мест
  void requestLocalPlaces() {
    _initPlacesStreamController();
    _placesController.sink.add(_places);
  }

  /// Метод получения списка мест, которые находятся в избранном
  List<Place> getFavoritePlaces() {
    return _favoritePlaces;
  }

  /// Метод получения списка мест, которые находятся в избранном
  List<Place> getVisitedPlaces() {
    return _visitedPlaces;
  }

  /// Метод добавления нового места
  Future<Place> addNewPlace(Place newPlace) async {
    try {
      final addedPlaceDto =
          await _repository.addPlace(PlaceMapper.toDto(newPlace));

      return PlaceMapper.fromDto(addedPlaceDto);
    } on NetworkException catch (_) {
      return newPlace;
    }
  }

  /// Метод получения места по id
  Future<Place> getPlaceDetails({required Place place}) async {
    try {
      final placeDto = await _repository.getPlace(place.id.toString());
      final updatedPlace = PlaceMapper.fromDto(placeDto);

      final modifiedRemotePlaces = _compareAndModifyPlaces(
        favoritePlaces: _favoritePlaces,
        visitedPlaces: _visitedPlaces,
        remotePlaces: [updatedPlace],
        cardLook: place.cardLook,
      );

      return modifiedRemotePlaces[0];
    } on NetworkException catch (_) {
      return place;
    }
  }

  /// Метод добавления места в список посещенных
  void addPlaceInVisited(Place place) {
    final visitedPlace = place.copyWith(
      isVisited: true,
      cardLook: CardLook.visited,
    );
    if (!_visitedPlaces.contains(place)) _visitedPlaces.add(visitedPlace);
  }

  /// Метод удаления места из списка посещенных
  void removePlaceFromVisited(Place place) {
    _visitedPlaces.removeWhere((p) => p.id == place.id);
  }

  /// Метод добавления/удаления места в/из избранно-е/го
  void changeFavorite(Place place) {
    if (place.isInFavorites) {
      _removePlaceFromFavorites(place);
    } else {
      _addPlaceInFavorites(place);
    }
  }

  /// Метод перемещения картчочки в списке избранного
  /// [index] - позиция, куда переместить
  /// [placeToMove] - объект перемещения
  void movePlaceInFavorites({
    required int index,
    required Place placeToMove,
  }) {
    _favoritePlaces
      ..removeWhere((place) => place.id == placeToMove.id)
      ..insert(index, placeToMove);
  }

  /// Метод перемещения картчочки в списке посещенных мест
  /// [index] - позиция, куда переместить
  /// [placeToMove] - объект перемещения
  void movePlaceInVisited({
    required int index,
    required Place placeToMove,
  }) {
    _visitedPlaces
      ..removeWhere((place) => place.id == placeToMove.id)
      ..insert(index, placeToMove);
  }

  /// Метод для установки даты посещения [planDate] месту из списка избранного
  void setPlanDate({
    required Place place,
    required DateTime? planDate,
  }) {
    final indexFavorite = _favoritePlaces.indexOf(place);
    if (indexFavorite != -1) {
      _favoritePlaces[indexFavorite] = place.copyWith(planDate: planDate);
    }
  }

  /// Метод добавления места в список избранного
  void _addPlaceInFavorites(Place place) {
    final favoritePlace = place.copyWith(
      isInFavorites: true,
      cardLook: CardLook.toVisit,
    );
    if (!_favoritePlaces.contains(place)) _favoritePlaces.add(favoritePlace);
    final index = _places.indexOf(place);
    if (index != -1) {
      final localPlace = _places[index];
      _places[index] = localPlace.copyWith(isInFavorites: true);
    }
  }

  /// Метод удаления места из списка избраннога
  void _removePlaceFromFavorites(Place place) {
    _favoritePlaces
        .removeWhere((favoritePlace) => favoritePlace.id == place.id);
    final index = _places.indexOf(place);
    if (index != -1) {
      final localPlace = _places[index];
      _places[index] = localPlace.copyWith(isInFavorites: false);
    }
  }

  /// Метод для сравнения свежего списка мест из сети с существующими списками мест
  /// и его обновления. Чтобы свежие места не перезаписывали флаги В избранном, Посещенное
  /// [cardLook] - тип карточки
  List<Place> _compareAndModifyPlaces({
    required List<Place> favoritePlaces,
    required List<Place> visitedPlaces,
    required List<Place> remotePlaces,
    required CardLook cardLook,
  }) {
    return remotePlaces.map((remotePlace) {
      var updatedPlace = remotePlace;
      final favoritePlace = favoritePlaces.firstWhere(
        (favoritePlace) => favoritePlace.id == remotePlace.id,
        orElse: () => updatedPlace,
      );
      final visitedPlace = visitedPlaces.firstWhere(
        (visitedPlace) => visitedPlace.id == remotePlace.id,
        orElse: () => updatedPlace,
      );
      updatedPlace = updatedPlace.copyWith(
        isInFavorites: favoritePlace.isInFavorites,
        isVisited: visitedPlace.isVisited,
        planDate: favoritePlace.planDate,
        cardLook: cardLook,
      );

      return updatedPlace;
    }).toList();
  }

  void _initPlacesStreamController() {
    if (_placesController.isClosed) {
      _placesController = StreamController<List<Place>>();
    }
  }
}
