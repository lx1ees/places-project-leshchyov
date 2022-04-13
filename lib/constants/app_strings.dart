class AppStrings {
  /// Тексты приложения
  static const String appTitle = 'Places';
  static const String appBarTitle = 'Список\nинтересных мест';
  static const String prepositionFrom = 'от';
  static const String prepositionTo = 'до';
  static const String meter = 'м';
  static const String km = 'км';
  static const String save = 'Сохранить';
  static const String create = 'Создать';
  static const String cancel = 'Отмена';
  static const String enterTextHint = 'введите текст';

  /// Тексты ошибок
  static const String errorNotFilled = 'Поле должно быть заполненным';
  static const String errorIncorrect = 'Некорректное значение';

  /// Тексты карточки и окна детальной информации достопримечательности
  static const String sightShortDescriptionMock = 'Закрыто до 9:00';
  static const String sightDetailsPlanActionButtonTitle = 'Запланировать';
  static const String sightDetailsInFavActionButtonTitle = 'В Избранное';
  static const String sightDetailsRouteButtonTitle = 'Построить маршрут';
  static const String sightCardVisitedText = 'Цель достигнута';
  static const String sightCardToBeVisitedText = 'Запланировано на';
  static const String placeholderNoItemsTitleText = 'Пусто';
  static const String placeholderNoToVisitSightsText =
      'Отмечайте понравившиеся места и они появятся здесь.';
  static const String placeholderNoVisitedSightsText =
      'Завершите маршрут, чтобы место попало сюда.';

  /// Тексты окна Избранное
  static const String favoriteScreenAppBarTitle = 'Избранное';
  static const String favoriteWantToVisitTabTitle = 'Хочу посетить';
  static const String favoriteVisitedTabTitle = 'Посетил';

  /// Тексты окна Фильтры
  static const String cafeCategoryName = 'Кафе';
  static const String hotelCategoryName = 'Отель';
  static const String museumCategoryName = 'Музей';
  static const String parkCategoryName = 'Парк';
  static const String particularPlaceCategoryName = 'Особое место';
  static const String restaurantCategoryName = 'Ресторан';
  static const String unknownCategoryName = 'Неизвестное место';
  static const String clearFiltersButtonTitle = 'Очистить';
  static const String categoryFiltersTitle = 'КАТЕГОРИИ';
  static const String distanceFilterTitle = 'Расстояние';
  static const String showFiltered = 'ПОКАЗАТЬ';

  /// Тексты окна с настройками
  static const String settingsScreenAppBarTitle = 'Настройки';
  static const String darkThemeOption = 'Тёмная тема';
  static const String watchTutorialOption = 'Смотреть туториал';

  /// Тексты сущности Sight
  static const String particularPlaceCategoryId = 'particular_place';
  static const String hotelCategoryId = 'hotel';
  static const String restaurantCategoryId = 'restaurant';
  static const String parkCategoryId = 'park';
  static const String museumCategoryId = 'museum';
  static const String cafeCategoryId = 'cafe';
  static const String unknownCategoryId = 'unknown';

  /// Тексты окна добавления нового места
  static const String categoryNotSelected = 'Не выбрано';
  static const String categoryTitle = 'Категория';
  static const String newPlaceTitle = 'Новое место';
  static const String placeNameTitle = 'НАЗВАНИЕ';
  static const String placeLatTitle = 'ШИРОТА';
  static const String placeLonTitle = 'ДОЛГОТА';
  static const String placeDetailsTitle = 'ОПИСАНИЕ';
  static const String pointLocationOnMap = 'Указать на карте';
}
