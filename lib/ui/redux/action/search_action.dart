import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';

abstract class SearchAction {
  const SearchAction();
}

class GetSearchResultsAction extends SearchAction {
  final FiltersManager filtersManager;
  final LocationPoint currentLocation;
  final String searchString;

  const GetSearchResultsAction({
    required this.filtersManager,
    required this.currentLocation,
    required this.searchString,
  });
}

class SearchResultsAction extends SearchAction {
  final List<Place> foundPlaces;

  const SearchResultsAction({
    required this.foundPlaces,
  });
}
