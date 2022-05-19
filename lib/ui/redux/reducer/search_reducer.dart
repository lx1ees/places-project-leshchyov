import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:places/ui/redux/state/search_state.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<AppState>([
  TypedReducer<AppState, GetSearchResultsAction>(getSearchResultsReducer),
  TypedReducer<AppState, SearchResultsAction>(searchResultsReducer),
]);

AppState getSearchResultsReducer(
  AppState state,
  GetSearchResultsAction action,
) {
  return state.copyWith(searchState: const SearchLoadingState());
}

AppState searchResultsReducer(
  AppState state,
  SearchResultsAction action,
) {
  return state.copyWith(
      searchState: SearchSuccessState(foundPlaces: action.foundPlaces));
}
