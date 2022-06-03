import 'package:drift/drift.dart';

/// Таблица с URL изображений мест
class PlaceImages extends Table {
  /// Наименование таблицы, к которой принадлежит место
  TextColumn get table => text()();

  /// Идентификатор места
  IntColumn get placeId => integer()();

  /// URL изображения
  TextColumn get url => text()();

  @override
  Set<Column> get primaryKey => {table, url};
}
