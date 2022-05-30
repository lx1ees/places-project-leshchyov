import 'package:elementary/elementary.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen.dart';

/// Модель для [PlaceListScreen]
class PlaceListScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  PlaceListScreenModel({
    required PlaceInteractor placeInteractor,
    required ErrorHandler errorHandler,
  })  : _placeInteractor = placeInteractor,
        super(errorHandler: errorHandler);

  /// Получение списка мест сначала из локального хранилища, после из сети
  /// с учетом фильтров [FiltersManager] и текущего местоположения [currentLocation]
  /// (опицонально)
  Stream<List<Place>> getPlaces({
    required FiltersManager filtersManager,
    LocationPoint? currentLocation,
  }) async* {
    try {
      final localPlaces = _placeInteractor.getLocalPlaces();
      if (localPlaces.isNotEmpty) {
        yield _placeInteractor.getLocalPlaces();
      }

      yield await _placeInteractor.getPlaces(
        filtersManager: filtersManager,
        currentLocation: currentLocation,
      );
    } on NetworkException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Метод добавления/удаления места [place] в/из избранно-е/го
  void changeFavorite(Place place) => _placeInteractor.changeFavorite(place);

  /// Метод сохранения фильтров [filtersManager]
  Future<void> saveFiltersManager(FiltersManager filtersManager) async =>
      _placeInteractor.saveFilterValues(filtersManager);

  /// Метод получения фильтров
  Future<FiltersManager> getFiltersManager() async =>
      _placeInteractor.getFiltersManager();
}
