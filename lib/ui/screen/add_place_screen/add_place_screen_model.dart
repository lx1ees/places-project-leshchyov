import 'package:elementary/elementary.dart';
import 'package:places/data/api/exceptions/network_exception.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/ui/screen/add_place_screen/add_place_screen.dart';

/// Модель для [AddPlaceScreen]
class AddPlaceScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  AddPlaceScreenModel({
    required ErrorHandler errorHandler,
    required PlaceInteractor placeInteractor,
  })  : _placeInteractor = placeInteractor,
        super(errorHandler: errorHandler);

  /// Метод добавления нового места
  Future<void> addNewPlace({
    required PlaceType placeType,
    required String name,
    required double lat,
    required double lon,
    required String description,
    required List<String> imagesPaths,
  }) async {
    final newPlace = Place(
      name: name,
      point: LocationPoint(lat: lat, lon: lon),
      description: description,
      placeType: placeType,
      urls: imagesPaths,
    );

    try {
      await _placeInteractor.addNewPlace(newPlace);
    } on NetworkException catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
