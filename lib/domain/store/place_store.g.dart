// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaceStore on PlaceStoreBase, Store {
  late final _$getPlacesFutureAtom =
      Atom(name: 'PlaceStoreBase.getPlacesFuture', context: context);

  @override
  ObservableFuture<List<Place>>? get getPlacesFuture {
    _$getPlacesFutureAtom.reportRead();
    return super.getPlacesFuture;
  }

  @override
  set getPlacesFuture(ObservableFuture<List<Place>>? value) {
    _$getPlacesFutureAtom.reportWrite(value, super.getPlacesFuture, () {
      super.getPlacesFuture = value;
    });
  }

  late final _$PlaceStoreBaseActionController =
      ActionController(name: 'PlaceStoreBase', context: context);

  @override
  void getPlaces(
      {required FiltersManager filtersManager,
      LocationPoint? currentLocation}) {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.getPlaces');
    try {
      return super.getPlaces(
          filtersManager: filtersManager, currentLocation: currentLocation);
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getLocalPlaces() {
    final _$actionInfo = _$PlaceStoreBaseActionController.startAction(
        name: 'PlaceStoreBase.getLocalPlaces');
    try {
      return super.getLocalPlaces();
    } finally {
      _$PlaceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getPlacesFuture: ${getPlacesFuture}
    ''';
  }
}
