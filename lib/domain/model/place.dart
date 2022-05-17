import 'package:equatable/equatable.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place_type.dart';

enum CardLook { view, toVisit, visited }

/// Класс, описывающий модель данных достопримечательности
/// [id] - идентификатор
/// [name] - наименование достопримечательности
/// [point] - кордината достопримечательности
/// [urls] - пути на фото достопримечательности в интернете
/// [description] - полное описание достопримечательности
/// [placeType] - категория достопримечательности
/// [planDate] - дата запланированного посещения
/// [isInFavorites] - флаг, находитеся место в избранном или нет
/// [isVisited] - флаг, посещенное место или нет
/// [cardLook] - вид карточки, где показывается место
class Place extends Equatable {
  final int id;
  final String name;
  final LocationPoint point;
  final List<String> urls;
  final String description;
  final PlaceType placeType;
  final DateTime? planDate;
  final bool isInFavorites;
  final bool isVisited;
  final CardLook cardLook;

  @override
  List<Object?> get props => [id, name, point, urls, description, placeType];

  const Place({
    this.id = 0,
    required this.name,
    required this.point,
    required this.description,
    required this.placeType,
    this.urls = const [],
    this.isInFavorites = false,
    this.isVisited = false,
    this.planDate,
    this.cardLook = CardLook.view,
  });

  // factory Place.fromDto(PlaceDto dto) {
  //   return Place(
  //     id: dto.id,
  //     name: dto.name,
  //     point: LocationPoint(lat: dto.lat, lon: dto.lng),
  //     description: dto.description,
  //     urls: dto.urls,
  //     placeType: PlaceType.getPlaceTypeById(id: dto.placeType),
  //   );
  // }
  //
  // PlaceDto toDto() {
  //   return PlaceDto(
  //     id: id,
  //     lat: point.lat,
  //     lng: point.lon,
  //     name: name,
  //     placeType: placeType.id,
  //     description: description,
  //     urls: urls,
  //   );
  // }

  Place copyWith({
    bool? isInFavorites,
    bool? isVisited,
    DateTime? planDate,
    CardLook? cardLook,
  }) {
    return Place(
      id: id,
      name: name,
      point: point,
      description: description,
      placeType: placeType,
      urls: urls,
      isVisited: isVisited ?? this.isVisited,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      planDate: planDate ?? this.planDate,
      cardLook: cardLook ?? this.cardLook,
    );
  }
}
