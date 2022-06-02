import 'package:drift/drift.dart';
import 'package:places/data/storage/database/favorite_places_table.dart';

/// Таблица с URL изображений мест
class PlaceImages extends Table {
  /// Идентификатор места
  IntColumn get placeId => integer().references(FavoritePlaces, #id, onDelete: KeyAction.cascade)();

  /// URL изображения
  TextColumn get url => text()();
}
