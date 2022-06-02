import 'package:drift/drift.dart';
import 'package:places/data/model/place_local_dto.dart';
import 'package:places/data/storage/database/database.dart';

/// Хранилище мест
abstract class IPlacesStorage {
  /// Чтение избранных мест
  Future<List<PlaceLocalDto>> readFavoritePlaces();

  /// Вставка избранного места [place]
  Future<void> upsertInFavoritePlaces(PlaceLocalDto place);

  /// Удаление избранного места с идентификатором [placeId]
  Future<void> deleteFromFavoritePlaces(int placeId);
}

class PlacesStorage extends IPlacesStorage {
  final PlacesDatabase _database;

  PlacesStorage({
    required PlacesDatabase database,
  }) : _database = database;

  @override
  Future<List<PlaceLocalDto>> readFavoritePlaces() async {
    final result = <PlaceLocalDto>[];

    final placesRaw = await _database.select(_database.favoritePlaces).get();
    final urlsRaw = await _database.select(_database.placeImages).get();

    for (final place in placesRaw) {
      final urls = urlsRaw
          .where((e) => e.placeId == place.id)
          .map((e) => e.url)
          .toList();

      result.add(
        PlaceLocalDto(
          id: place.id,
          lat: place.lat,
          lng: place.lng,
          name: place.name,
          placeType: place.placeType,
          description: place.description,
          urls: urls,
          cardLook: place.cardLook,
          isInFavorites: place.isInFavorites,
          isVisited: place.isVisited,
          distance: place.distance,
          planDate: place.planDate,
        ),
      );
    }

    return result;
  }

  @override
  Future<void> upsertInFavoritePlaces(PlaceLocalDto place) {
    return _database.transaction(() async {
      await _database.into(_database.favoritePlaces).insertOnConflictUpdate(
            FavoritePlacesCompanion.insert(
              id: Value(place.id),
              lat: place.lat,
              lng: place.lng,
              name: place.name,
              placeType: place.placeType,
              description: place.description,
              isInFavorites: place.isInFavorites,
              isVisited: place.isVisited,
              cardLook: place.cardLook,
              distance: Value(place.distance),
              planDate: Value(place.planDate),
            ),
          );

      await _insertUrls(urls: place.urls, toPlace: place);
    });
  }

  @override
  Future<void> deleteFromFavoritePlaces(int placeId) async {
    await (_database.delete(_database.favoritePlaces)
          ..where((tbl) => tbl.id.isIn([placeId])))
        .go();
    await (_database.delete(_database.placeImages)
          ..where((tbl) => tbl.placeId.isIn([placeId])))
        .go();
  }

  Future<void> _insertUrls({
    required List<String> urls,
    required PlaceLocalDto toPlace,
  }) async {
    await _database.batch((batch) {
      batch.insertAll(
        _database.placeImages,
        urls.map(
          (url) => PlaceImagesCompanion.insert(
            placeId: toPlace.id,
            url: url,
          ),
        ),
      );
    });
  }
}
