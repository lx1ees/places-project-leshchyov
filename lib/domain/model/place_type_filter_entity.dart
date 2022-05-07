import 'package:equatable/equatable.dart';
import 'package:places/domain/model/place_type.dart';

/// Класс, описывающий фильтр по категории с путем до иконки фильтра [iconPath],
/// категорией места [placeType] и флагом [isSelected] состояния фильтра
class PlaceTypeFilterEntity extends Equatable {
  final String iconPath;
  final PlaceType placeType;
  final bool isSelected;

  @override
  List<Object?> get props => [placeType, iconPath];

  const PlaceTypeFilterEntity({
    this.isSelected = false,
    required this.iconPath,
    required this.placeType,
  });

  PlaceTypeFilterEntity copyWith({bool? isSelected}) {
    return PlaceTypeFilterEntity(
      isSelected: isSelected ?? this.isSelected,
      iconPath: iconPath,
      placeType: placeType,
    );
  }
}
