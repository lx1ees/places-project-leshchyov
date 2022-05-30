import 'package:places/data/storage/filters_storage.dart';
import 'package:places/data/storage/settings_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище SharedPreferences
class SharedPreferencesStorage implements IFiltersStorage, ISettingsStorage {
  static const String distanceFilterKey = 'distanceFilterKey';
  static const String placeTypesFilterKey = 'placeTypesFilterKey';
  static const String themeSettingKey = 'themeSettingKey';
  static const String isFirstLaunchSettingKey = 'isFirstLaunchSettingKey';

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

  @override
  Future<bool?> readThemeSettings() async =>
      (await _preferences).getBool(themeSettingKey);

  @override
  Future<bool> writeThemeSettings({required bool isDark}) async =>
      (await _preferences).setBool(themeSettingKey, isDark);

  @override
  Future<bool?> readIsFirstLaunch() async =>
      (await _preferences).getBool(isFirstLaunchSettingKey);

  @override
  Future<bool> writeIsFirstLaunch() async =>
      (await _preferences).setBool(isFirstLaunchSettingKey, true);
}
