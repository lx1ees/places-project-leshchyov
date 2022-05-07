import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widget/bottom_screen_submit_button.dart';
import 'package:places/ui/widget/custom_divider.dart';
import 'package:places/ui/widget/custom_icon_button.dart';

/// Экран выбора категории при создании нового места
/// [selectedPlaceType] - текущая выбранная категория
class SelectPlaceTypeScreen extends StatefulWidget {
  static const String routeName = '/selectPlaceType';
  final PlaceType? selectedPlaceType;

  const SelectPlaceTypeScreen({
    this.selectedPlaceType,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectPlaceTypeScreen> createState() => _SelectPlaceTypeScreenState();
}

class _SelectPlaceTypeScreenState extends State<SelectPlaceTypeScreen> {
  /// Текущая выбранная категория
  PlaceType? selectedPlaceType;

  /// Измененная категория
  PlaceType? newPlaceType;

  @override
  void initState() {
    super.initState();
    selectedPlaceType = widget.selectedPlaceType;
    newPlaceType = widget.selectedPlaceType;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, selectedPlaceType);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.placeTypeTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          centerTitle: true,
          leading: CustomIconButton(
            onPressed: () {
              Navigator.pop(context, selectedPlaceType);
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
                        bottom: index == placeTypesMock.length - 1
                            ? AppConstants.defaultPaddingX4
                            : 0,
                      ),
                      child: ListTile(
                        title: Text(
                          placeTypesMock[index].name,
                          style: AppTypography.textRegularTextStyle.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        trailing: newPlaceType?.id == placeTypesMock[index].id
                            ? Icon(
                                Icons.check_rounded,
                                color: colorScheme.secondary,
                                size: AppConstants.defaultIcon2Size,
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            newPlaceType =
                                newPlaceType?.id == placeTypesMock[index].id
                                    ? null
                                    : placeTypesMock[index];
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => const CustomDivider(
                    hasIndent: true,
                  ),
                  itemCount: placeTypesMock.length,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomScreenSubmitButton(
                  label: AppStrings.save,
                  onAddPressed: newPlaceType != null
                      ? () {
                          selectedPlaceType = newPlaceType;
                          Navigator.pop(context, selectedPlaceType);
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
