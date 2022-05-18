import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/place.dart';

part 'visiting_event.dart';

part 'visiting_state.dart';

class VisitingBloc extends Bloc<VisitingEvent, VisitingState> {
  final PlaceInteractor _placeInteractor;

  VisitingBloc({
    required PlaceInteractor placeInteractor,
  })  : _placeInteractor = placeInteractor,
        super(const VisitingLoading()) {
    on<PlacesRequested>(_onPlacesRequested);
    on<PlaceChangedOrderInVisited>(_onPlaceChangedOrderInVisited);
    on<PlaceChangedOrderInFavorites>(_onPlaceChangedOrderInFavorites);
    on<PlaceInFavoritesToggled>(_onPlaceInFavoritesToggled);
    on<PlaceInVisitedRemoved>(_onPlaceInVisitedRemoved);
    on<PlacePlanDateIsSet>(_onPlacePlanDateIsSet);
  }

  Future<void> _onPlacesRequested(
    PlacesRequested event,
    Emitter<VisitingState> emit,
  ) async {
    emit(const VisitingLoading());
    try {
      final favoritePlaces = _placeInteractor.getFavoritePlaces();
      final visitedPlaces = _placeInteractor.getVisitedPlaces();
      emit(VisitingLoadedSuccessfully(
        favoritePlaces: favoritePlaces,
        visitedPlaces: visitedPlaces,
      ));
    } on Exception catch (_) {
      emit(const VisitingLoadedWithFailure());
    }
  }

  Future<void> _onPlaceChangedOrderInVisited(
    PlaceChangedOrderInVisited event,
    Emitter<VisitingState> emit,
  ) async {
    final visitedPlaces = _placeInteractor.getVisitedPlaces();
    _placeInteractor.movePlaceInVisited(
      index: event.toIndex,
      placeToMove: visitedPlaces[event.fromIndex],
    );
    add(const PlacesRequested());
  }

  Future<void> _onPlaceChangedOrderInFavorites(
    PlaceChangedOrderInFavorites event,
    Emitter<VisitingState> emit,
  ) async {
    final favoritePlaces = _placeInteractor.getFavoritePlaces();
    _placeInteractor.movePlaceInFavorites(
      index: event.toIndex,
      placeToMove: favoritePlaces[event.fromIndex],
    );
    add(const PlacesRequested());
  }

  Future<void> _onPlaceInFavoritesToggled(
    PlaceInFavoritesToggled event,
    Emitter<VisitingState> emit,
  ) async {
    _placeInteractor.changeFavorite(event.place);
    add(const PlacesRequested());
  }

  Future<void> _onPlaceInVisitedRemoved(
    PlaceInVisitedRemoved event,
    Emitter<VisitingState> emit,
  ) async {
    _placeInteractor.removePlaceFromVisited(event.place);
    add(const PlacesRequested());
  }

  Future<void> _onPlacePlanDateIsSet(
    PlacePlanDateIsSet event,
    Emitter<VisitingState> emit,
  ) async {
    _placeInteractor.setPlanDate(
      place: event.place,
      planDate: event.dateTime,
    );
    add(const PlacesRequested());
  }
}
