import 'package:equatable/equatable.dart';
import 'package:places/constants/app_strings.dart';

/// Категория достопримечательности с наименованием категории [name] и уникальным
/// идентификатором [id]
class SightCategory extends Equatable {
  final String id;
  final String name;

  @override
  List<Object?> get props => [id];

  const SightCategory({
    required this.id,
    required this.name,
  });

  const SightCategory.unknown()
      : id = AppStrings.unknownCategoryId,
        name = AppStrings.unknownCategoryName;
}

extension SightCategoriesExtension on List<SightCategory> {
  SightCategory findById({required final String id}) {
    return firstWhere(
      (category) => category.id == id,
      orElse: SightCategory.unknown,
    );
  }
}
