import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/ui/widgets/tick_in_circle_icon.dart';

/// Виджет фильтра по категории, содержит сущность фильтра по категории
/// [filterEntity] и обработчик активации/деактивации фильтра [onSelected]
class CategoryFilterItem extends StatelessWidget {
  final CategoryFilterEntity filterEntity;
  final VoidCallback onSelected;

  const CategoryFilterItem({
    required this.filterEntity,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.categoryFilterWidgetWidth,
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: onSelected,
                borderRadius: BorderRadius.circular(
                  AppConstants.categoryFilterIconRadius,
                ),
                child: Container(
                  width: AppConstants.categoryFilterIconSize,
                  height: AppConstants.categoryFilterIconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.16),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      filterEntity.iconPath,
                      color: Theme.of(context).colorScheme.secondary,
                      height: AppConstants.categoryFilterIconRadius,
                      width: AppConstants.categoryFilterIconRadius,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: filterEntity.isSelected,
                child: const Positioned(
                  bottom: 0,
                  right: 0,
                  child: TickInCircleIcon(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            filterEntity.sightCategory.name,
            style: AppTypography.superSmallTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
