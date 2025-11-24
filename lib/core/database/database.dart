import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'tables.dart';
import 'connection/connection.dart' as impl;

part 'database.g.dart';

@DriftDatabase(tables: [
  Users,
  Properties,
  PropertyImages,
  Contracts,
  Payments,
  PurchaseRequests,
  Settings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
      },
    );
  }

  // Seed sample data if database is empty
  Future<void> _seedData() async {
    final userCount = await (select(users).get()).then((list) => list.length);

    if (userCount == 0) {
      const uuid = Uuid();
      final now = DateTime.now();

      // Hash password "123"
      final passwordHash = sha256.convert(utf8.encode('123')).toString();

      // Create sample users
      final adminId = uuid.v4();
      final ownerId = uuid.v4();
      final tenantId = uuid.v4();
      final buyerId = uuid.v4();

      await batch((batch) {
        // Admin user
        batch.insert(
            users,
            UsersCompanion.insert(
              id: adminId,
              username: 'admin',
              passwordHash: passwordHash,
              email: 'admin@realestate.com',
              fullName: 'System Administrator',
              phone: const Value('+1234567890'),
              role: 'admin',
              createdAt: now,
              updatedAt: now,
            ));

        // Owner user
        batch.insert(
            users,
            UsersCompanion.insert(
              id: ownerId,
              username: 'owner1',
              passwordHash: passwordHash,
              email: 'owner@realestate.com',
              fullName: 'John Owner',
              phone: const Value('+1234567891'),
              role: 'owner',
              address: const Value('123 Main St, City'),
              createdAt: now,
              updatedAt: now,
            ));

        // Tenant user
        batch.insert(
            users,
            UsersCompanion.insert(
              id: tenantId,
              username: 'tenant1',
              passwordHash: passwordHash,
              email: 'tenant@realestate.com',
              fullName: 'Jane Tenant',
              phone: const Value('+1234567892'),
              role: 'tenant',
              createdAt: now,
              updatedAt: now,
            ));

        // Buyer user
        batch.insert(
            users,
            UsersCompanion.insert(
              id: buyerId,
              username: 'buyer1',
              passwordHash: passwordHash,
              email: 'buyer@realestate.com',
              fullName: 'Bob Buyer',
              phone: const Value('+1234567893'),
              role: 'buyer',
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Create sample properties
      final property1Id = uuid.v4();
      final property2Id = uuid.v4();
      final property3Id = uuid.v4();

      await batch((batch) {
        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: property1Id,
              ownerId: ownerId,
              title: 'Luxury Apartment Downtown',
              description: const Value(
                  'Beautiful 3-bedroom apartment in the heart of the city'),
              propertyType: 'apartment',
              listingType: 'rent',
              price: 2500.0,
              area: 120.0,
              bedrooms: const Value(3),
              bathrooms: const Value(2),
              address: '456 Downtown Ave',
              city: 'New York',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: property2Id,
              ownerId: ownerId,
              title: 'Modern Villa with Pool',
              description: const Value(
                  'Spacious 5-bedroom villa with private pool and garden'),
              propertyType: 'villa',
              listingType: 'sale',
              price: 850000.0,
              area: 350.0,
              bedrooms: const Value(5),
              bathrooms: const Value(4),
              address: '789 Luxury Lane',
              city: 'Los Angeles',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: property3Id,
              ownerId: ownerId,
              title: 'Cozy Studio Apartment',
              description:
                  const Value('Perfect for students or young professionals'),
              propertyType: 'apartment',
              listingType: 'rent',
              price: 1200.0,
              area: 45.0,
              bedrooms: const Value(1),
              bathrooms: const Value(1),
              address: '321 College St',
              city: 'Boston',
              country: 'USA',
              status: const Value('rented'),
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Create sample contract
      final contract1Id = uuid.v4();
      await into(contracts).insert(ContractsCompanion.insert(
        id: contract1Id,
        propertyId: property3Id,
        ownerId: ownerId,
        tenantBuyerId: tenantId,
        contractType: 'rent',
        startDate: now,
        endDate: Value(now.add(const Duration(days: 365))),
        monthlyRent: const Value(1200.0),
        depositAmount: const Value(2400.0),
        terms: const Value('12-month lease agreement'),
        createdAt: now,
        updatedAt: now,
      ));

      // Create sample payments
      await batch((batch) {
        batch.insert(
            payments,
            PaymentsCompanion.insert(
              id: uuid.v4(),
              contractId: contract1Id,
              payerId: tenantId,
              amount: 2400.0,
              paymentDate: now,
              paymentType: 'deposit',
              status: const Value('completed'),
              notes: const Value('Security deposit'),
              createdAt: now,
              updatedAt: now,
            ));

        batch.insert(
            payments,
            PaymentsCompanion.insert(
              id: uuid.v4(),
              contractId: contract1Id,
              payerId: tenantId,
              amount: 1200.0,
              paymentDate: now,
              paymentType: 'rent',
              status: const Value('completed'),
              notes: const Value('First month rent'),
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Create sample purchase request
      await into(purchaseRequests).insert(PurchaseRequestsCompanion.insert(
        id: uuid.v4(),
        propertyId: property2Id,
        buyerId: buyerId,
        offeredPrice: 820000.0,
        message:
            const Value('Very interested in this property. Can we negotiate?'),
        createdAt: now,
        updatedAt: now,
      ));

      // Create default settings
      await batch((batch) {
        batch.insert(
            settings,
            SettingsCompanion.insert(
              key: 'theme_mode',
              value: 'light',
              updatedAt: now,
            ));

        batch.insert(
            settings,
            SettingsCompanion.insert(
              key: 'language',
              value: 'en',
              updatedAt: now,
            ));

        batch.insert(
            settings,
            SettingsCompanion.insert(
              key: 'color_scheme',
              value: 'blue',
              updatedAt: now,
            ));

        batch.insert(
            settings,
            SettingsCompanion.insert(
              key: 'api_url',
              value: '',
              updatedAt: now,
            ));

        batch.insert(
            settings,
            SettingsCompanion.insert(
              key: 'sync_enabled',
              value: 'false',
              updatedAt: now,
            ));
      });
    }
  }
}
