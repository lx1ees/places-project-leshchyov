import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class DefaultErrorHandler extends ErrorHandler {
  @override
  void handleError(Object error) => debugPrint(error.toString());
}
