import 'package:places/constants/app_assets.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight_category.dart';

/// Класс, описывающий модель данных достопримечательности
/// [name] - наименование достопримечательности
/// [point] - кордината достопримечательности
/// [url] - путь на картинку достопримечательности в интернете
/// [details] - полное описание достопримечательности
/// [category] - категория достопримечательности
class Sight {
  final String name;
  final LocationPoint point;
  final String url;
  final String details;
  final SightCategory category;

  const Sight({
    required this.name,
    required this.point,
    required this.details,
    required this.category,
    String? url,
  }) : url = url ?? AppAssets.imagePlaceholderUrl;
}
