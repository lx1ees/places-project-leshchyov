import 'package:equatable/equatable.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/domain/sight_type.dart';

/// Класс, описывающий фильтр по категории с путем до иконки фильтра [iconPath],
/// категорией места [sightCategory] и флагом [isSelected] состояния фильтра
abstract class CategoryFilterEntity extends Equatable {
  final String iconPath;
  final SightCategory sightCategory;
  final bool isSelected;

  @override
  List<Object?> get props => [sightCategory, iconPath];

  const CategoryFilterEntity({
    this.isSelected = false,
    required this.iconPath,
    required this.sightCategory,
  });

  CategoryFilterEntity copyWith({required bool isSelected});
}

class CafeCategoryFilterEntity extends CategoryFilterEntity {
  const CafeCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.cafeIconAssetPath,
          sightCategory: const CafeSightCategory(),
          isSelected: isSelected,
        );

  @override
  CafeCategoryFilterEntity copyWith({bool? isSelected}) {
    return CafeCategoryFilterEntity(isSelected: isSelected ?? this.isSelected);
  }
}

class HotelCategoryFilterEntity extends CategoryFilterEntity {
  const HotelCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.hotelIconAssetPath,
          sightCategory: const HotelSightCategory(),
          isSelected: isSelected,
        );

  @override
  HotelCategoryFilterEntity copyWith({bool? isSelected}) {
    return HotelCategoryFilterEntity(isSelected: isSelected ?? this.isSelected);
  }
}

class MuseumCategoryFilterEntity extends CategoryFilterEntity {
  const MuseumCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.museumIconAssetPath,
          sightCategory: const MuseumSightCategory(),
          isSelected: isSelected,
        );

  @override
  MuseumCategoryFilterEntity copyWith({bool? isSelected}) {
    return MuseumCategoryFilterEntity(
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class ParkCategoryFilterEntity extends CategoryFilterEntity {
  const ParkCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.parkIconAssetPath,
          sightCategory: const ParkSightCategory(),
          isSelected: isSelected,
        );

  @override
  ParkCategoryFilterEntity copyWith({bool? isSelected}) {
    return ParkCategoryFilterEntity(isSelected: isSelected ?? this.isSelected);
  }
}

class ParticularPlaceCategoryFilterEntity extends CategoryFilterEntity {
  const ParticularPlaceCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.particularPlaceIconAssetPath,
          sightCategory: const ParticularPlaceSightCategory(),
          isSelected: isSelected,
        );

  @override
  ParticularPlaceCategoryFilterEntity copyWith({bool? isSelected}) {
    return ParticularPlaceCategoryFilterEntity(
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class RestaurantCategoryFilterEntity extends CategoryFilterEntity {
  const RestaurantCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.restaurantIconAssetPath,
          sightCategory: const RestaurantSightCategory(),
          isSelected: isSelected,
        );

  @override
  RestaurantCategoryFilterEntity copyWith({bool? isSelected}) {
    return RestaurantCategoryFilterEntity(
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
