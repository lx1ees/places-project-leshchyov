import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:places/data/storage/database/favorite_places_table.dart';
import 'package:places/data/storage/database/place_images_table.dart';
import 'package:places/data/storage/database/search_history_table.dart';
import 'package:places/data/storage/database/visited_places_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [SearchHistoryRequests, PlaceImages, FavoritePlaces, VisitedPlaces])
class PlacesDatabase extends _$PlacesDatabase {
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  PlacesDatabase() : super(_openConnection());
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'placesDB.sqlite'));

    return NativeDatabase(file);
  });
}
