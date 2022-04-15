import 'package:equatable/equatable.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight_category.dart';

/// Класс, описывающий модель данных достопримечательности
/// [name] - наименование достопримечательности
/// [point] - кордината достопримечательности
/// [url] - путь на картинку достопримечательности в интернете
/// [details] - полное описание достопримечательности
/// [category] - категория достопримечательности
class Sight extends Equatable{
  final String name;
  final LocationPoint point;
  final String? url;
  final String details;
  final SightCategory category;

  @override
  List<Object?> get props => [name, point, url, details, category];

  const Sight({
    required this.name,
    required this.point,
    required this.details,
    required this.category,
    this.url,
  });
}
