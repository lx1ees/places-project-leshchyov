import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/settings_manager.dart';
import 'package:places/ui/screen/app/app.dart';

/// Модель для [App]
class AppScreenModel extends ElementaryModel {
  final SettingsManager settingsManager;

  StateNotifier<ThemeMode> get currentThemeModeState =>
      settingsManager.currentThemeModeState;

  AppScreenModel({
    required ErrorHandler errorHandler,
    required this.settingsManager,
  }) : super(errorHandler: errorHandler);
}
