import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';

/// Кнопка 'ПОКАЗАТЬ' на экране с фильтрами. Выводит количество отфильтрованных
/// мест [affectedPlacesCount].
class ShowFilteredListButton extends StatelessWidget {
  final int affectedPlacesCount;
  final VoidCallback onShow;
  final bool isLoading;

  const ShowFilteredListButton({
    required this.affectedPlacesCount,
    required this.onShow,
    this.isLoading = false,
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
        child: !isLoading
            ? CustomElevatedButton(
                label: '${AppStrings.showFiltered} ($affectedPlacesCount)',
                onPressed: !isNothingToShow ? onShow : null,
              )
            : Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).white,
                  ),
                ),
              ),
      ),
    );
  }
}
