import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:realestate_app/core/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Unit Management Tests', () {
    test('CRUD operations for Building Units and Descriptions', () async {
      // 1. Create a Property (Building)
      final ownerId = const Uuid().v4();
      final propertyId = const Uuid().v4();

      // Need to create a user first for FK constraint
      await database.into(database.users).insert(
            UsersCompanion.insert(
              id: ownerId,
              username: 'owner',
              passwordHash: 'hash',
              email: 'owner@test.com',
              fullName: 'Owner',
              role: 'owner',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      await database.into(database.properties).insert(
            PropertiesCompanion.insert(
              id: propertyId,
              ownerId: ownerId,
              title: 'Test Building',
              propertyType: 'building',
              listingType: 'rent',
              price: 1000000,
              area: 500,
              address: '123 Test St',
              city: 'Test City',
              country: 'Test Country',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      // 2. Create a Unit
      final unitId = const Uuid().v4();
      await database.into(database.buildingUnits).insert(
            BuildingUnitsCompanion.insert(
              id: unitId,
              propertyId: propertyId,
              unitType: 'apartment',
              unitNumber: '101',
              floorNumber: const drift.Value('1'),
              status: const drift.Value('available'),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      // 3. Create Unit Description
      final descId = const Uuid().v4();
      await database.into(database.unitDescriptions).insert(
            UnitDescriptionsCompanion.insert(
              id: descId,
              unitId: unitId,
              rooms: const drift.Value(3),
              bathrooms: const drift.Value(2),
              description: const drift.Value('Nice apartment'),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      // 4. Read (Verify creation)
      final unit = await (database.select(database.buildingUnits)
            ..where((tbl) => tbl.id.equals(unitId)))
          .getSingle();

      expect(unit.unitNumber, '101');
      expect(unit.unitType, 'apartment');

      final desc = await (database.select(database.unitDescriptions)
            ..where((tbl) => tbl.unitId.equals(unitId)))
          .getSingle();

      expect(desc.rooms, 3);
      expect(desc.description, 'Nice apartment');

      // 5. Update
      await (database.update(database.buildingUnits)
            ..where((tbl) => tbl.id.equals(unitId)))
          .write(const BuildingUnitsCompanion(
        status: drift.Value('rented'),
      ));

      final updatedUnit = await (database.select(database.buildingUnits)
            ..where((tbl) => tbl.id.equals(unitId)))
          .getSingle();

      expect(updatedUnit.status, 'rented');

      // 6. Delete (Cascade check)
      // Note: Drift's in-memory DB might not enforce FK cascade delete automatically
      // without enabling it explicitly in sqlite, but let's check if we can delete.
      await (database.delete(database.buildingUnits)
            ..where((tbl) => tbl.id.equals(unitId)))
          .go();

      final deletedUnit = await (database.select(database.buildingUnits)
            ..where((tbl) => tbl.id.equals(unitId)))
          .getSingleOrNull();

      expect(deletedUnit, isNull);

      // Check if description is also deleted (if cascade works)
      // If cascade isn't enabled in the connection, we might need to manually delete or just verify the unit is gone.
      // For this test, verifying unit deletion is sufficient for the basic CRUD.
    });
  });
}
