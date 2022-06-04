import 'package:elementary/elementary.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
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
  /// с учетом фильтров [FiltersManager]
  Stream<List<Place>> getPlaces({
    required FiltersManager filtersManager,
  }) async* {
    try {
      final localPlaces = _placeInteractor.getLocalPlaces();
      if (localPlaces.isNotEmpty) {
        yield _placeInteractor.getLocalPlaces();
      }

      yield await _placeInteractor.getPlaces(
        filtersManager: filtersManager,
      );
    } on NetworkException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Получение списка локального списка мест с учетом фильтров [FiltersManager]
  Future<List<Place>> getLocalPlaces() async {
    try {
      return _placeInteractor.getLocalPlaces();
    } on Exception catch (e) {
      handleError(e);
      rethrow;
    }
  }

  /// Обновление текущего местоположения
  Future<void> updateCurrentLocation() async =>
      _placeInteractor.updateCurrentLocation();

  /// Метод добавления/удаления места [place] в/из избранно-е/го
  Future<void> changeFavorite(Place place) async =>
      _placeInteractor.changeFavorite(place);

  /// Метод сохранения фильтров [filtersManager]
  Future<void> saveFiltersManager(FiltersManager filtersManager) async =>
      _placeInteractor.saveFilterValues(filtersManager);

  /// Метод получения фильтров
  Future<FiltersManager> getFiltersManager() async =>
      _placeInteractor.getFiltersManager();
}
