import 'package:equatable/equatable.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place_type.dart';

enum CardLook {
  view('view'),
  toVisit('toVisit'),
  visited('visited');

  final String literal;

  const CardLook(this.literal);

  /// Получение экземпляра класса по строковому значению
  static CardLook byLiteral(String literal) {
    return CardLook.values
        .firstWhere((e) => e.literal == literal, orElse: () => CardLook.view);
  }
}

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
  List<Object?> get props => [
        id,
        name,
        point,
        urls,
        description,
        placeType,
        isInFavorites,
        isVisited,
        planDate,
      ];

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

  Place copyWith({
    int? id,
    bool? isInFavorites,
    bool? isVisited,
    DateTime? planDate,
    CardLook? cardLook,
    List<String>? urls,
  }) {
    return Place(
      id: id ?? this.id,
      name: name,
      point: point,
      description: description,
      placeType: placeType,
      urls: urls ?? this.urls,
      isVisited: isVisited ?? this.isVisited,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      planDate: planDate ?? this.planDate,
      cardLook: cardLook ?? this.cardLook,
    );
  }
}
