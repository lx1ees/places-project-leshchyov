import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/ui/screen/res/themes.dart';

abstract class DateTimeUtils {
  /// Выбор даты
  static Future<DateTime?> pickPlanDate(BuildContext context) async {
    final nowDate = DateTime.now();
    final nowYear = nowDate.year;

    return Platform.isIOS
        ? _cupertinoDatePicker(
            nowDate: nowDate,
            nowYear: nowYear,
            context: context,
          )
        : _materialDatePicker(
            nowDate: nowDate,
            nowYear: nowYear,
            context: context,
          );
  }

  /// Материал дейтпикер
  static Future<DateTime?> _materialDatePicker({
    required BuildContext context,
    required DateTime nowDate,
    required int nowYear,
  }) {
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

  /// Купертино дейтпикер
  static Future<DateTime?> _cupertinoDatePicker({
    required BuildContext context,
    required DateTime nowDate,
    required int nowYear,
  }) {
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
