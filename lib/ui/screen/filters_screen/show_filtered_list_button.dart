import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/widgets/custom_elevated_button.dart';

/// Кнопка 'ПОКАЗАТЬ' на экране с фильтрами. Выводит количество отфильтрованных
/// мест [affectedSightsCount].
class ShowFilteredListButton extends StatelessWidget {
  final int affectedSightsCount;
  final VoidCallback onShow;

  const ShowFilteredListButton({
    required this.affectedSightsCount,
    required this.onShow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.defaultPaddingX4,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      child: Center(
        child: CustomElevatedButton(
          label: '${AppStrings.showFiltered} ($affectedSightsCount)',
          onPressed: onShow,
        ),
      ),
    );
  }
}