import 'package:drift/drift.dart';

// Users table
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get email => text().unique()();
  TextColumn get fullName => text()();
  TextColumn get fullNameAr => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get nationalId => text().nullable()();
  TextColumn get role => text()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Properties table
class Properties extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(Users, #id)();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get propertyType => text()();
  TextColumn get listingType => text()();
  RealColumn get price => real()();
  RealColumn get area => real()();
  IntColumn get bedrooms => integer().nullable()();
  IntColumn get bathrooms => integer().nullable()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get country => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get status => text().withDefault(const Constant('available'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Property images table
class PropertyImages extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId =>
      text().references(Properties, #id, onDelete: KeyAction.cascade)();
  TextColumn get imageUrl => text()();
  TextColumn get thumbnailUrl => text().nullable()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Contracts table
class Contracts extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get ownerId => text().references(Users, #id)();
  TextColumn get tenantBuyerId => text().references(Users, #id)();
  TextColumn get contractType => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  RealColumn get monthlyRent => real().nullable()();
  RealColumn get salePrice => real().nullable()();
  RealColumn get depositAmount => real().nullable()();
  TextColumn get terms => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Payments table
class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get contractId => text().references(Contracts, #id)();
  TextColumn get payerId => text().references(Users, #id)();
  RealColumn get amount => real()();
  DateTimeColumn get paymentDate => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get paymentType => text()();
  TextColumn get paymentMethod => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Purchase requests table
class PurchaseRequests extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get buyerId => text().references(Users, #id)();
  RealColumn get offeredPrice => real()();
  TextColumn get message => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column> get primaryKey => {id};
}

// Settings table
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}
