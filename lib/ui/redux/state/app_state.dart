import 'package:places/ui/redux/state/search_state.dart';

class AppState {
  final SearchState searchState;

  AppState({
    SearchState? searchState,
  }) : searchState = searchState ?? const SearchInitialState();

  AppState copyWith({
    SearchState? searchState,
  }) {
    return AppState(searchState: searchState ?? this.searchState);
  }
}
