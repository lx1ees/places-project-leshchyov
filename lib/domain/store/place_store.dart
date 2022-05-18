import 'package:mobx/mobx.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';

part 'place_store.g.dart';

class PlaceStore = PlaceStoreBase with _$PlaceStore;

abstract class PlaceStoreBase with Store {
  final PlaceInteractor _placeInteractor;

  @observable
  ObservableFuture<List<Place>>? getPlacesFuture;

  PlaceStoreBase({required PlaceInteractor placeInteractor})
      : _placeInteractor = placeInteractor;

  @action
  void getPlaces({
    required FiltersManager filtersManager,
    LocationPoint? currentLocation,
  }) {
    getPlacesFuture = ObservableFuture(
      _placeInteractor.getPlaces(
        filtersManager: filtersManager,
        currentLocation: currentLocation,
      ),
    );
  }

  @action
  void getLocalPlaces() {
    getPlacesFuture = ObservableFuture.value(
      _placeInteractor.getLocalPlaces(),
    );
  }
}
