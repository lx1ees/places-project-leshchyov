/// Интерфейс хранилища истории поиска
abstract class ISearchHistoryStorage {
  /// Сохраняет значение истории поиска [searchHistory]
  Future<bool> writeSearchHistory(List<String> searchHistory);

  /// Читает значение истории поиска
  Future<List<String>?> readSearchHistory();
}
