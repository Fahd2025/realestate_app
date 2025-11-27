import 'package:drift/drift.dart';

// Nationalities table
class Nationalities extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Room Types table
class RoomTypes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Unit Description Types table (Lookup for unit descriptions)
class UnitDescriptionTypes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Property Types table
class PropertyTypes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Regions table
class Regions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Provinces table
class Provinces extends Table {
  TextColumn get id => text()();
  TextColumn get regionId =>
      text().references(Regions, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Cities table
class Cities extends Table {
  TextColumn get id => text()();
  TextColumn get provinceId =>
      text().references(Provinces, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Services table
class Services extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get descriptionAr => text().nullable()();
  RealColumn get price => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Currencies table
class Currencies extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()(); // USD, SAR, etc.
  TextColumn get name => text()();
  TextColumn get nameAr => text().nullable()();
  TextColumn get symbol => text().nullable()();
  RealColumn get exchangeRate => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}
