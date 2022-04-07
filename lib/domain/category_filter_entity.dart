import 'package:equatable/equatable.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';

abstract class CategoryFilterEntity extends Equatable {
  final String iconPath;
  final String label;
  final bool isSelected;

  @override
  List<Object?> get props => [label, iconPath];

  const CategoryFilterEntity({
    this.isSelected = false,
    required this.iconPath,
    required this.label,
  });

  CategoryFilterEntity copyWith({required bool isSelected});
}

class CafeCategoryFilterEntity extends CategoryFilterEntity {
  const CafeCategoryFilterEntity({
    bool isSelected = false,
  }) : super(
          iconPath: AppAssets.cafeIconAssetPath,
          label: AppStrings.cafeCategoryTitle,
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
          label: AppStrings.hotelCategoryTitle,
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
          label: AppStrings.museumCategoryTitle,
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
          label: AppStrings.parkCategoryTitle,
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
          label: AppStrings.particularPlaceCategoryTitle,
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
          label: AppStrings.restaurantCategoryTitle,
          isSelected: isSelected,
        );

  @override
  RestaurantCategoryFilterEntity copyWith({bool? isSelected}) {
    return RestaurantCategoryFilterEntity(
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
