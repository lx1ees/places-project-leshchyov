import 'dart:math';
import 'package:places/domain/model/location_point.dart';

class LocationUtils {
  /// Определение, находится ли координата [checkPoint] от текущего местоположения
  /// [centerPoint] в пределах дистанции от [startRadiusRange] до [endRadiusRange]
  /// в метрах.
  static bool arePointsNear({
    required LocationPoint checkPoint,
    required LocationPoint centerPoint,
    required double startRadiusRange,
    required double endRadiusRange,
  }) {
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint.lat / 180.0) * ky;
    final dx = (centerPoint.lon - checkPoint.lon).abs() * kx;
    final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
    final distance = sqrt(dx * dx + dy * dy);
    final start = (startRadiusRange / 1000).round();
    final end = (endRadiusRange / 1000).round();

    return distance >= start && distance <= end;
  }
}
