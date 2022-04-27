import 'package:places/domain/filters_manager.dart';
import 'package:places/domain/search_history_manager.dart';

/// Класс-обертка аргументов роутинга на экран с поиском мест
class SightSearchScreenRouteArguments {
  final FiltersManager filtersManager;
  final SearchHistoryManager searchHistoryManager;

  const SightSearchScreenRouteArguments({
    required this.filtersManager,
    required this.searchHistoryManager,
  });
}
