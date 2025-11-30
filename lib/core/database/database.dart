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
    const uuid = Uuid();
    final now = DateTime.now();

    // Seed Lookups
    final nationalityCount =
        await (select(nationalities).get()).then((list) => list.length);
    if (nationalityCount == 0) {
      await batch((batch) {
        // Nationalities
        batch.insert(
            nationalities,
            NationalitiesCompanion.insert(
                id: uuid.v4(),
                name: 'Saudi',
                nameAr: const Value('سعودي'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            nationalities,
            NationalitiesCompanion.insert(
                id: uuid.v4(),
                name: 'Egyptian',
                nameAr: const Value('مصري'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            nationalities,
            NationalitiesCompanion.insert(
                id: uuid.v4(),
                name: 'American',
                nameAr: const Value('أمريكي'),
                createdAt: now,
                updatedAt: now));

        // Room Types
        batch.insert(
            roomTypes,
            RoomTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Bedroom',
                nameAr: const Value('غرفة نوم'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            roomTypes,
            RoomTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Living Room',
                nameAr: const Value('غرفة معيشة'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            roomTypes,
            RoomTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Kitchen',
                nameAr: const Value('مطبخ'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            roomTypes,
            RoomTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Majlis',
                nameAr: const Value('مجلس'),
                createdAt: now,
                updatedAt: now));

        // Unit Description Types
        batch.insert(
            unitDescriptionTypes,
            UnitDescriptionTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Standard',
                nameAr: const Value('قياسي'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            unitDescriptionTypes,
            UnitDescriptionTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Deluxe',
                nameAr: const Value('ديلوكس'),
                createdAt: now,
                updatedAt: now));

        // Property Types
        batch.insert(
            propertyTypes,
            PropertyTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Apartment',
                nameAr: const Value('شقة'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            propertyTypes,
            PropertyTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Villa',
                nameAr: const Value('فيلا'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            propertyTypes,
            PropertyTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Land',
                nameAr: const Value('أرض'),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            propertyTypes,
            PropertyTypesCompanion.insert(
                id: uuid.v4(),
                name: 'Building',
                nameAr: const Value('عمارة'),
                createdAt: now,
                updatedAt: now));

        // Services
        batch.insert(
            services,
            ServicesCompanion.insert(
                id: uuid.v4(),
                name: 'Cleaning',
                nameAr: const Value('نظافة'),
                price: const Value(100.0),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            services,
            ServicesCompanion.insert(
                id: uuid.v4(),
                name: 'Maintenance',
                nameAr: const Value('صيانة'),
                price: const Value(150.0),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            services,
            ServicesCompanion.insert(
                id: uuid.v4(),
                name: 'Security',
                nameAr: const Value('حراسة'),
                price: const Value(2000.0),
                createdAt: now,
                updatedAt: now));

        // Currencies
        batch.insert(
            currencies,
            CurrenciesCompanion.insert(
                id: uuid.v4(),
                code: 'SAR',
                name: 'Saudi Riyal',
                nameAr: const Value('ريال سعودي'),
                symbol: const Value('ر.س'),
                exchangeRate: const Value(1.0),
                createdAt: now,
                updatedAt: now));
        batch.insert(
            currencies,
            CurrenciesCompanion.insert(
                id: uuid.v4(),
                code: 'USD',
                name: 'US Dollar',
                nameAr: const Value('دولار أمريكي'),
                symbol: const Value('\$'),
                exchangeRate: const Value(3.75),
                createdAt: now,
                updatedAt: now));
      });

      // Regions Hierarchy
      final regionId = uuid.v4();
      await into(regions).insert(RegionsCompanion.insert(
          id: regionId,
          name: 'Riyadh Region',
          nameAr: const Value('منطقة الرياض'),
          createdAt: now,
          updatedAt: now));

      final provinceId = uuid.v4();
      await into(provinces).insert(ProvincesCompanion.insert(
          id: provinceId,
          regionId: regionId,
          name: 'Riyadh Province',
          nameAr: const Value('محافظة الرياض'),
          createdAt: now,
          updatedAt: now));

      await into(cities).insert(CitiesCompanion.insert(
          id: uuid.v4(),
          provinceId: provinceId,
          name: 'Riyadh',
          nameAr: const Value('الرياض'),
          createdAt: now,
          updatedAt: now));
    }

    // Seed Company Info
    final infoCount =
        await (select(companyInfo).get()).then((list) => list.length);
    if (infoCount == 0) {
      await into(companyInfo).insert(CompanyInfoCompanion.insert(
        id: uuid.v4(),
        nameEn: const Value('Real Estate Co.'),
        nameAr: const Value('شركة العقارات'),
        addressEn: const Value('123 Business Rd, Riyadh'),
        addressAr: const Value('123 طريق الأعمال، الرياض'),
        phone: const Value('+966123456789'),
        email: const Value('info@realestate.com'),
        createdAt: now,
        updatedAt: now,
      ));
    }

    final userCount = await (select(users).get()).then((list) => list.length);

    if (userCount == 0) {
      // Hash password "123"

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

      // Add even more sample data
      final prop8Id = uuid.v4();
      final prop9Id = uuid.v4();
      final prop10Id = uuid.v4();

      await batch((batch) {
        // Property 8
        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop8Id,
              ownerId: owner2Id,
              title: 'Mountain Cabin',
              description: const Value('Cozy cabin in the woods'),
              propertyType: 'house',
              propertyCategory: const Value('residential'),
              listingType: 'rent',
              price: 150.0, // Daily rent maybe? or cheap monthly
              area: 60.0,
              bedrooms: const Value(2),
              bathrooms: const Value(1),
              address: '505 Forest Rd',
              city: 'Woodland',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        // Property 9
        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop9Id,
              ownerId: owner2Id,
              title: 'Downtown Office Floor',
              description: const Value('Entire floor for office space'),
              propertyType: 'commercial_office',
              propertyCategory: const Value('commercial'),
              listingType: 'rent',
              price: 8000.0,
              area: 500.0,
              address: '606 Business Blvd',
              city: 'Metropolis',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));

        // Property 10
        batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: prop10Id,
              ownerId: owner2Id,
              title: 'Industrial Warehouse',
              description: const Value('Large warehouse with loading dock'),
              propertyType: 'warehouse',
              propertyCategory: const Value('commercial'),
              listingType: 'sale',
              price: 1500000.0,
              area: 2000.0,
              address: '707 Industrial Park',
              city: 'Metropolis',
              country: 'USA',
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Contracts for new properties
      final contract5Id = uuid.v4();
      await batch((batch) {
        batch.insert(
            contracts,
            ContractsCompanion.insert(
              id: contract5Id,
              propertyId: prop9Id,
              ownerId: owner2Id,
              tenantBuyerId: tenant2Id,
              contractType: 'lease',
              startDate: now,
              endDate: Value(now.add(const Duration(days: 1095))), // 3 years
              monthlyRent: const Value(8000.0),
              depositAmount: const Value(16000.0),
              terms: const Value('Corporate lease'),
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Payments for new contract
      await batch((batch) {
        batch.insert(
            payments,
            PaymentsCompanion.insert(
              id: uuid.v4(),
              contractId: contract5Id,
              payerId: tenant2Id,
              amount: 16000.0,
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
              contractId: contract5Id,
              payerId: tenant2Id,
              amount: 8000.0,
              paymentDate: now,
              paymentType: 'rent',
              status: const Value('completed'),
              notes: const Value('First month rent'),
              createdAt: now,
              updatedAt: now,
            ));
      });

      // Purchase Requests
      await into(purchaseRequests).insert(PurchaseRequestsCompanion.insert(
        id: uuid.v4(),
        propertyId: prop10Id,
        buyerId: buyer2Id,
        offeredPrice: 1400000.0,
        message:
            const Value('Interested in the warehouse. Is price negotiable?'),
        createdAt: now,
        updatedAt: now,
      ));

      // Property Requests
      await into(propertyRequests).insert(PropertyRequestsCompanion.insert(
        id: uuid.v4(),
        buyerId: buyer2Id,
        propertyCategory: 'residential',
        propertyType: const Value('villa'),
        minPrice: const Value(1000000.0),
        maxPrice: const Value(2000000.0),
        location: 'Beach City',
        urgency: 'sooner',
        createdAt: now,
        updatedAt: now,
      ));

      // ---------------------------------------------------------
      // GENERATE 10+ MORE ROWS FOR EACH TABLE (Bulk Data)
      // ---------------------------------------------------------

      // 1. Users (15 new users)
      final newUsers = <String>[]; // Store IDs
      final newOwners = <String>[];
      final newTenants = <String>[];
      final newBuyers = <String>[];

      await batch((batch) {
        for (int i = 1; i <= 15; i++) {
          final uid = uuid.v4();
          newUsers.add(uid);
          String role = 'tenant';
          if (i <= 5) {
            role = 'owner';
            newOwners.add(uid);
          } else if (i <= 10) {
            role = 'tenant';
            newTenants.add(uid);
          } else {
            role = 'buyer';
            newBuyers.add(uid);
          }

          batch.insert(
            users,
            UsersCompanion.insert(
              id: uid,
              username: 'user_gen_$i',
              passwordHash: passwordHash,
              email: 'user_gen_$i@example.com',
              fullName: 'Generated User $i',
              fullNameAr: Value('مستخدم مولد $i'),
              phone: Value('+9665000000$i'),
              role: role,
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // 2. Properties (15 new properties)
      final newProperties = <String>[];
      await batch((batch) {
        for (int i = 1; i <= 15; i++) {
          final pid = uuid.v4();
          newProperties.add(pid);
          final ownerId = newOwners[i % newOwners.length]; // Round robin owners

          batch.insert(
            properties,
            PropertiesCompanion.insert(
              id: pid,
              ownerId: ownerId,
              title: 'Generated Property $i',
              titleAr: Value('عقار مولد $i'),
              description: Value('Description for generated property $i'),
              propertyType: i % 2 == 0 ? 'apartment' : 'villa',
              propertyCategory: const Value('residential'),
              listingType: i % 3 == 0 ? 'sale' : 'rent',
              price: (i * 1000.0) + 500.0,
              area: (i * 10.0) + 50.0,
              bedrooms: Value(i % 5 + 1),
              bathrooms: Value(i % 3 + 1),
              address: '$i Generated St',
              city: 'Riyadh',
              country: 'Saudi Arabia',
              status: const Value('available'),
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // 3. Property Images (2 per property = 30 images)
      await batch((batch) {
        for (final pid in newProperties) {
          batch.insert(
            propertyImages,
            PropertyImagesCompanion.insert(
              id: uuid.v4(),
              propertyId: pid,
              imageUrl:
                  'https://via.placeholder.com/800x600?text=Property+$pid',
              isPrimary: const Value(true),
              createdAt: now,
            ),
          );
          batch.insert(
            propertyImages,
            PropertyImagesCompanion.insert(
              id: uuid.v4(),
              propertyId: pid,
              imageUrl: 'https://via.placeholder.com/800x600?text=Detail+$pid',
              isPrimary: const Value(false),
              createdAt: now,
            ),
          );
        }
      });

      // 4. Contracts (10 new contracts)
      final newContracts = <String>[];
      await batch((batch) {
        for (int i = 0; i < 10; i++) {
          final cid = uuid.v4();
          newContracts.add(cid);
          // Use first 10 properties for contracts
          final pid = newProperties[i];
          final ownerId = newOwners[i % newOwners.length];
          final tenantId = newTenants[i % newTenants.length];

          batch.insert(
            contracts,
            ContractsCompanion.insert(
              id: cid,
              propertyId: pid,
              ownerId: ownerId,
              tenantBuyerId: tenantId,
              contractType: 'lease',
              startDate: now,
              endDate: Value(now.add(const Duration(days: 365))),
              monthlyRent: Value((i + 1) * 1000.0),
              depositAmount: Value((i + 1) * 500.0),
              terms: const Value('Standard generated lease terms'),
              status: const Value('active'),
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // 5. Payments (20 new payments, 2 per contract)
      await batch((batch) {
        for (final cid in newContracts) {
          // Rent payment
          batch.insert(
            payments,
            PaymentsCompanion.insert(
              id: uuid.v4(),
              contractId: cid,
              payerId: newTenants[0], // Simplified
              amount: 1000.0,
              paymentDate: now,
              paymentType: 'rent',
              status: const Value('completed'),
              createdAt: now,
              updatedAt: now,
            ),
          );
          // Service fee payment
          batch.insert(
            payments,
            PaymentsCompanion.insert(
              id: uuid.v4(),
              contractId: cid,
              payerId: newTenants[0],
              amount: 100.0,
              paymentDate: now,
              paymentType: 'service_fee',
              status: const Value('pending'),
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // 6. Purchase Requests (10 new requests)
      await batch((batch) {
        for (int i = 0; i < 10; i++) {
          batch.insert(
            purchaseRequests,
            PurchaseRequestsCompanion.insert(
              id: uuid.v4(),
              propertyId: newProperties[i],
              buyerId: newBuyers[i % newBuyers.length],
              offeredPrice: 500000.0 + (i * 10000),
              message: Value('Generated offer message $i'),
              status: const Value('pending'),
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // 7. Property Requests (10 new requests)
      await batch((batch) {
        for (int i = 0; i < 10; i++) {
          batch.insert(
            propertyRequests,
            PropertyRequestsCompanion.insert(
              id: uuid.v4(),
              buyerId: newBuyers[i % newBuyers.length],
              propertyCategory: 'residential',
              propertyType: const Value('apartment'),
              minPrice: const Value(100000.0),
              maxPrice: const Value(500000.0),
              location: 'Generated City $i',
              urgency: 'can_wait',
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // 8. Notifications (15 new notifications)
      await batch((batch) {
        for (int i = 0; i < 15; i++) {
          batch.insert(
            notifications,
            NotificationsCompanion.insert(
              id: uuid.v4(),
              userId: newUsers[i % newUsers.length],
              title: 'Notification $i',
              message: 'This is a generated notification message #$i',
              isRead: Value(i % 2 == 0),
              createdAt: now,
            ),
          );
        }
      });

      // 9. Additional Lookups (to ensure > 10 rows)
      await batch((batch) {
        // Nationalities (adding 10 more)
        final nations = [
          'Kuwaiti',
          'Bahraini',
          'Qatari',
          'Emirati',
          'Omani',
          'Jordanian',
          'Lebanese',
          'Syrian',
          'Indian',
          'Pakistani'
        ];
        final nationsAr = [
          'كويتي',
          'بحريني',
          'قطري',
          'إماراتي',
          'عماني',
          'أردني',
          'لبناني',
          'سوري',
          'هندي',
          'باكستاني'
        ];
        for (int i = 0; i < nations.length; i++) {
          batch.insert(
            nationalities,
            NationalitiesCompanion.insert(
              id: uuid.v4(),
              name: nations[i],
              nameAr: Value(nationsAr[i]),
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });

      // Cities (adding 10 more) - Outside batch because we need to await select
      final existingProvince =
          await (select(provinces)..limit(1)).getSingleOrNull();
      if (existingProvince != null) {
        await batch((batch) {
          for (int i = 1; i <= 10; i++) {
            batch.insert(
              cities,
              CitiesCompanion.insert(
                id: uuid.v4(),
                provinceId: existingProvince.id,
                name: 'City $i',
                nameAr: Value('مدينة $i'),
                createdAt: now,
                updatedAt: now,
              ),
            );
          }
        });
      }
    }

    // Seed Building Units if needed
    final unitCount =
        await (select(buildingUnits).get()).then((list) => list.length);
    if (unitCount == 0) {
      // Need an owner for the building
      final owner = await (select(users)
            ..where((u) => u.role.equals('owner'))
            ..limit(1))
          .getSingleOrNull();

      if (owner != null) {
        final buildingId = uuid.v4();
        // Create a Building Property
        await into(properties).insert(PropertiesCompanion.insert(
          id: buildingId,
          ownerId: owner.id,
          title: 'Skyline Residential Tower',
          titleAr: const Value('برج سكاي لاين السكني'),
          description: const Value('Luxury residential tower with 20 floors'),
          propertyType: 'building',
          propertyCategory: const Value('residential'),
          listingType: 'rent',
          price: 0, // Price depends on units
          area: 5000.0,
          address: '999 Tower St',
          city: 'Metropolis',
          country: 'USA',
          createdAt: now,
          updatedAt: now,
        ));

        // Create Units
        await batch((batch) {
          for (int floor = 1; floor <= 5; floor++) {
            for (int unit = 1; unit <= 4; unit++) {
              final unitId = uuid.v4();
              batch.insert(
                  buildingUnits,
                  BuildingUnitsCompanion.insert(
                    id: unitId,
                    propertyId: buildingId,
                    unitType: 'apartment',
                    unitNumber: '$floor-0$unit',
                    floorNumber: Value(floor.toString()),
                    status: const Value('available'),
                    createdAt: now,
                    updatedAt: now,
                  ));

              // Add Description for the unit
              batch.insert(
                  unitDescriptions,
                  UnitDescriptionsCompanion.insert(
                    id: uuid.v4(),
                    unitId: unitId,
                    rooms: const Value(3),
                    bathrooms: const Value(2),
                    kitchens: const Value(1),
                    description: const Value('Standard 3BR Apartment'),
                    createdAt: now,
                    updatedAt: now,
                  ));
            }
          }
        });
      }
    }
  }

  Future<void> clearData() async {
    await transaction(() async {
      // Delete in reverse order of dependencies if foreign keys are enforced
      // But here we just delete everything.
      await delete(payments).go();
      await delete(contracts).go();
      await delete(propertyImages).go();
      await delete(purchaseRequests).go();
      await delete(propertyRequests).go();
      await delete(notifications).go();
      await delete(buildingUnits).go();
      await delete(unitDescriptions).go();
      await delete(properties).go();
      await delete(companyInfo).go();
      await delete(currencies).go();
      await delete(services).go();
      await delete(cities).go();
      await delete(provinces).go();
      await delete(regions).go();
      await delete(propertyTypes).go();
      await delete(unitDescriptionTypes).go();
      await delete(roomTypes).go();
      await delete(nationalities).go();
      await delete(users).go();
      // Keep settings and static data tables
    });
  }
}
