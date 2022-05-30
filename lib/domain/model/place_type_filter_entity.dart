import 'package:equatable/equatable.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/place_type.dart';

/// Класс, описывающий фильтр по категории с путем до иконки фильтра [iconPath],
/// категорией места [placeType] и флагом [isSelected] состояния фильтра
class PlaceTypeFilterEntity extends Equatable {
  static List<PlaceTypeFilterEntity> availablePlaceTypeFilters = [
    PlaceTypeFilterEntity(
      iconPath: AppAssets.hotelIcon,
      placeType:
          PlaceType.availablePlaceTypes.findById(id: AppStrings.hotelTypeId),
    ),
    PlaceTypeFilterEntity(
      iconPath: AppAssets.restaurantIcon,
      placeType: PlaceType.availablePlaceTypes
          .findById(id: AppStrings.restaurantTypeId),
    ),
    PlaceTypeFilterEntity(
      iconPath: AppAssets.particularPlaceIcon,
      placeType:
          PlaceType.availablePlaceTypes.findById(id: AppStrings.templeTypeId),
    ),
    PlaceTypeFilterEntity(
      iconPath: AppAssets.parkIcon,
      placeType:
          PlaceType.availablePlaceTypes.findById(id: AppStrings.parkTypeId),
    ),
    PlaceTypeFilterEntity(
      iconPath: AppAssets.museumIcon,
      placeType:
          PlaceType.availablePlaceTypes.findById(id: AppStrings.museumTypeId),
    ),
    PlaceTypeFilterEntity(
      iconPath: AppAssets.cafeIcon,
      placeType:
          PlaceType.availablePlaceTypes.findById(id: AppStrings.cafeTypeId),
    ),
  ];

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

  static List<PlaceTypeFilterEntity> listByIds(Iterable<String> ids) {
    return availablePlaceTypeFilters
        .where((e) => ids.contains(e.placeType.id))
        // .map((e) => e.copyWith(isSelected: ids.contains(e.placeType.id)))
        .toList();
  }

  PlaceTypeFilterEntity copyWith({bool? isSelected}) {
    return PlaceTypeFilterEntity(
      isSelected: isSelected ?? this.isSelected,
      iconPath: iconPath,
      placeType: placeType,
    );
  }
}
