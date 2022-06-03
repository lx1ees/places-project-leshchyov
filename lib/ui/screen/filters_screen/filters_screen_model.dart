import 'package:elementary/elementary.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';

/// Модель для [FiltersScreen]
class FiltersScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  FiltersScreenModel({
    required PlaceInteractor placeInteractor,
    required ErrorHandler errorHandler,
  })  : _placeInteractor = placeInteractor,
        super(errorHandler: errorHandler);

  /// Получение списка мест из сети с учетом фильтров [FiltersManager]
  /// и текущего местоположения [currentLocation] (опицонально)
  Future<List<Place>> getPlaces({
    required FiltersManager filtersManager,
    LocationPoint? currentLocation,
  }) async {
    try {
      return _placeInteractor.getPlaces(
        filtersManager: filtersManager,
        currentLocation: currentLocation,
      );
    } on NetworkException catch (e) {
      handleError(e);
      rethrow;
    } on Exception catch (e){
      handleError(e);
      rethrow;
    }
  }

  /// Метод сохранения фильтров [filtersManager]
  Future<void> saveFiltersManager(FiltersManager filtersManager) async =>
      _placeInteractor.saveFilterValues(filtersManager);

  /// Метод получения фильтров
  Future<FiltersManager> getFiltersManager() async =>
      _placeInteractor.getFiltersManager();
}
