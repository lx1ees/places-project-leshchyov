/// Класс модели места dto (из локального хранилища)
class PlaceLocalDto {
  final int id;
  final double lat;
  final double lng;
  final double? distance;
  final String name;
  final String placeType;
  final String description;
  final List<String> urls;
  final DateTime? planDate;
  final bool isInFavorites;
  final bool isVisited;
  final String cardLook;

  const PlaceLocalDto({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.placeType,
    required this.description,
    required this.urls,
    required this.cardLook,
    this.distance,
    this.planDate,
    this.isInFavorites = false,
    this.isVisited = false,
  });

  factory PlaceLocalDto.fromJson(Map<String, dynamic> json) {
    return PlaceLocalDto(
      id: json['id'] as int,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      distance: json['distance'] as double?,
      name: json['name'] as String,
      placeType: json['placeType'] as String,
      description: json['description'] as String,
      urls: (json['urls'] as List<dynamic>).whereType<String>().toList(),
      cardLook: json['cardLook'] as String,
      planDate: json['planDate'] as DateTime?,
      isVisited: (json['isVisited'] as bool?) ?? false,
      isInFavorites: (json['isInFavorites'] as bool?) ?? false,
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
      'cardLook': cardLook,
      'planDate': planDate,
      'isVisited': isVisited,
      'isInFavorites': isInFavorites,
    };
  }

  PlaceLocalDto copyWith({
    int? id,
  }) {
    return PlaceLocalDto(
      id: id ?? this.id,
      lat: lat,
      lng: lng,
      distance: distance,
      name: name,
      placeType: placeType,
      description: description,
      urls: urls,
      cardLook: cardLook,
      planDate: planDate,
      isVisited: isVisited,
      isInFavorites: isInFavorites,
    );
  }
}
