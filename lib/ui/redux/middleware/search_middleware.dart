import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class SearchMiddleware implements MiddlewareClass<AppState> {
  final SearchInteractor _searchInteractor;

  SearchMiddleware({
    required SearchInteractor searchInteractor,
  }) : _searchInteractor = searchInteractor;

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is GetSearchResultsAction) {
      _searchInteractor
          .getSearchResults(
        filtersManager: action.filtersManager,
        currentLocation: action.currentLocation,
        searchString: action.searchString,
      )
          .then((value) {
        store.dispatch(SearchResultsAction(foundPlaces: value));
      });
    }
    next(action);
  }
}
