import 'package:places/domain/model/filters_manager.dart';
import 'package:places/domain/model/search_history_manager.dart';

/// Класс-обертка аргументов роутинга на экран с поиском мест
class PlaceSearchScreenRouteArguments {
  final FiltersManager filtersManager;
  final SearchHistoryManager searchHistoryManager;

  const PlaceSearchScreenRouteArguments({
    required this.filtersManager,
    required this.searchHistoryManager,
  });
}
