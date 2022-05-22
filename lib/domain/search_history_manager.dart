/// Класс-менеджер истории поиска
class SearchHistoryManager {
  final List<String> _successSearches = [];

  bool get isEmpty => _successSearches.isEmpty;

  List<String> load() => _successSearches;

  void addInHistory(String searchString) {
    final isAlreadyRegistered = _successSearches.contains(searchString);
    if (isAlreadyRegistered) {
      /// Удаляем существующую запись и вставляем снова, тем самым поднимая ее наверх
      remove(searchString);
    }
    _successSearches.insert(0, searchString);
  }

  List<String> remove(String searchString) {
    _successSearches.remove(searchString);

    return _successSearches;
  }

  List<String> clearHistory() {
    _successSearches.clear();

    return _successSearches;
  }
}
