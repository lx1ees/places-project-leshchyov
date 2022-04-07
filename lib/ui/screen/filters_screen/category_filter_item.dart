import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/ui/widgets/tick_in_circle_icon.dart';

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
      width: 96,
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: onSelected,
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  width: 64,
                  height: 64,
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
                      height: 32,
                      width: 32,
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
            filterEntity.label,
            style: AppTypography.superSmallTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
