import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'tables.dart';
import 'tables/basic_data.dart';
import 'tables/company_info.dart';
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
  PropertyRequests,
  Notifications,
  BuildingUnits,
  UnitDescriptions,
  Nationalities,
  RoomTypes,
  UnitDescriptionTypes,
  PropertyTypes,
  Regions,
  Provinces,
  Cities,
  Services,
  Currencies,
  CompanyInfo,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? impl.connect());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Add new columns for version 2
          await m.addColumn(users, users.fullNameAr);
          await m.addColumn(users, users.nationalId);
        }
        if (from < 3) {
          // Add new columns for version 3
          await m.addColumn(properties, properties.titleAr);
          await m.addColumn(properties, properties.descriptionAr);
        }
        if (from < 4) {
          // Add new columns for version 4
          await m.addColumn(properties, properties.propertyCategory);
        }
        if (from < 5) {
          // Add new tables for version 5
          await m.createTable(propertyRequests);
          await m.createTable(notifications);
        }
        if (from < 6) {
          // Add new tables for version 6
          await m.createTable(buildingUnits);
          await m.createTable(unitDescriptions);
        }
        if (from < 7) {
          // Add new tables for version 7
          await m.createTable(nationalities);
          await m.createTable(roomTypes);
          await m.createTable(unitDescriptionTypes);
          await m.createTable(propertyTypes);
          await m.createTable(regions);
          await m.createTable(provinces);
          await m.createTable(cities);
          await m.createTable(services);
          await m.createTable(currencies);
        }
        if (from < 8) {
          // Add new table for version 8
          await m.createTable(companyInfo);
        }
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
              propertyCategory: const Value('residential'),
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
              propertyCategory: const Value('residential'),
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
              propertyCategory: const Value('residential'),
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

    // Add more sample data if contracts are few (e.g. only the initial one)
    final contractCount =
        await (select(contracts).get()).then((list) => list.length);

    if (contractCount < 5) {
      const uuid = Uuid();
      final now = DateTime.now();
      final passwordHash = sha256.convert(utf8.encode('123')).toString();

      // Fetch existing users to link data or create new ones if needed
      // For simplicity, let's create a new set of users to ensure we have valid IDs
      final owner2Id = uuid.v4();
      final tenant2Id = uuid.v4();
      final buyer2Id = uuid.v4();

      await batch((batch) {
        // Owner 2
        batch.insert(
            users,
            UsersCompanion.insert(
              id: owner2Id,
              username: 'owner2',
              passwordHash: passwordHash,
              email: 'owner2@realestate.com',
              fullName: 'Sarah Owner',
              phone: const Value('+1234567894'),
              role: 'owner',
              address: const Value('456 Second St, City'),
              createdAt: now,
              updatedAt: now,
            ));

        // Tenant 2
        batch.insert(
            users,
            UsersCompanion.insert(
              id: tenant2Id,
              username: 'tenant2',
              passwordHash: passwordHash,
              email: 'tenant2@realestate.com',
              fullName: 'Mike Tenant',
              phone: const Value('+1234567895'),
              role: 'tenant',
              createdAt: now,
              updatedAt: now,
            ));

        // Buyer 2
        batch.insert(
            users,
            UsersCompanion.insert(
              id: buyer2Id,
              username: 'buyer2',
              passwordHash: passwordHash,
              email: 'buyer2@realestate.com',
              fullName: 'Alice Buyer',
              phone: const Value('+1234567896'),
              role: 'buyer',
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Create more properties
      final prop4Id = uuid.v4();
      final prop5Id = uuid.v4();
      final prop6Id = uuid.v4();
      final prop7Id = uuid.v4();

      await batch((batch) {
        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop4Id,
              ownerId: owner2Id,
              title: 'Suburban Family Home',
              description: const Value('Great for families, near schools'),
              propertyType: 'house',
              propertyCategory: const Value('residential'),
              listingType: 'sale',
              price: 450000.0,
              area: 200.0,
              bedrooms: const Value(4),
              bathrooms: const Value(3),
              address: '101 Maple Dr',
              city: 'Suburbia',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop5Id,
              ownerId: owner2Id,
              title: 'City Center Loft',
              description: const Value('Modern loft with city views'),
              propertyType: 'apartment',
              propertyCategory: const Value('residential'),
              listingType: 'rent',
              price: 1800.0,
              area: 80.0,
              bedrooms: const Value(1),
              bathrooms: const Value(1),
              address: '202 High St',
              city: 'Metropolis',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop6Id,
              ownerId: owner2Id, // Using owner2 for variety
              title: 'Commercial Space',
              description: const Value('Prime location for retail'),
              propertyType: 'commercial_store',
              propertyCategory: const Value('commercial'),
              listingType: 'rent',
              price: 5000.0,
              area: 150.0,
              address: '303 Market St',
              city: 'Metropolis',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop7Id,
              ownerId: owner2Id,
              title: 'Seaside Villa',
              description: const Value('Luxury villa with ocean view'),
              propertyType: 'villa',
              propertyCategory: const Value('residential'),
              listingType: 'sale',
              price: 1200000.0,
              area: 400.0,
              bedrooms: const Value(6),
              bathrooms: const Value(5),
              address: '404 Ocean Blvd',
              city: 'Beach City',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Create more contracts
      await batch((batch) {
        // Contract 2: Lease for prop5 (Loft)
        batch.insert(
            contracts,
            ContractsCompanion.insert(
              id: uuid.v4(),
              propertyId: prop5Id,
              ownerId: owner2Id,
              tenantBuyerId: tenant2Id,
              contractType: 'lease',
              startDate: now,
              endDate: Value(now.add(const Duration(days: 365))),
              monthlyRent: const Value(1800.0),
              depositAmount: const Value(3600.0),
              terms: const Value('Standard lease'),
              createdAt: now,
              updatedAt: now,
            ));

        // Contract 3: Purchase for prop4 (Family Home)
        batch.insert(
            contracts,
            ContractsCompanion.insert(
              id: uuid.v4(),
              propertyId: prop4Id,
              ownerId: owner2Id,
              tenantBuyerId: buyer2Id,
              contractType: 'purchase',
              startDate: now,
              salePrice: const Value(450000.0),
              depositAmount: const Value(45000.0),
              terms: const Value('Cash purchase'),
              status: const Value('completed'),
              createdAt: now,
              updatedAt: now,
            ));

        // Contract 4: Lease for prop6 (Commercial)
        batch.insert(
            contracts,
            ContractsCompanion.insert(
              id: uuid.v4(),
              propertyId: prop6Id,
              ownerId: owner2Id,
              tenantBuyerId: tenant2Id,
              contractType: 'lease',
              startDate: now,
              endDate: Value(now.add(const Duration(days: 730))),
              monthlyRent: const Value(5000.0),
              depositAmount: const Value(10000.0),
              terms: const Value('Commercial lease 2 years'),
              createdAt: now,
              updatedAt: now,
            ));
      });
    }
  }
}
