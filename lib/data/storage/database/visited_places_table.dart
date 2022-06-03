import 'package:drift/drift.dart';

/// Таблица посещенных мест
class VisitedPlaces extends Table {
  IntColumn get id => integer()();

  RealColumn get lat => real()();

  RealColumn get lng => real()();

  RealColumn get distance => real().nullable()();

  TextColumn get name => text()();

  TextColumn get placeType => text()();

  TextColumn get description => text()();

  DateTimeColumn get planDate => dateTime().nullable()();

  BoolColumn get isInFavorites => boolean()();

  BoolColumn get isVisited => boolean()();

  TextColumn get cardLook => text()();

  @override
  Set<Column> get primaryKey => {id};
}
