import 'package:equatable/equatable.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight_category.dart';

/// Класс, описывающий модель данных достопримечательности
/// [name] - наименование достопримечательности
/// [point] - кордината достопримечательности
/// [urls] - пути на фото достопримечательности в интернете
/// [details] - полное описание достопримечательности
/// [category] - категория достопримечательности
class Sight extends Equatable {
  final String name;
  final LocationPoint point;
  final List<String> urls;
  final String details;
  final SightCategory category;

  @override
  List<Object?> get props => [name, point, urls, details, category];

  const Sight({
    required this.name,
    required this.point,
    required this.details,
    required this.category,
    this.urls = const [],
  });
}
