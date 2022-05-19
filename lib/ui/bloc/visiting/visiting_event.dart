part of 'visiting_bloc.dart';

@immutable
abstract class VisitingEvent {
  const VisitingEvent();
}

/// Событие запроса списка посещеных мест и мест в збранном
class PlacesRequested extends VisitingEvent {
  const PlacesRequested();
}

/// Событие изменения порядка в списке посещенных мест
/// [fromIndex] - с какого индекса перемещается место
/// [toIndex] - на какой индекс перемещается место
class PlaceChangedOrderInVisited extends VisitingEvent {
  final int fromIndex;
  final int toIndex;

  const PlaceChangedOrderInVisited({
    required this.fromIndex,
    required this.toIndex,
  });
}

/// Событие изменения порядка в списке избранного
/// [fromIndex] - с какого индекса перемещается место
/// [toIndex] - на какой индекс перемещается место
class PlaceChangedOrderInFavorites extends VisitingEvent {
  final int fromIndex;
  final int toIndex;

  const PlaceChangedOrderInFavorites({
    required this.fromIndex,
    required this.toIndex,
  });
}

/// Событие нажатия на кнопку "Добавить в избранное" место [place]
class PlaceInFavoritesToggled extends VisitingEvent {
  final Place place;

  const PlaceInFavoritesToggled({
    required this.place,
  });
}

/// Событие удаления места [place] из посещенных мест
class PlaceInVisitedRemoved extends VisitingEvent {
  final Place place;

  const PlaceInVisitedRemoved({
    required this.place,
  });
}

/// Событие установки даты посещения [dateTime] месту [place]
class PlacePlanDateIsSet extends VisitingEvent {
  final Place place;
  final DateTime? dateTime;

  const PlacePlanDateIsSet({
    required this.place,
    this.dateTime,
  });
}
