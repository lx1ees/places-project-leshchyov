import 'dart:io';
import 'package:intl/intl.dart';
import 'package:places/constants/app_constants.dart';
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

extension NumExtensions on num {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));

  bool get isWhole => this is int || this == roundToDouble();
}

extension StringExtensions on String {
  /// Убирает все nbsp, для прерывания внутри слов при overflow текста
  String get nbsp {
    return replaceAll(AppConstants.space, AppConstants.nbsp);
  }
}
