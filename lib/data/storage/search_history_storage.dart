import 'package:places/data/storage/database/database.dart';

/// Интерфейс хранилища истории поиска
abstract class ISearchHistoryStorage {
  /// Сохраняет значение истории поиска [searchHistory]
  Future<bool> writeSearchHistory(List<String> searchHistory);

  /// Читает значение истории поиска
  Future<List<String>?> readSearchHistory();
}

class SearchHistoryStorage extends ISearchHistoryStorage {
  final PlacesDatabase _database;

  SearchHistoryStorage({
    required PlacesDatabase database,
  }) : _database = database;

  @override
  Future<List<String>?> readSearchHistory() async {
    final dtos = await _database.select(_database.searchHistoryRequests).get();

    return dtos.map((dto) => dto.name).toList();
  }

  @override
  Future<bool> writeSearchHistory(List<String> searchHistory) async {
    await _database.delete(_database.searchHistoryRequests).go();
    await _database.batch((batch) {
      batch.insertAll(
        _database.searchHistoryRequests,
        searchHistory.map(
          (e) => SearchHistoryRequestsCompanion.insert(name: e),
        ),
      );
    });

    return true;
  }
}
