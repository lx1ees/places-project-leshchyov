import 'dart:async';

import 'package:dio/dio.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/place_local_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/storage/filters_storage.dart';
import 'package:places/data/storage/places_storage.dart';
import 'package:places/data/storage/search_history_storage.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';

/// Репозиторий мест
class PlaceRepository {
  final NetworkService networkService;
  final IFiltersStorage filtersStorage;
  final ISearchHistoryStorage searchHistoryStorage;
  final IPlacesStorage placesStorage;

  /// Список мест, которые находятся в Избранном
  final List<PlaceLocalDto> _favoritePlaces = [];

  PlaceRepository({
    required this.networkService,
    required this.filtersStorage,
    required this.searchHistoryStorage,
    required this.placesStorage,
  });

  /// Метод для запроса из сети списка мест с фильтрами из [filtersManager] и
  /// поисковой строкой [searchString], который вызывается, если недоступно
  /// местоположение пользователя
  Future<List<PlaceDto>> getFilteredPlacesWithoutLocation({
    required FiltersManager filtersManager,
    String? searchString,
  }) {
    final requestBody = PlacesFilterRequestDto(
      typeFilter: filtersManager.placeTypeFilterIds,
      nameFilter: searchString,
    );

    return _getFilteredPlaces(requestBody: requestBody);
  }

  /// Метод для запроса из сети списка мест с фильтрами из [filtersManager] и
  /// поисковой строкой [searchString], который вызывается, если доступно
  /// местоположение пользователя [locationPoint]
  Future<List<PlaceDto>> getFilteredPlaces({
    required LocationPoint locationPoint,
    required FiltersManager filtersManager,
    String? searchString,
  }) {
    final requestBody = PlacesFilterRequestDto(
      lat: locationPoint.lat,
      lng: locationPoint.lon,
      radius: filtersManager.distanceFilter.distanceRightThreshold,
      typeFilter: filtersManager.placeTypeFilterIds,
      nameFilter: searchString,
    );

    return _getFilteredPlaces(requestBody: requestBody);
  }

  /// Метод для запроса из сети списка всех мест без фильтрации
  Future<List<PlaceDto>> getPlaces() async {
    try {
      final response = await networkService.client.get<Object>(
        AppConstants.placesPath,
      );

      return (response.data as List<Object?>).map<PlaceDto>((raw) {
        return PlaceDto.fromJson(raw as Map<String, dynamic>);
      }).toList();
    } on DioError catch (e) {
      throw NetworkException(
        requestName: '${AppConstants.baseUrl}${AppConstants.placesPath}',
        code: e.response?.statusCode,
        errorMessage: e.message,
      );
    }
  }

  /// Метода для добавления нового места [place] на сервер
  Future<PlaceDto> addPlace(PlaceDto place) async {
    try {
      final response = await networkService.client.post<Object>(
        AppConstants.placesPath,
        data: place.toJson(),
      );

      return PlaceDto.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw NetworkException(
        requestName: '${AppConstants.baseUrl}${AppConstants.placesPath}',
        code: e.response?.statusCode,
        errorMessage: e.message,
      );
    }
  }

  /// Метод для получения места из сервера по id [id]
  Future<PlaceDto> getPlace(String id) async {
    try {
      final response = await networkService.client.get<Object>(
        '${AppConstants.placesPath}/$id',
      );

      return PlaceDto.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw NetworkException(
        requestName: '${AppConstants.baseUrl}${AppConstants.placesPath}/$id',
        code: e.response?.statusCode,
        errorMessage: e.message,
      );
    }
  }

  /// Метод для удаления места на сервере по id [id]
  Future<bool> deletePlace(String id) async {
    try {
      await networkService.client.delete<Object>(
        '${AppConstants.placesPath}/$id',
      );

      return true;
    } on DioError catch (e) {
      throw NetworkException(
        requestName: '${AppConstants.baseUrl}${AppConstants.placesPath}/$id',
        code: e.response?.statusCode,
        errorMessage: e.message,
      );
    }
  }

  /// Метод для обновления места [place] на сервере
  Future<PlaceDto> updatePlace(PlaceDto place) async {
    try {
      final response = await networkService.client.put<Object>(
        '${AppConstants.placesPath}/${place.id}',
        data: place.toJson(),
      );

      return PlaceDto.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw NetworkException(
        requestName:
            '${AppConstants.baseUrl}${AppConstants.placesPath}/${place.id}',
        code: e.response?.statusCode,
        errorMessage: e.message,
      );
    }
  }

  /// Получение из локального хранилища значения фильтра по дистанции
  Future<double?> getDistanceFilterValue() async =>
      filtersStorage.readDistance();

  /// Получение из локального хранилища значения фильтра по типу места
  Future<Iterable<PlaceTypeFilterEntity>?> getPlaceTypeFilterValue() async {
    final ids = await filtersStorage.readPlaceTypeIds();
    if (ids == null) return null;

    return PlaceTypeFilterEntity.listByIds(ids);
  }

  /// Получение из локального хранилища значения истории поиска
  Future<List<String>?> getSearchHistoryValue() async {
    return searchHistoryStorage.readSearchHistory();
  }

  /// Сохранение в локальное хранилище значения фильтра по дистанции
  Future<bool> saveDistanceFilterValue(double distance) async =>
      filtersStorage.writeDistance(distance);

  /// Сохранение в локальное хранилище значения фильтра по типу места
  Future<bool> savePlaceTypeFilterValue(
    Iterable<PlaceTypeFilterEntity> distance,
  ) async {
    final ids = distance.map((e) => e.placeType.id).toList();

    return filtersStorage.writePlaceTypeIds(ids);
  }

  /// Сохранение в локальное хранилище значения истории поиска
  Future<bool> saveSearchHistoryValue(
    List<String> searchHistory,
  ) async {
    return searchHistoryStorage.writeSearchHistory(searchHistory);
  }

  /// Метод перемещения карточки в списке избранного
  /// [index] - позиция, куда переместить
  /// [placeToMove] - объект перемещения
  Future<void> movePlaceInFavorites({
    required int index,
    required Place placeToMove,
  }) async {
    _favoritePlaces
      ..removeWhere((place) => place.id == placeToMove.id)
      ..insert(index, PlaceMapper.toLocalDto(placeToMove));
  }

  /// Получение списка избранных мест
  Future<List<PlaceLocalDto>> getFavoritePlaces() async {
    final localFavoritePlaces = await placesStorage.readFavoritePlaces();

    _compareAndSortPlaces(
      incomingPlaces: localFavoritePlaces,
      target: _favoritePlaces,
    );

    return _favoritePlaces;
  }

  /// Вставка или обновление места в списке избранных
  Future<void> upsertPlaceInFavoritePlaces(Place place) async =>
      placesStorage.upsertInFavoritePlaces(PlaceMapper.toLocalDto(place));

  /// Удаление места из списка избранных
  Future<void> deleteFromFavoritePlaces(int placeId) async =>
      placesStorage.deleteFromFavoritePlaces(placeId);

  void _compareAndSortPlaces({
    required List<PlaceLocalDto> incomingPlaces,
    required List<PlaceLocalDto> target,
  }) {
    /// Обвновляем локальный список избранных мест с учетом предыдущей сортировки
    /// (нужно для корректной работы функционала изменения порядка мест в списке)
    target.removeWhere(
      (e) => incomingPlaces.indexWhere((l) => l.id == e.id) == -1,
    );
    for (final localPlace in incomingPlaces) {
      final index = target.indexWhere((e) => e.id == localPlace.id);
      if (index == -1) {
        target.add(localPlace);
      } else {
        target[index] = localPlace;
      }
    }
  }

  /// Метод для запрсоа списка мест и сформированным ранее боди [requestBody]
  Future<List<PlaceDto>> _getFilteredPlaces({
    required PlacesFilterRequestDto requestBody,
  }) async {
    try {
      final response = await networkService.client.post<Object>(
        AppConstants.filteredPlacesPath,
        data: requestBody.toJson(),
      );

      return (response.data as List<Object?>).map<PlaceDto>((raw) {
        return PlaceDto.fromJson(raw as Map<String, dynamic>);
      }).toList();
    } on DioError catch (e) {
      throw NetworkException(
        requestName:
            '${AppConstants.baseUrl}${AppConstants.filteredPlacesPath}',
        code: e.response?.statusCode,
        errorMessage: e.message,
      );
    }
  }
}
