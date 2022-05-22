import 'package:elementary/elementary.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';

/// Модель для [VisitingScreen]
class VisitingScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  VisitingScreenModel({
    required PlaceInteractor placeInteractor,
    required ErrorHandler errorHandler,
  })  : _placeInteractor = placeInteractor,
        super(errorHandler: errorHandler);

  /// Получение списка избранных мест
  List<Place> favoritePlaces() => _placeInteractor.getFavoritePlaces();

  /// Получение списка посещенных мест
  List<Place> visitedPlaces() => _placeInteractor.getVisitedPlaces();

  /// Перемещение карточки в списке "Хочу посетить" с индекса
  /// [fromIndex] на индекс [toIndex]
  void changeOrderInFavorites({
    required int fromIndex,
    required int toIndex,
  }) {
    final favoritePlaces = _placeInteractor.getFavoritePlaces();

    _placeInteractor.movePlaceInFavorites(
      index: toIndex,
      placeToMove: favoritePlaces[fromIndex],
    );
  }

  /// Перемещение карточки в списке "Посещенные места" с индекса
  /// [fromIndex] на индекс [toIndex]
  void changeOrderInVisited({
    required int fromIndex,
    required int toIndex,
  }) {
    final visitedPlaces = _placeInteractor.getVisitedPlaces();

    _placeInteractor.movePlaceInVisited(
      index: toIndex,
      placeToMove: visitedPlaces[fromIndex],
    );
  }

  /// Удаление места [place] из избранных мест
  void removePlaceFromFavorites({required Place place}) =>
      _placeInteractor.changeFavorite(place);

  /// Удаление места [place] из посещенных мест
  void removePlaceFromVisited({required Place place}) =>
      _placeInteractor.removePlaceFromVisited(place);

  /// Планирование даты посещения [planDate] места [place]
  void setPlacePlanDate({required Place place, required DateTime planDate}) {
    _placeInteractor.setPlanDate(
      place: place,
      planDate: planDate,
    );
  }
}
