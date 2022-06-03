// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SearchHistoryRequest extends DataClass
    implements Insertable<SearchHistoryRequest> {
  final int id;
  final String name;
  SearchHistoryRequest({required this.id, required this.name});
  factory SearchHistoryRequest.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchHistoryRequest(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  SearchHistoryRequestsCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoryRequestsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory SearchHistoryRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryRequest(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  SearchHistoryRequest copyWith({int? id, String? name}) =>
      SearchHistoryRequest(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistoryRequest(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoryRequest &&
          other.id == this.id &&
          other.name == this.name);
}

class SearchHistoryRequestsCompanion
    extends UpdateCompanion<SearchHistoryRequest> {
  final Value<int> id;
  final Value<String> name;
  const SearchHistoryRequestsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  SearchHistoryRequestsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<SearchHistoryRequest> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  SearchHistoryRequestsCompanion copyWith(
      {Value<int>? id, Value<String>? name}) {
    return SearchHistoryRequestsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryRequestsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoryRequestsTable extends SearchHistoryRequests
    with TableInfo<$SearchHistoryRequestsTable, SearchHistoryRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryRequestsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'search_history_requests';
  @override
  String get actualTableName => 'search_history_requests';
  @override
  VerificationContext validateIntegrity(
      Insertable<SearchHistoryRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistoryRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchHistoryRequest.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchHistoryRequestsTable createAlias(String alias) {
    return $SearchHistoryRequestsTable(attachedDatabase, alias);
  }
}

class PlaceImage extends DataClass implements Insertable<PlaceImage> {
  /// Наименование таблицы, к которой принадлежит место
  final String table;

  /// Идентификатор места
  final int placeId;

  /// URL изображения
  final String url;
  PlaceImage({required this.table, required this.placeId, required this.url});
  factory PlaceImage.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PlaceImage(
      table: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}table'])!,
      placeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_id'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['table'] = Variable<String>(table);
    map['place_id'] = Variable<int>(placeId);
    map['url'] = Variable<String>(url);
    return map;
  }

  PlaceImagesCompanion toCompanion(bool nullToAbsent) {
    return PlaceImagesCompanion(
      table: Value(table),
      placeId: Value(placeId),
      url: Value(url),
    );
  }

  factory PlaceImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceImage(
      table: serializer.fromJson<String>(json['table']),
      placeId: serializer.fromJson<int>(json['placeId']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'table': serializer.toJson<String>(table),
      'placeId': serializer.toJson<int>(placeId),
      'url': serializer.toJson<String>(url),
    };
  }

  PlaceImage copyWith({String? table, int? placeId, String? url}) => PlaceImage(
        table: table ?? this.table,
        placeId: placeId ?? this.placeId,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('PlaceImage(')
          ..write('table: $table, ')
          ..write('placeId: $placeId, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(table, placeId, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceImage &&
          other.table == this.table &&
          other.placeId == this.placeId &&
          other.url == this.url);
}

class PlaceImagesCompanion extends UpdateCompanion<PlaceImage> {
  final Value<String> table;
  final Value<int> placeId;
  final Value<String> url;
  const PlaceImagesCompanion({
    this.table = const Value.absent(),
    this.placeId = const Value.absent(),
    this.url = const Value.absent(),
  });
  PlaceImagesCompanion.insert({
    required String table,
    required int placeId,
    required String url,
  })  : table = Value(table),
        placeId = Value(placeId),
        url = Value(url);
  static Insertable<PlaceImage> custom({
    Expression<String>? table,
    Expression<int>? placeId,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (table != null) 'table': table,
      if (placeId != null) 'place_id': placeId,
      if (url != null) 'url': url,
    });
  }

  PlaceImagesCompanion copyWith(
      {Value<String>? table, Value<int>? placeId, Value<String>? url}) {
    return PlaceImagesCompanion(
      table: table ?? this.table,
      placeId: placeId ?? this.placeId,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (table.present) {
      map['table'] = Variable<String>(table.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceImagesCompanion(')
          ..write('table: $table, ')
          ..write('placeId: $placeId, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $PlaceImagesTable extends PlaceImages
    with TableInfo<$PlaceImagesTable, PlaceImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceImagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _tableMeta = const VerificationMeta('table');
  @override
  late final GeneratedColumn<String?> table = GeneratedColumn<String?>(
      'table', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int?> placeId = GeneratedColumn<int?>(
      'place_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [table, placeId, url];
  @override
  String get aliasedName => _alias ?? 'place_images';
  @override
  String get actualTableName => 'place_images';
  @override
  VerificationContext validateIntegrity(Insertable<PlaceImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('table')) {
      context.handle(
          _tableMeta, table.isAcceptableOrUnknown(data['table']!, _tableMeta));
    } else if (isInserting) {
      context.missing(_tableMeta);
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {table, url};
  @override
  PlaceImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PlaceImage.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlaceImagesTable createAlias(String alias) {
    return $PlaceImagesTable(attachedDatabase, alias);
  }
}

class FavoritePlace extends DataClass implements Insertable<FavoritePlace> {
  final int id;
  final double lat;
  final double lng;
  final double? distance;
  final String name;
  final String placeType;
  final String description;
  final DateTime? planDate;
  final bool isInFavorites;
  final bool isVisited;
  final String cardLook;
  FavoritePlace(
      {required this.id,
      required this.lat,
      required this.lng,
      this.distance,
      required this.name,
      required this.placeType,
      required this.description,
      this.planDate,
      required this.isInFavorites,
      required this.isVisited,
      required this.cardLook});
  factory FavoritePlace.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FavoritePlace(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lng: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng'])!,
      distance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      placeType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_type'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      planDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}plan_date']),
      isInFavorites: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_in_favorites'])!,
      isVisited: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_visited'])!,
      cardLook: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}card_look'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double?>(distance);
    }
    map['name'] = Variable<String>(name);
    map['place_type'] = Variable<String>(placeType);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || planDate != null) {
      map['plan_date'] = Variable<DateTime?>(planDate);
    }
    map['is_in_favorites'] = Variable<bool>(isInFavorites);
    map['is_visited'] = Variable<bool>(isVisited);
    map['card_look'] = Variable<String>(cardLook);
    return map;
  }

  FavoritePlacesCompanion toCompanion(bool nullToAbsent) {
    return FavoritePlacesCompanion(
      id: Value(id),
      lat: Value(lat),
      lng: Value(lng),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      name: Value(name),
      placeType: Value(placeType),
      description: Value(description),
      planDate: planDate == null && nullToAbsent
          ? const Value.absent()
          : Value(planDate),
      isInFavorites: Value(isInFavorites),
      isVisited: Value(isVisited),
      cardLook: Value(cardLook),
    );
  }

  factory FavoritePlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePlace(
      id: serializer.fromJson<int>(json['id']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      distance: serializer.fromJson<double?>(json['distance']),
      name: serializer.fromJson<String>(json['name']),
      placeType: serializer.fromJson<String>(json['placeType']),
      description: serializer.fromJson<String>(json['description']),
      planDate: serializer.fromJson<DateTime?>(json['planDate']),
      isInFavorites: serializer.fromJson<bool>(json['isInFavorites']),
      isVisited: serializer.fromJson<bool>(json['isVisited']),
      cardLook: serializer.fromJson<String>(json['cardLook']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'distance': serializer.toJson<double?>(distance),
      'name': serializer.toJson<String>(name),
      'placeType': serializer.toJson<String>(placeType),
      'description': serializer.toJson<String>(description),
      'planDate': serializer.toJson<DateTime?>(planDate),
      'isInFavorites': serializer.toJson<bool>(isInFavorites),
      'isVisited': serializer.toJson<bool>(isVisited),
      'cardLook': serializer.toJson<String>(cardLook),
    };
  }

  FavoritePlace copyWith(
          {int? id,
          double? lat,
          double? lng,
          double? distance,
          String? name,
          String? placeType,
          String? description,
          DateTime? planDate,
          bool? isInFavorites,
          bool? isVisited,
          String? cardLook}) =>
      FavoritePlace(
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        distance: distance ?? this.distance,
        name: name ?? this.name,
        placeType: placeType ?? this.placeType,
        description: description ?? this.description,
        planDate: planDate ?? this.planDate,
        isInFavorites: isInFavorites ?? this.isInFavorites,
        isVisited: isVisited ?? this.isVisited,
        cardLook: cardLook ?? this.cardLook,
      );
  @override
  String toString() {
    return (StringBuffer('FavoritePlace(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('distance: $distance, ')
          ..write('name: $name, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('planDate: $planDate, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isVisited: $isVisited, ')
          ..write('cardLook: $cardLook')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lat, lng, distance, name, placeType,
      description, planDate, isInFavorites, isVisited, cardLook);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePlace &&
          other.id == this.id &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.distance == this.distance &&
          other.name == this.name &&
          other.placeType == this.placeType &&
          other.description == this.description &&
          other.planDate == this.planDate &&
          other.isInFavorites == this.isInFavorites &&
          other.isVisited == this.isVisited &&
          other.cardLook == this.cardLook);
}

class FavoritePlacesCompanion extends UpdateCompanion<FavoritePlace> {
  final Value<int> id;
  final Value<double> lat;
  final Value<double> lng;
  final Value<double?> distance;
  final Value<String> name;
  final Value<String> placeType;
  final Value<String> description;
  final Value<DateTime?> planDate;
  final Value<bool> isInFavorites;
  final Value<bool> isVisited;
  final Value<String> cardLook;
  const FavoritePlacesCompanion({
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.distance = const Value.absent(),
    this.name = const Value.absent(),
    this.placeType = const Value.absent(),
    this.description = const Value.absent(),
    this.planDate = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isVisited = const Value.absent(),
    this.cardLook = const Value.absent(),
  });
  FavoritePlacesCompanion.insert({
    this.id = const Value.absent(),
    required double lat,
    required double lng,
    this.distance = const Value.absent(),
    required String name,
    required String placeType,
    required String description,
    this.planDate = const Value.absent(),
    required bool isInFavorites,
    required bool isVisited,
    required String cardLook,
  })  : lat = Value(lat),
        lng = Value(lng),
        name = Value(name),
        placeType = Value(placeType),
        description = Value(description),
        isInFavorites = Value(isInFavorites),
        isVisited = Value(isVisited),
        cardLook = Value(cardLook);
  static Insertable<FavoritePlace> custom({
    Expression<int>? id,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<double?>? distance,
    Expression<String>? name,
    Expression<String>? placeType,
    Expression<String>? description,
    Expression<DateTime?>? planDate,
    Expression<bool>? isInFavorites,
    Expression<bool>? isVisited,
    Expression<String>? cardLook,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (distance != null) 'distance': distance,
      if (name != null) 'name': name,
      if (placeType != null) 'place_type': placeType,
      if (description != null) 'description': description,
      if (planDate != null) 'plan_date': planDate,
      if (isInFavorites != null) 'is_in_favorites': isInFavorites,
      if (isVisited != null) 'is_visited': isVisited,
      if (cardLook != null) 'card_look': cardLook,
    });
  }

  FavoritePlacesCompanion copyWith(
      {Value<int>? id,
      Value<double>? lat,
      Value<double>? lng,
      Value<double?>? distance,
      Value<String>? name,
      Value<String>? placeType,
      Value<String>? description,
      Value<DateTime?>? planDate,
      Value<bool>? isInFavorites,
      Value<bool>? isVisited,
      Value<String>? cardLook}) {
    return FavoritePlacesCompanion(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      name: name ?? this.name,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
      planDate: planDate ?? this.planDate,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      isVisited: isVisited ?? this.isVisited,
      cardLook: cardLook ?? this.cardLook,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double?>(distance.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (placeType.present) {
      map['place_type'] = Variable<String>(placeType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (planDate.present) {
      map['plan_date'] = Variable<DateTime?>(planDate.value);
    }
    if (isInFavorites.present) {
      map['is_in_favorites'] = Variable<bool>(isInFavorites.value);
    }
    if (isVisited.present) {
      map['is_visited'] = Variable<bool>(isVisited.value);
    }
    if (cardLook.present) {
      map['card_look'] = Variable<String>(cardLook.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePlacesCompanion(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('distance: $distance, ')
          ..write('name: $name, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('planDate: $planDate, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isVisited: $isVisited, ')
          ..write('cardLook: $cardLook')
          ..write(')'))
        .toString();
  }
}

class $FavoritePlacesTable extends FavoritePlaces
    with TableInfo<$FavoritePlacesTable, FavoritePlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePlacesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double?> lng = GeneratedColumn<double?>(
      'lng', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double?> distance = GeneratedColumn<double?>(
      'distance', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _placeTypeMeta = const VerificationMeta('placeType');
  @override
  late final GeneratedColumn<String?> placeType = GeneratedColumn<String?>(
      'place_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _planDateMeta = const VerificationMeta('planDate');
  @override
  late final GeneratedColumn<DateTime?> planDate = GeneratedColumn<DateTime?>(
      'plan_date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _isInFavoritesMeta =
      const VerificationMeta('isInFavorites');
  @override
  late final GeneratedColumn<bool?> isInFavorites = GeneratedColumn<bool?>(
      'is_in_favorites', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_in_favorites IN (0, 1))');
  final VerificationMeta _isVisitedMeta = const VerificationMeta('isVisited');
  @override
  late final GeneratedColumn<bool?> isVisited = GeneratedColumn<bool?>(
      'is_visited', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_visited IN (0, 1))');
  final VerificationMeta _cardLookMeta = const VerificationMeta('cardLook');
  @override
  late final GeneratedColumn<String?> cardLook = GeneratedColumn<String?>(
      'card_look', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lat,
        lng,
        distance,
        name,
        placeType,
        description,
        planDate,
        isInFavorites,
        isVisited,
        cardLook
      ];
  @override
  String get aliasedName => _alias ?? 'favorite_places';
  @override
  String get actualTableName => 'favorite_places';
  @override
  VerificationContext validateIntegrity(Insertable<FavoritePlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('place_type')) {
      context.handle(_placeTypeMeta,
          placeType.isAcceptableOrUnknown(data['place_type']!, _placeTypeMeta));
    } else if (isInserting) {
      context.missing(_placeTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('plan_date')) {
      context.handle(_planDateMeta,
          planDate.isAcceptableOrUnknown(data['plan_date']!, _planDateMeta));
    }
    if (data.containsKey('is_in_favorites')) {
      context.handle(
          _isInFavoritesMeta,
          isInFavorites.isAcceptableOrUnknown(
              data['is_in_favorites']!, _isInFavoritesMeta));
    } else if (isInserting) {
      context.missing(_isInFavoritesMeta);
    }
    if (data.containsKey('is_visited')) {
      context.handle(_isVisitedMeta,
          isVisited.isAcceptableOrUnknown(data['is_visited']!, _isVisitedMeta));
    } else if (isInserting) {
      context.missing(_isVisitedMeta);
    }
    if (data.containsKey('card_look')) {
      context.handle(_cardLookMeta,
          cardLook.isAcceptableOrUnknown(data['card_look']!, _cardLookMeta));
    } else if (isInserting) {
      context.missing(_cardLookMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoritePlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FavoritePlace.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritePlacesTable createAlias(String alias) {
    return $FavoritePlacesTable(attachedDatabase, alias);
  }
}

class VisitedPlace extends DataClass implements Insertable<VisitedPlace> {
  final int id;
  final double lat;
  final double lng;
  final double? distance;
  final String name;
  final String placeType;
  final String description;
  final DateTime? planDate;
  final bool isInFavorites;
  final bool isVisited;
  final String cardLook;
  VisitedPlace(
      {required this.id,
      required this.lat,
      required this.lng,
      this.distance,
      required this.name,
      required this.placeType,
      required this.description,
      this.planDate,
      required this.isInFavorites,
      required this.isVisited,
      required this.cardLook});
  factory VisitedPlace.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VisitedPlace(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lng: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng'])!,
      distance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      placeType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_type'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      planDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}plan_date']),
      isInFavorites: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_in_favorites'])!,
      isVisited: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_visited'])!,
      cardLook: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}card_look'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double?>(distance);
    }
    map['name'] = Variable<String>(name);
    map['place_type'] = Variable<String>(placeType);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || planDate != null) {
      map['plan_date'] = Variable<DateTime?>(planDate);
    }
    map['is_in_favorites'] = Variable<bool>(isInFavorites);
    map['is_visited'] = Variable<bool>(isVisited);
    map['card_look'] = Variable<String>(cardLook);
    return map;
  }

  VisitedPlacesCompanion toCompanion(bool nullToAbsent) {
    return VisitedPlacesCompanion(
      id: Value(id),
      lat: Value(lat),
      lng: Value(lng),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      name: Value(name),
      placeType: Value(placeType),
      description: Value(description),
      planDate: planDate == null && nullToAbsent
          ? const Value.absent()
          : Value(planDate),
      isInFavorites: Value(isInFavorites),
      isVisited: Value(isVisited),
      cardLook: Value(cardLook),
    );
  }

  factory VisitedPlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitedPlace(
      id: serializer.fromJson<int>(json['id']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      distance: serializer.fromJson<double?>(json['distance']),
      name: serializer.fromJson<String>(json['name']),
      placeType: serializer.fromJson<String>(json['placeType']),
      description: serializer.fromJson<String>(json['description']),
      planDate: serializer.fromJson<DateTime?>(json['planDate']),
      isInFavorites: serializer.fromJson<bool>(json['isInFavorites']),
      isVisited: serializer.fromJson<bool>(json['isVisited']),
      cardLook: serializer.fromJson<String>(json['cardLook']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'distance': serializer.toJson<double?>(distance),
      'name': serializer.toJson<String>(name),
      'placeType': serializer.toJson<String>(placeType),
      'description': serializer.toJson<String>(description),
      'planDate': serializer.toJson<DateTime?>(planDate),
      'isInFavorites': serializer.toJson<bool>(isInFavorites),
      'isVisited': serializer.toJson<bool>(isVisited),
      'cardLook': serializer.toJson<String>(cardLook),
    };
  }

  VisitedPlace copyWith(
          {int? id,
          double? lat,
          double? lng,
          double? distance,
          String? name,
          String? placeType,
          String? description,
          DateTime? planDate,
          bool? isInFavorites,
          bool? isVisited,
          String? cardLook}) =>
      VisitedPlace(
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        distance: distance ?? this.distance,
        name: name ?? this.name,
        placeType: placeType ?? this.placeType,
        description: description ?? this.description,
        planDate: planDate ?? this.planDate,
        isInFavorites: isInFavorites ?? this.isInFavorites,
        isVisited: isVisited ?? this.isVisited,
        cardLook: cardLook ?? this.cardLook,
      );
  @override
  String toString() {
    return (StringBuffer('VisitedPlace(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('distance: $distance, ')
          ..write('name: $name, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('planDate: $planDate, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isVisited: $isVisited, ')
          ..write('cardLook: $cardLook')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lat, lng, distance, name, placeType,
      description, planDate, isInFavorites, isVisited, cardLook);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitedPlace &&
          other.id == this.id &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.distance == this.distance &&
          other.name == this.name &&
          other.placeType == this.placeType &&
          other.description == this.description &&
          other.planDate == this.planDate &&
          other.isInFavorites == this.isInFavorites &&
          other.isVisited == this.isVisited &&
          other.cardLook == this.cardLook);
}

class VisitedPlacesCompanion extends UpdateCompanion<VisitedPlace> {
  final Value<int> id;
  final Value<double> lat;
  final Value<double> lng;
  final Value<double?> distance;
  final Value<String> name;
  final Value<String> placeType;
  final Value<String> description;
  final Value<DateTime?> planDate;
  final Value<bool> isInFavorites;
  final Value<bool> isVisited;
  final Value<String> cardLook;
  const VisitedPlacesCompanion({
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.distance = const Value.absent(),
    this.name = const Value.absent(),
    this.placeType = const Value.absent(),
    this.description = const Value.absent(),
    this.planDate = const Value.absent(),
    this.isInFavorites = const Value.absent(),
    this.isVisited = const Value.absent(),
    this.cardLook = const Value.absent(),
  });
  VisitedPlacesCompanion.insert({
    this.id = const Value.absent(),
    required double lat,
    required double lng,
    this.distance = const Value.absent(),
    required String name,
    required String placeType,
    required String description,
    this.planDate = const Value.absent(),
    required bool isInFavorites,
    required bool isVisited,
    required String cardLook,
  })  : lat = Value(lat),
        lng = Value(lng),
        name = Value(name),
        placeType = Value(placeType),
        description = Value(description),
        isInFavorites = Value(isInFavorites),
        isVisited = Value(isVisited),
        cardLook = Value(cardLook);
  static Insertable<VisitedPlace> custom({
    Expression<int>? id,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<double?>? distance,
    Expression<String>? name,
    Expression<String>? placeType,
    Expression<String>? description,
    Expression<DateTime?>? planDate,
    Expression<bool>? isInFavorites,
    Expression<bool>? isVisited,
    Expression<String>? cardLook,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (distance != null) 'distance': distance,
      if (name != null) 'name': name,
      if (placeType != null) 'place_type': placeType,
      if (description != null) 'description': description,
      if (planDate != null) 'plan_date': planDate,
      if (isInFavorites != null) 'is_in_favorites': isInFavorites,
      if (isVisited != null) 'is_visited': isVisited,
      if (cardLook != null) 'card_look': cardLook,
    });
  }

  VisitedPlacesCompanion copyWith(
      {Value<int>? id,
      Value<double>? lat,
      Value<double>? lng,
      Value<double?>? distance,
      Value<String>? name,
      Value<String>? placeType,
      Value<String>? description,
      Value<DateTime?>? planDate,
      Value<bool>? isInFavorites,
      Value<bool>? isVisited,
      Value<String>? cardLook}) {
    return VisitedPlacesCompanion(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      name: name ?? this.name,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
      planDate: planDate ?? this.planDate,
      isInFavorites: isInFavorites ?? this.isInFavorites,
      isVisited: isVisited ?? this.isVisited,
      cardLook: cardLook ?? this.cardLook,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double?>(distance.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (placeType.present) {
      map['place_type'] = Variable<String>(placeType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (planDate.present) {
      map['plan_date'] = Variable<DateTime?>(planDate.value);
    }
    if (isInFavorites.present) {
      map['is_in_favorites'] = Variable<bool>(isInFavorites.value);
    }
    if (isVisited.present) {
      map['is_visited'] = Variable<bool>(isVisited.value);
    }
    if (cardLook.present) {
      map['card_look'] = Variable<String>(cardLook.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedPlacesCompanion(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('distance: $distance, ')
          ..write('name: $name, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('planDate: $planDate, ')
          ..write('isInFavorites: $isInFavorites, ')
          ..write('isVisited: $isVisited, ')
          ..write('cardLook: $cardLook')
          ..write(')'))
        .toString();
  }
}

class $VisitedPlacesTable extends VisitedPlaces
    with TableInfo<$VisitedPlacesTable, VisitedPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitedPlacesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double?> lng = GeneratedColumn<double?>(
      'lng', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double?> distance = GeneratedColumn<double?>(
      'distance', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _placeTypeMeta = const VerificationMeta('placeType');
  @override
  late final GeneratedColumn<String?> placeType = GeneratedColumn<String?>(
      'place_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _planDateMeta = const VerificationMeta('planDate');
  @override
  late final GeneratedColumn<DateTime?> planDate = GeneratedColumn<DateTime?>(
      'plan_date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _isInFavoritesMeta =
      const VerificationMeta('isInFavorites');
  @override
  late final GeneratedColumn<bool?> isInFavorites = GeneratedColumn<bool?>(
      'is_in_favorites', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_in_favorites IN (0, 1))');
  final VerificationMeta _isVisitedMeta = const VerificationMeta('isVisited');
  @override
  late final GeneratedColumn<bool?> isVisited = GeneratedColumn<bool?>(
      'is_visited', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_visited IN (0, 1))');
  final VerificationMeta _cardLookMeta = const VerificationMeta('cardLook');
  @override
  late final GeneratedColumn<String?> cardLook = GeneratedColumn<String?>(
      'card_look', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lat,
        lng,
        distance,
        name,
        placeType,
        description,
        planDate,
        isInFavorites,
        isVisited,
        cardLook
      ];
  @override
  String get aliasedName => _alias ?? 'visited_places';
  @override
  String get actualTableName => 'visited_places';
  @override
  VerificationContext validateIntegrity(Insertable<VisitedPlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('place_type')) {
      context.handle(_placeTypeMeta,
          placeType.isAcceptableOrUnknown(data['place_type']!, _placeTypeMeta));
    } else if (isInserting) {
      context.missing(_placeTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('plan_date')) {
      context.handle(_planDateMeta,
          planDate.isAcceptableOrUnknown(data['plan_date']!, _planDateMeta));
    }
    if (data.containsKey('is_in_favorites')) {
      context.handle(
          _isInFavoritesMeta,
          isInFavorites.isAcceptableOrUnknown(
              data['is_in_favorites']!, _isInFavoritesMeta));
    } else if (isInserting) {
      context.missing(_isInFavoritesMeta);
    }
    if (data.containsKey('is_visited')) {
      context.handle(_isVisitedMeta,
          isVisited.isAcceptableOrUnknown(data['is_visited']!, _isVisitedMeta));
    } else if (isInserting) {
      context.missing(_isVisitedMeta);
    }
    if (data.containsKey('card_look')) {
      context.handle(_cardLookMeta,
          cardLook.isAcceptableOrUnknown(data['card_look']!, _cardLookMeta));
    } else if (isInserting) {
      context.missing(_cardLookMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitedPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VisitedPlace.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VisitedPlacesTable createAlias(String alias) {
    return $VisitedPlacesTable(attachedDatabase, alias);
  }
}

abstract class _$PlacesDatabase extends GeneratedDatabase {
  _$PlacesDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SearchHistoryRequestsTable searchHistoryRequests =
      $SearchHistoryRequestsTable(this);
  late final $PlaceImagesTable placeImages = $PlaceImagesTable(this);
  late final $FavoritePlacesTable favoritePlaces = $FavoritePlacesTable(this);
  late final $VisitedPlacesTable visitedPlaces = $VisitedPlacesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchHistoryRequests, placeImages, favoritePlaces, visitedPlaces];
}
