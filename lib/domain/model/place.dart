import 'package:equatable/equatable.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place_type.dart';

/// Класс, описывающий модель данных достопримечательности
/// [name] - наименование достопримечательности
/// [point] - кордината достопримечательности
/// [urls] - пути на фото достопримечательности в интернете
/// [description] - полное описание достопримечательности
/// [placeType] - категория достопримечательности
class Place extends Equatable {
  final String name;
  final LocationPoint point;
  final List<String> urls;
  final String description;
  final PlaceType placeType;

  @override
  List<Object?> get props => [name, point, urls, description, placeType];

  const Place({
    required this.name,
    required this.point,
    required this.description,
    required this.placeType,
    this.urls = const [],
  });
}
