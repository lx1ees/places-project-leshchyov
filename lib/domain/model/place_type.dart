import 'package:equatable/equatable.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/mocks.dart';

/// Категория достопримечательности с наименованием категории [name] и уникальным
/// идентификатором [id]
class PlaceType extends Equatable {
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
