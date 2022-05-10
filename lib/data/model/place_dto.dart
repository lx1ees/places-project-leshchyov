/// Класс модели места dto
class PlaceDto {
  final int id;
  final double lat;
  final double lng;
  final double? distance;
  final String name;
  final String placeType;
  final String description;
  final List<String> urls;

  const PlaceDto({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.placeType,
    required this.description,
    required this.urls,
    this.distance,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) {
    return PlaceDto(
      id: json['id'] as int,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      distance: json['distance'] as double?,
      name: json['name'] as String,
      placeType: json['placeType'] as String,
      description: json['description'] as String,
      urls: (json['urls'] as List<dynamic>).whereType<String>().toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'name': name,
      'placeType': placeType,
      'description': description,
      'urls': urls,
    };
  }
}
