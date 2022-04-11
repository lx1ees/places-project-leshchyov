import 'package:equatable/equatable.dart';
import 'package:places/domain/sight_category.dart';

/// Класс, описывающий фильтр по категории с путем до иконки фильтра [iconPath],
/// категорией места [sightCategory] и флагом [isSelected] состояния фильтра
class CategoryFilterEntity extends Equatable {
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

  CategoryFilterEntity copyWith({bool? isSelected}) {
    return CategoryFilterEntity(
      isSelected: isSelected ?? this.isSelected,
      iconPath: iconPath,
      sightCategory: sightCategory,
    );
  }
}
