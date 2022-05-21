import 'package:places/domain/model/place.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

class SearchSuccessState extends SearchState {
  final List<Place> foundPlaces;

  const SearchSuccessState({
    required this.foundPlaces,
  });
}
