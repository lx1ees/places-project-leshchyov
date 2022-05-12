import 'package:equatable/equatable.dart';
import 'package:places/constants/app_strings.dart';

/// Категория достопримечательности с наименованием категории [name] и уникальным
/// идентификатором [id]
class PlaceType extends Equatable {
  static const List<PlaceType> availablePlaceTypes = [
    PlaceType(
      id: AppStrings.hotelTypeId,
      name: AppStrings.hotelPlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.restaurantTypeId,
      name: AppStrings.restaurantPlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.templeTypeId,
      name: AppStrings.templePlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.parkTypeId,
      name: AppStrings.parkPlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.museumTypeId,
      name: AppStrings.museumPlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.cafeTypeId,
      name: AppStrings.cafePlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.monumentTypeId,
      name: AppStrings.monumentPlaceTypeName,
    ),
    PlaceType(
      id: AppStrings.theatreTypeId,
      name: AppStrings.theatrePlaceTypeName,
    ),
  ];

  final String id;
  final String name;

  @override
  List<Object?> get props => [id];

  const PlaceType({
    required this.id,
    required this.name,
  });

  const PlaceType.unknown()
      : id = AppStrings.unknownTypeId,
        name = AppStrings.unknownPlaceTypeName;

  static PlaceType getPlaceTypeById({required String id}) {
    return availablePlaceTypes.findById(id: id);
  }
}

extension PlaceTypesExtension on List<PlaceType> {
  PlaceType findById({required final String id}) {
    return firstWhere(
      (type) => type.id == id,
      orElse: PlaceType.unknown,
    );
  }
}
