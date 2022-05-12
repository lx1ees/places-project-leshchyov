import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';

/// Маппер доменной модели Place
abstract class PlaceMapper {
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
}
