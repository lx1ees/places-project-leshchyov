import 'dart:async';

import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';

/// Интерастор фичи Список мест
class PlaceInteractor {
  /// Список мест для отображения на экране Список мест
  final List<Place> _places = [];

  /// Репозиторий списка мест
  final PlaceRepository _repository;

  PlaceInteractor({
    required PlaceRepository repository,
  }) : _repository = repository;

  /// Метод для получения списка мест от сервера на основе фильтров [filtersManager]
  Future<List<Place>> getPlaces({
    required FiltersManager filtersManager,
  }) async {
    try {
      late final List<PlaceDto> placeDtos;
      final currentLocation = _repository.currentUserLocation;

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
      final favoritePlaces = await getFavoritePlaces();
      final visitedPlaces = await getVisitedPlaces();

      /// Получили свежие места от сервера -> обновили их флаги (Избранное, Посетил)
      /// на основе существующего списка мест
      final modifiedRemotePlaces = _compareAndModifyPlaces(
        favoritePlaces: favoritePlaces,
        visitedPlaces: visitedPlaces,
        remotePlaces: remotePlaces,
        cardLook: CardLook.view,
      );

      _places
        ..clear()
        ..addAll(modifiedRemotePlaces);

      return _places;
    } on NetworkException catch (_) {
      rethrow;
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// Оставил пока старый метод для совместимости на других экранах
  /// Метод получения списка мест для отображения на жкране Список мест
  List<Place> getLocalPlaces() => _places;

  /// Метод получения списка мест, которые находятся в избранном
  Future<List<Place>> getFavoritePlaces() async {
    final favoritePlacesDtos = await _repository.getFavoritePlaces();

    return favoritePlacesDtos.map(PlaceMapper.fromLocalDto).toList();
  }

  /// Метод получения списка мест, которые находятся в избранном
  Future<List<Place>> getVisitedPlaces() async {
    final visitedPlacesDtos = await _repository.getVisitedPlaces();

    return visitedPlacesDtos.map(PlaceMapper.fromLocalDto).toList();
  }

  /// Метод добавления нового места
  Future<Place> addNewPlace(Place newPlace) async {
    final urls = await _repository.uploadImages(newPlace.urls);
    final addedPlaceDto = await _repository
        .addPlace(PlaceMapper.toDto(newPlace.copyWith(urls: urls)));

    return PlaceMapper.fromDto(addedPlaceDto);
  }

  /// Метод получения места по id
  Future<Place> getPlaceDetails({required Place place}) async {
    try {
      final placeDto = await _repository.getPlace(place.id.toString());
      final updatedPlace = PlaceMapper.fromDto(placeDto);
      final favoritePlaces = await getFavoritePlaces();
      final visitedPlaces = await getVisitedPlaces();

      final modifiedRemotePlaces = _compareAndModifyPlaces(
        favoritePlaces: favoritePlaces,
        visitedPlaces: visitedPlaces,
        remotePlaces: [updatedPlace],
        cardLook: place.cardLook,
      );

      return modifiedRemotePlaces[0];
    } on NetworkException catch (_) {
      return place;
    }
  }

  /// Метод добавления места в список посещенных
  Future<void> addPlaceInVisited(Place place) async {
    final visitedPlace = place.copyWith(
      isVisited: true,
      cardLook: CardLook.visited,
    );

    await _repository.upsertPlaceInVisitedPlaces(visitedPlace);
    final index = _places.indexOf(place);
    if (index != -1) {
      final localPlace = _places[index];
      _places[index] = localPlace.copyWith(isVisited: true);
    }
  }

  /// Метод добавления/удаления места в/из избранно-е/го
  Future<void> changeFavorite(Place place) async {
    if (place.isInFavorites) {
      await _removePlaceFromFavorites(place);
    } else {
      await _addPlaceInFavorites(place);
    }
  }

  /// Метод перемещения карточки в списке избранного
  /// [index] - позиция, куда переместить
  /// [placeToMove] - объект перемещения
  Future<void> movePlaceInFavorites({
    required int index,
    required Place placeToMove,
  }) async {
    await _repository.movePlaceInFavorites(
      index: index,
      placeToMove: placeToMove,
    );
  }

  /// Метод перемещения картчочки в списке посещенных мест
  /// [index] - позиция, куда переместить
  /// [placeToMove] - объект перемещения
  Future<void> movePlaceInVisited({
    required int index,
    required Place placeToMove,
  }) async {
    await _repository.movePlaceInVisited(
      index: index,
      placeToMove: placeToMove,
    );
  }

  /// Метод для установки даты посещения [planDate] месту из списка избранного
  Future<void> setPlanDate({
    required Place place,
    required DateTime? planDate,
  }) async {
    final newPlace = place.copyWith(planDate: planDate);
    await _repository.upsertPlaceInFavoritePlaces(newPlace);
  }

  /// Метод для сохранения значений фильтра [filtersManager] в локальное хранилище
  Future<void> saveFilterValues(FiltersManager filtersManager) async {
    await _repository.saveDistanceFilterValue(
      filtersManager.distanceFilter.distanceRightThreshold,
    );
    await _repository.savePlaceTypeFilterValue(
      filtersManager.placeTypeFilters.where((f) => f.isSelected),
    );
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

  /// Обновление текущего местоположения пользователя
  Future<void> updateCurrentLocation() async =>
      _repository.updateCurrentLocation();

  /// Получение текущего местоположения пользователя (сохраненное)
  Future<LocationPoint?> getCurrentLocation() async => _repository.currentUserLocation;

  /// Метод добавления места в список избранного
  Future<void> _addPlaceInFavorites(Place place) async {
    final favoritePlace = place.copyWith(
      isInFavorites: true,
      cardLook: CardLook.toVisit,
    );

    await _repository.upsertPlaceInFavoritePlaces(favoritePlace);
    final index = _places.indexOf(place);
    if (index != -1) {
      final localPlace = _places[index];
      _places[index] = localPlace.copyWith(isInFavorites: true);
    }
  }

  /// Метод удаления места из списка избраннога
  Future<void> _removePlaceFromFavorites(Place place) async {
    await _repository.deleteFromFavoritePlaces(place.id);
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
}
