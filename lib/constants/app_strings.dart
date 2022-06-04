abstract class AppStrings {
  /// Тексты приложения
  static const String appTitle = 'Places';
  static const String prepositionFrom = 'от';
  static const String prepositionTo = 'до';
  static const String meter = 'м';
  static const String km = 'км';
  static const String save = 'Сохранить';
  static const String create = 'Создать';
  static const String cancel = 'Отмена';
  static const String enterTextHint = 'введите текст';
  static const String error = 'Ошибка';
  static const String delete = 'Удалить';
  static const String skip = 'Пропустить';
  static const String apply = 'Применить';
  static const String allow = 'Разрешить';

  /// Тексты ошибок
  static const String errorNotFilled = 'Поле должно быть заполненным';
  static const String errorIncorrect = 'Некорректное значение';
  static const String errorSomethingWentWrong =
      'Что-то пошло не так.\nПопробуйте позже.';
  static const String errorWhileAddingPlace =
      'Возникла ошибка при добавлении места. Проверьте интернет-соединение';
  static const String errorLocationPermissionDenied =
      'Предоставьте разрешение на местоположение для корректного определения инетерсных мест поблизости';
  static const String errorWhileUpdatingPlaces =
      'Возникла ошибка при обновлении списка интересных мест';

  /// Тексты карточки и окна детальной информации достопримечательности
  static const String placeShortDescriptionMock = 'Открыто до 20:00';
  static const String placeDetailsPlanActionButtonTitle = 'Запланировать';
  static const String placeDetailsShareActionButtonTitle = 'Поделиться';
  static const String placeDetailsInFavActionButtonTitle = 'В Избранное';
  static const String placeDetailsRouteButtonTitle = 'Построить маршрут';
  static const String placeCardVisitedText = 'Цель достигнута';
  static const String placeCardToBeVisitedText = 'Запланировано на';
  static const String placeholderNoItemsTitleText = 'Пусто';
  static const String placeholderNoToVisitPlacesText =
      'Отмечайте понравившиеся\nместа и они появятся здесь.';
  static const String placeholderNoVisitedPlacesText =
      'Завершите маршрут,\nчтобы место попало сюда.';
  static const String placeholderNoPlacesText =
      'Измените фильтры\nили добавьте новое место';
  static const String datePickerHelpText = 'Запланируйте дату визита';
  static const String datePickerFieldLabelText = 'Введите дату';

  /// Тексты окна Избранное
  static const String favoriteScreenAppBarTitle = 'Избранное';
  static const String favoriteWantToVisitTabTitle = 'Хочу посетить';
  static const String favoriteVisitedTabTitle = 'Посетил';

  /// Тексты окна Фильтры
  static const String cafePlaceTypeName = 'Кафе';
  static const String hotelPlaceTypeName = 'Отель';
  static const String museumPlaceTypeName = 'Музей';
  static const String parkPlaceTypeName = 'Парк';
  static const String templePlaceTypeName = 'Особое место';
  static const String restaurantPlaceTypeName = 'Ресторан';
  static const String theatrePlaceTypeName = 'Театр';
  static const String monumentPlaceTypeName = 'Памятник';
  static const String unknownPlaceTypeName = 'Неизвестное место';
  static const String clearFiltersButtonTitle = 'Очистить';
  static const String placeTypeFiltersTitle = 'КАТЕГОРИИ';
  static const String distanceFilterTitle = 'Расстояние';
  static const String showFiltered = 'ПОКАЗАТЬ';

  /// Тексты окна с картой
  static const String mapScreenAppBarTitle = 'Карта';

  /// Тексты окна с настройками
  static const String settingsScreenAppBarTitle = 'Настройки';
  static const String darkThemeOption = 'Тёмная тема';
  static const String watchTutorialOption = 'Смотреть туториал';

  /// Тексты сущности Place
  static const String templeTypeId = 'temple';
  static const String hotelTypeId = 'hotel';
  static const String restaurantTypeId = 'restaurant';
  static const String parkTypeId = 'park';
  static const String museumTypeId = 'museum';
  static const String cafeTypeId = 'cafe';
  static const String monumentTypeId = 'monument';
  static const String theatreTypeId = 'theatre';
  static const String unknownTypeId = 'other';

  /// Тексты окна добавления нового места
  static const String placeTypeNotSelected = 'Не выбрано';
  static const String placeTypeTitle = 'Категория';
  static const String newPlaceTitle = 'Новое место';
  static const String placeNameTitle = 'НАЗВАНИЕ';
  static const String placeLatTitle = 'ШИРОТА';
  static const String placeLonTitle = 'ДОЛГОТА';
  static const String placeDescriptionTitle = 'ОПИСАНИЕ';
  static const String pointLocationOnMap = 'Указать на карте';
  static const String camera = 'Камера';
  static const String photo = 'Фотография';
  static const String file = 'Файл';

  /// Тексты окна поиска мест
  static const String searchTitle = 'Поиск';
  static const String noSearchResultsPlaceholder = 'Ничего не найдено.';
  static const String noSearchResultsPlaceholderHint =
      'Попробуйте изменить параметры\nпоиска';
  static const String historyTitle = 'ВЫ ИСКАЛИ';
  static const String clearHistory = 'Очистить историю';

  /// Тексты окна онбординга
  static const String tutorial1Title = 'Добро пожаловать\nв Путеводитель';
  static const String tutorial2Title = 'Построй маршрут\nи отправляйся в путь';
  static const String tutorial3Title = 'Добавляй места,\nкоторые нашёл сам';
  static const String tutorial1Subtitle =
      'Ищи новые локации и сохраняй\nсамые любимые.';
  static const String tutorial2Subtitle =
      'Достигай цели максимально\nбыстро и комфортно.';
  static const String tutorial3Subtitle =
      'Делись самыми интересными\nи помоги нам стать лучше!';
  static const String startButtonTitle = 'НА СТАРТ';

  /// Тексты окна со списком мест
  static const String placeListAppBarTwoLineTitle = 'Список\nинтересных мест';
  static const String placeListAppBarOneLineTitle = 'Список интересных мест';
  static const String placeListAppBarFirstLineTitle = 'Список ';
  static const String placeListAppBarSecondLineTitle = 'интересных мест';
}
