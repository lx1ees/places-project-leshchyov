import 'package:equatable/equatable.dart';

/// Модель координаты с широтой [lat] и долготой [lon]
class LocationPoint extends Equatable {
  final double lat;
  final double lon;

  @override
  List<Object?> get props => [lat, lon];

  const LocationPoint({
    required this.lat,
    required this.lon,
  });
}
