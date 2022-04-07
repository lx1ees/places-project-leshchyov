import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen/category_filter_item.dart';
import 'package:places/ui/widgets/custom_elevated_button.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';
import 'package:places/ui/widgets/custom_text_button.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              minimumSize: const Size(0, AppConstants.defaultTextButtonHeight),
              primary: Theme.of(context).colorScheme.secondary,
              textStyle: AppTypography.textTextStyle,
            ),
            child: Text('Очистить'),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'КАТЕГОРИИ',
                    style: AppTypography.superSmallTextStyle.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 40,
                        children: categoryFiltersMock
                            .map(
                              (categoryFilterEntity) => CategoryFilterItem(
                                filterEntity: categoryFilterEntity,
                                onSelected: () {},
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Расстояние',
                              style: AppTypography.textRegularTextStyle,
                            ),
                            Text(
                              'от 100 до 10000 м',
                              style:
                                  AppTypography.textRegularTextStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: RangeSlider(
                            min: 100,
                            max: 10000,
                            onChanged: (value){},
                            values: const RangeValues(1000, 3000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Center(
                child: CustomElevatedButton(
                  label: 'ПОКАЗАТЬ',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
