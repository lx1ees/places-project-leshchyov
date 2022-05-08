import 'package:flutter/material.dart';

abstract class AppConstants {
  /// Константы приложения
  static const double appbarHeight = 152;
  static const double appbarHorizontalPadding = 72;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 10.0;
  static const double button2BorderRadius = 12.0;
  static const double button3BorderRadius = 24.0;
  static const double extendedFabHorizontalPadding = 22.0;
  static const double textFieldBorderRadius = 8.0;
  static const double indicatorBorderRadius = 8.0;
  static const double indicatorHeight = 8.0;
  static const double textField2BorderRadius = 12.0;
  static const double textFieldContentPadding = 10.0;
  static const double defaultPaddingX0_25 = 4;
  static const double defaultPaddingX0_5 = 8;
  static const double defaultPaddingX0_75 = 12;
  static const double defaultPadding = 16;
  static const double defaultPaddingX1_5 = 24;
  static const double defaultPaddingX2 = 32;
  static const double defaultPaddingX2_25 = 36;
  static const double defaultPaddingX2_5 = 40;
  static const double defaultPaddingX3 = 48;
  static const double defaultPaddingX4 = 64;
  static const double defaultButtonHorizontalPadding = 12;
  static const double defaultIconSize = 20;
  static const double defaultIcon2Size = 18;
  static const double defaultIcon3Size = 22;
  static const double defaultIcon4Size = 24;
  static const double defaultIconBigSize = 64;
  static const double defaultMiniIconSize = 16;
  static const double defaultButtonIconSize = 16;
  static const double defaultTextFieldIconSize = 24;
  static const double defaultDividerThickness = 0.8;
  static const double defaultTabBorderRadius = 40;
  static const double defaultTabHeight = 40;
  static const double defaultTabVerticalPadding = 6;
  static const double placeholderNoItemsSubtitleWidth = 200;
  static const double defaultElevatedButtonHeight = 48;
  static const double defaultTextButtonHeight = 40;
  static const double defaultAppBarButtonLeadingWidth = 90;
  static const double cardDragFeedbackWidth = 300;
  static const double cardDragFeedbackHeight = 200;
  static const String nbsp = '\u00A0';
  static const String space = ' ';
  static const double splashLogoSize = 160;
  static const int minSplashTimeInSec = 4;
  static const double minDraggableBottomSheetHeight = 0.4;
  static const double initialDraggableBottomSheetHeight = 0.65;
  static const double bottomSheetIndicatorHeight = 7;
  static const double bottomSheetIndicatorWidth = 40;
  static const double infinity = 1000000;
  static const Locale locale = Locale('ru', 'RU');
  static const double smallScreenWidth = 480;
  static const double smallScreenHeight = 800;

  /// Константы карточки и окна детальной информации достопримечательности
  static const double placeCardImageHeight = 96;
  static const double placeDetailsGalleryHeight = 360;
  static const double placeDetailsGalleryBackButtonSize = 32;
  static const double cardAspectRatio = 3 / 2;
  static const double closeButtonSize = 40;

  /// Константы окна с фильтрами
  static const double distanceFilterMinValue = 100;
  static const double distanceFilterMaxValue = 10000;
  static const double placeTypeFilterWidgetWidth = 96;
  static const double placeTypeFilterIconSize = 64;
  static const double placeTypeFilterIconRadius = placeTypeFilterIconSize / 2;
  static const double placeTypeFilterRunSpace = 40;
  static const double placeTypeFilterHeight = 92;

  /// Константы окна с настройками
  static const double infoIconPadding = 10;

  /// Константы окна поиска
  static const double searchTileImageSize = 56;
  static const double separatorStartIndent = 88;

  /// Константы добавления нового места
  static const double addNewPlaceImageSize = 72;

  /// Константы онбординга
  static const double onboardingIconBottomMargin = 40;
  static const double onboardingActiveIndicatorWidth = 24;
  static const double indicatorStartIndent = 88;

  /// Константы сетевого взаимодействия
  static const String baseUrl =  'https://test-backend-flutter.surfstudio.ru';
  static const String filteredPlacesPath = '/filtered_places';
  static const String placesPath = '/place';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 5000;
  static const int sendTimeout = 5000;
}
