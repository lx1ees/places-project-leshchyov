import 'package:places/constants/app_strings.dart';

/// Категория достопримечательности с наименованием категории [name]
abstract class SightCategory {
  String get name;

  const SightCategory();
}

class RestaurantSightCategory extends SightCategory {
  @override
  String get name => AppStrings.restaurantCategoryTitle;

  const RestaurantSightCategory();
}

class HotelSightCategory extends SightCategory{
  @override
  String get name => AppStrings.hotelCategoryTitle;

  const HotelSightCategory();
}

class ParticularPlaceSightCategory extends SightCategory{
  @override
  String get name => AppStrings.particularPlaceCategoryTitle;

  const ParticularPlaceSightCategory();
}

class ParkSightCategory extends SightCategory{
  @override
  String get name => AppStrings.parkCategoryTitle;

  const ParkSightCategory();
}

class MuseumSightCategory extends SightCategory{
  @override
  String get name => AppStrings.museumCategoryTitle;

  const MuseumSightCategory();
}

class CafeSightCategory extends SightCategory{
  @override
  String get name => AppStrings.cafeCategoryTitle;

  const CafeSightCategory();
}
