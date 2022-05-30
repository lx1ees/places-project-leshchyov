import 'package:places/data/storage/filters_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище SharedPreferences
class SharedPreferencesStorage implements IFiltersStorage {
  static const String distanceFilterKey = 'distanceFilterKey';
  static const String placeTypesFilterKey = 'placeTypesFilterKey';

  final _preferences = SharedPreferences.getInstance();

  @override
  Future<double?> readDistance() async =>
      (await _preferences).getDouble(distanceFilterKey);

  @override
  Future<List<String>?> readPlaceTypeIds() async =>
      (await _preferences).getStringList(placeTypesFilterKey);

  @override
  Future<bool> writeDistance(double distance) async =>
      (await _preferences).setDouble(distanceFilterKey, distance);

  @override
  Future<bool> writePlaceTypeIds(List<String> placeTypeIds) async =>
      (await _preferences).setStringList(placeTypesFilterKey, placeTypeIds);
}
