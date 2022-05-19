part of 'visiting_bloc.dart';

@immutable
abstract class VisitingState extends Equatable {
  const VisitingState();
}

/// Состояние процесса загрузки списка мест
class VisitingLoading extends VisitingState {
  @override
  List<Object?> get props => [];

  const VisitingLoading();
}

/// Состояние успешной загрузки списка мест
class VisitingLoadedSuccessfully extends VisitingState {
  final List<Place> favoritePlaces;
  final List<Place> visitedPlaces;

  @override
  List<Object?> get props => [favoritePlaces, visitedPlaces];

  const VisitingLoadedSuccessfully({
    required this.favoritePlaces,
    required this.visitedPlaces,
  });
}

/// Состояние оишбки при загрузке списка мест
class VisitingLoadedWithFailure extends VisitingState {
  @override
  List<Object?> get props => [];

  const VisitingLoadedWithFailure();
}
