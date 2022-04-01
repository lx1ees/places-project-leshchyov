import 'dart:io';
import 'package:intl/intl.dart';
import 'package:places/constants/app_strings.dart';

extension NullableDateTimeExtension on DateTime? {
  String toBeVisitedString() {
    if (this == null) return '';

    return '${AppStrings.sightCardToBeVisitedText} ${this?.toFormattedString()}';
  }

  String visitedString() {
    if (this == null) return '';

    return '${AppStrings.sightCardVisitedText} ${this?.toFormattedString()}';
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return DateFormat('d MMM yyyy', Platform.localeName).format(this);
  }
}
