import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/widget/custom_elevated_button.dart';

/// Кнопка 'ПОКАЗАТЬ' на экране с фильтрами. Выводит количество отфильтрованных
/// мест [affectedPlacesCount].
class ShowFilteredListButton extends StatelessWidget {
  final int affectedPlacesCount;
  final VoidCallback onShow;

  const ShowFilteredListButton({
    required this.affectedPlacesCount,
    required this.onShow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNothingToShow = affectedPlacesCount == 0;

    return Container(
      height: AppConstants.defaultPaddingX4,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      child: Center(
        child: CustomElevatedButton(
          label: '${AppStrings.showFiltered} ($affectedPlacesCount)',
          onPressed: !isNothingToShow ? onShow : null,
        ),
      ),
    );
  }
}
