import 'package:drift/drift.dart';

class CompanyInfo extends Table {
  TextColumn get id => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get nameAr => text().nullable()();
  TextColumn get addressEn => text().nullable()();
  TextColumn get addressAr => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get vatNumber => text().nullable()();
  TextColumn get crn => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get logoBase64 => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
