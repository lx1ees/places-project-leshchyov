/// Класс, описывающий модель данных достопримечательности
/// [name] - наименование достопримечательности
/// [lat] - широта в кординатах достопримечательности
/// [lon] - долгота в координатах достопримечательности
/// [url] - путь на картинку достопримечательности в интернете
/// [details] - полное описание достопримечательности
/// [type] - тип достопримечательности
class Sight {
  static const String _endOfSentencePattern = '.';
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final String type;

  /// Краткое описание - это первое предложение детального описания
  String get shortDescription {
    final index = details.indexOf(_endOfSentencePattern);

    return index != -1 ? details.substring(0, index) : details;
  }

  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
  });
}
