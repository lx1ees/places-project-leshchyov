import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_details_screen/to_plan_button.dart';
import 'package:places/ui/screen/place_details_screen/to_plan_inactive_button.dart';
import 'package:places/ui/screen/place_details_screen/to_replan_button.dart';
import 'package:places/ui/screen/place_details_screen/to_share_button.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

/// Экшн кнопка на экране детальной информации места, которая меняется в зависимости
/// от типа карточки
class PlaceDetailsDynamicActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Place place;

  const PlaceDetailsDynamicActionButton({
    Key? key,
    required this.place,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<PlaceDetailsDynamicActionButton> createState() =>
      _PlaceDetailsDynamicActionButtonState();
}

class _PlaceDetailsDynamicActionButtonState
    extends State<PlaceDetailsDynamicActionButton> {
  @override
  Widget build(BuildContext context) {
    final cardLook = widget.place.cardLook;

    if (cardLook == CardLook.view ||
        (cardLook == CardLook.toVisit && !widget.place.isInFavorites)) {
      return const ToPlanInactiveButton();
    } else if (cardLook == CardLook.toVisit) {
      if (widget.place.planDate != null) {
        return ToRePlanButton(
          currentPlanDate: widget.place.planDate!,
          onPressed: () async {
            await _pickPlanDate(widget.place);
            widget.onPressed();
          },
        );
      }

      return ToPlanButton(
        onPressed: () async {
          await _pickPlanDate(widget.place);
          widget.onPressed();
        },
      );
    } else {
      return ToShareButton(
        onPressed: () {},
      );
    }
  }

  Future<void> _pickPlanDate(Place place) async {
    final nowDate = DateTime.now();
    final nowYear = nowDate.year;

    final planDate = Platform.isIOS
        ? await _cupertinoDatePicker(nowDate, nowYear)
        : await _materialDatePicker(nowDate, nowYear);

    if (!mounted) return;
    context
        .read<PlaceInteractor>()
        .setPlanDate(place: place, planDate: planDate);
  }

  Future<DateTime?> _materialDatePicker(
    DateTime nowDate,
    int nowYear,
  ) {
    return showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: nowDate,
      lastDate: DateTime(nowYear + 3),
      locale: AppConstants.locale,
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.apply,
      helpText: AppStrings.datePickerHelpText,
      fieldLabelText: AppStrings.datePickerFieldLabelText,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Theme.of(context).white,
              onSurface: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<DateTime?> _cupertinoDatePicker(
    DateTime nowDate,
    int nowYear,
  ) {
    return showCupertinoModalPopup<DateTime?>(
      builder: (context) {
        DateTime? dateTime;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                backgroundColor: Theme.of(context).colorScheme.surface,
                minimumDate: nowDate,
                initialDateTime: nowDate,
                maximumDate: DateTime(nowYear + 3),
                onDateTimeChanged: (dt) => dateTime = dt,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.defaultPaddingX2,
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context, dateTime ?? nowDate),
                child: const Text(AppStrings.apply),
              ),
            ),
          ],
        );
      },
      context: context,
    );
  }
}
