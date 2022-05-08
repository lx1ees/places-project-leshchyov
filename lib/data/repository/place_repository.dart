import 'dart:async';

import 'package:places/constants/app_constants.dart';
import 'package:places/data/api/network_service.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';

class PlaceRepository {
  final NetworkService networkService;

  PlaceRepository(this.networkService);

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

  Future<List<PlaceDto>> getFilteredPlaces({
    required LocationPoint locationPoint,
    required FiltersManager filtersManager,
    String? searchString,
  }) {
    final requestBody = PlacesFilterRequestDto(
      lat: locationPoint.lat,
      lng: locationPoint.lon,
      radius: filtersManager.distanceRightThreshold,
      typeFilter: filtersManager.placeTypeFilterIds,
      nameFilter: searchString,
    );

    return _getFilteredPlaces(requestBody: requestBody);
  }

  Future<List<PlaceDto>> getPlaces() async {
    final response = await networkService.client.get<Object>(
      AppConstants.placesPath,
    );

    if (response.statusCode == 200) {
      return (response.data as List<Object?>).map<PlaceDto>((raw) {
        return PlaceDto.fromJson(raw as Map<String, dynamic>);
      }).toList();
    }

    throw Exception(response.statusMessage);
  }

  Future<PlaceDto> addPlace(PlaceDto place) async {
    final response = await networkService.client.post<Object>(
      AppConstants.placesPath,
      data: place.toJson(),
    );

    if (response.statusCode == 200) {
      return PlaceDto.fromJson(response.data as Map<String, dynamic>);
    }

    throw Exception(response.statusMessage);
  }

  Future<PlaceDto> getPlace(String id) async {
    final response = await networkService.client.get<Object>(
      '${AppConstants.placesPath}/$id',
    );

    if (response.statusCode == 200) {
      return PlaceDto.fromJson(response.data as Map<String, dynamic>);
    }

    throw Exception(response.statusMessage);
  }

  Future<bool> deletePlace(String id) async {
    final response = await networkService.client.delete<Object>(
      '${AppConstants.placesPath}/$id',
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<PlaceDto> updatePlace(PlaceDto place) async {
    final response = await networkService.client.put<Object>(
      '${AppConstants.placesPath}/${place.id}',
      data: place.toJson(),
    );

    if (response.statusCode == 200) {
      return PlaceDto.fromJson(response.data as Map<String, dynamic>);
    }

    throw Exception(response.statusMessage);
  }

  Future<List<PlaceDto>> _getFilteredPlaces({
    required PlacesFilterRequestDto requestBody,
  }) async {
    final response = await networkService.client.post<Object>(
      AppConstants.filteredPlacesPath,
      data: requestBody.toJson(),
    );

    if (response.statusCode == 200) {
      return (response.data as List<Object?>).map<PlaceDto>((raw) {
        return PlaceDto.fromJson(raw as Map<String, dynamic>);
      }).toList();
    }

    throw Exception(response.statusMessage);
  }
}
