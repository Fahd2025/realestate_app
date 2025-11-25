import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('should create property with residential category and specific type',
      () async {
    final ownerId = const Uuid().v4();
    final propertyId = const Uuid().v4();
    final now = DateTime.now();

    // Create owner first
    await database.into(database.users).insert(
          UsersCompanion.insert(
            id: ownerId,
            username: 'owner_test',
            passwordHash: 'hash',
            email: 'owner@test.com',
            fullName: 'Test Owner',
            role: 'owner',
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Create property
    await database.into(database.properties).insert(
          PropertiesCompanion.insert(
            id: propertyId,
            ownerId: ownerId,
            title: 'Test Penthouse',
            propertyCategory: const Value('residential'),
            propertyType: 'penthouse',
            listingType: 'sale',
            price: 1000000.0,
            area: 200.0,
            address: '123 Sky High',
            city: 'Cloud City',
            country: 'Sky',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final property = await (database.select(database.properties)
          ..where((tbl) => tbl.id.equals(propertyId)))
        .getSingle();

    expect(property.propertyCategory, 'residential');
    expect(property.propertyType, 'penthouse');
  });

  test('should create property with commercial category and specific type',
      () async {
    final ownerId = const Uuid().v4();
    final propertyId = const Uuid().v4();
    final now = DateTime.now();

    // Create owner first
    await database.into(database.users).insert(
          UsersCompanion.insert(
            id: ownerId,
            username: 'owner_commercial',
            passwordHash: 'hash',
            email: 'owner_c@test.com',
            fullName: 'Commercial Owner',
            role: 'owner',
            createdAt: now,
            updatedAt: now,
          ),
        );

    // Create property
    await database.into(database.properties).insert(
          PropertiesCompanion.insert(
            id: propertyId,
            ownerId: ownerId,
            title: 'Test Office',
            propertyCategory: const Value('commercial'),
            propertyType: 'office',
            listingType: 'rent',
            price: 5000.0,
            area: 100.0,
            address: '456 Business Park',
            city: 'Work City',
            country: 'Workland',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final property = await (database.select(database.properties)
          ..where((tbl) => tbl.id.equals(propertyId)))
        .getSingle();

    expect(property.propertyCategory, 'commercial');
    expect(property.propertyType, 'office');
  });
}
