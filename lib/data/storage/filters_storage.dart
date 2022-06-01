/// Интерфейс хранилища значений фильтра
abstract class IFiltersStorage {
  /// Сохраняет значение фильтра дистанции [distance]
  Future<bool> writeDistance(double distance);

  /// Сохраняет значение фильтра типов мест [placeTypeIds]
  Future<bool> writePlaceTypeIds(List<String> placeTypeIds);

  /// Читает значение фильтра дистанции
  Future<double?> readDistance();

  /// Читает значение фильтра типов мест
  Future<List<String>?> readPlaceTypeIds();
}
