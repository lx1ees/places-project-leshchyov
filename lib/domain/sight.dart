/// Класс, описывающий модель данных достопримечательности
/// [name] - наименование достопримечательности
/// [lat] - широта в кординатах достопримечательности
/// [lon] - долгота в координатах достопримечательности
/// [url] - путь на картинку достопримечательности в интернете
/// [details] - полное описание достопримечательности
/// [type] - тип достопримечательности
class Sight {
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final String type;
  
  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
  });
}
