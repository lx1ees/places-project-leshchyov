import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/sight_category.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen/add_new_sight_button.dart';
import 'package:places/ui/widgets/custom_divider.dart';
import 'package:places/ui/widgets/custom_icon_button.dart';

/// Экран выбора категории при создании нового места
/// [selectedSightCategory] - текущая выбранная категория
class SelectCategoryScreen extends StatefulWidget {
  static const String routeName = '/selectCategory';
  final SightCategory? selectedSightCategory;

  const SelectCategoryScreen({
    this.selectedSightCategory,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  /// Текущая выбранная категория
  SightCategory? selectedCategory;

  /// Измененная категория
  SightCategory? newSelectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedSightCategory;
    newSelectedCategory = widget.selectedSightCategory;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, selectedCategory);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.categoryTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          centerTitle: true,
          leading: CustomIconButton(
            onPressed: () {
              Navigator.pop(context, selectedCategory);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: AppConstants.defaultIcon2Size,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: AppConstants.defaultPaddingX1_5),
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == categoriesMock.length - 1
                            ? AppConstants.defaultPaddingX4
                            : 0,
                      ),
                      child: ListTile(
                        title: Text(
                          categoriesMock[index].name,
                          style: AppTypography.textRegularTextStyle.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        trailing:
                            newSelectedCategory?.id == categoriesMock[index].id
                                ? Icon(
                                    Icons.check_rounded,
                                    color: colorScheme.secondary,
                                    size: AppConstants.defaultIcon2Size,
                                  )
                                : null,
                        onTap: () {
                          setState(() {
                            newSelectedCategory = newSelectedCategory?.id ==
                                    categoriesMock[index].id
                                ? null
                                : categoriesMock[index];
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => const CustomDivider(
                    hasIndent: true,
                  ),
                  itemCount: categoriesMock.length,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomScreenSubmitButton(
                  label: AppStrings.save,
                  onAddPressed: newSelectedCategory != null
                      ? () {
                          selectedCategory = newSelectedCategory;
                          Navigator.pop(context, selectedCategory);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
