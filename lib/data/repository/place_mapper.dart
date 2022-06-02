import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/place_local_dto.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';

/// Маппер доменной модели Place
abstract class PlaceMapper {
  /// Маппинг из сетевой ДТО
  static Place fromDto(PlaceDto dto) {
    return Place(
      id: dto.id,
      name: dto.name,
      point: LocationPoint(lat: dto.lat, lon: dto.lng),
      description: dto.description,
      urls: dto.urls,
      placeType: PlaceType.getPlaceTypeById(id: dto.placeType),
    );
  }

  /// Маппинг в сетевую ДТО
  static PlaceDto toDto(Place place) {
    return PlaceDto(
      id: place.id,
      lat: place.point.lat,
      lng: place.point.lon,
      name: place.name,
      placeType: place.placeType.id,
      description: place.description,
      urls: place.urls,
    );
  }

  /// Маппинг из локальной (БД) ДТО
  static Place fromLocalDto(PlaceLocalDto dto) {
    return Place(
      id: dto.id,
      name: dto.name,
      point: LocationPoint(lat: dto.lat, lon: dto.lng),
      description: dto.description,
      urls: dto.urls,
      placeType: PlaceType.getPlaceTypeById(id: dto.placeType),
      cardLook: CardLook.byLiteral(dto.cardLook),
      planDate: dto.planDate,
      isInFavorites: dto.isInFavorites,
      isVisited: dto.isVisited,
    );
  }

  /// Маппинг в локальную (БД) ДТО
  static PlaceLocalDto toLocalDto(Place place) {
    return PlaceLocalDto(
      id: place.id,
      lat: place.point.lat,
      lng: place.point.lon,
      name: place.name,
      placeType: place.placeType.id,
      description: place.description,
      urls: place.urls,
      cardLook: place.cardLook.literal,
      planDate: place.planDate,
      isVisited: place.isVisited,
      isInFavorites: place.isInFavorites,
    );
  }
}
