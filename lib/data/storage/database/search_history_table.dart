import 'package:drift/drift.dart';

/// Таблица поисковых запросов
/// [id] - уникальный идентификатор (первичный ключ)
/// [name] - наименование запроса
class SearchHistoryRequests extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
}
