import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class BasicDataRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  BasicDataRepository(this._db);

  // --- Nationalities ---
  Future<List<Nationality>> getNationalities() =>
      _db.select(_db.nationalities).get();

  Future<String> addNationality(String name, {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.nationalities).insert(NationalitiesCompanion.insert(
          id: id,
          name: name,
          nameAr: Value(nameAr),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateNationality(String id, String name, {String? nameAr}) =>
      (_db.update(_db.nationalities)..where((t) => t.id.equals(id))).write(
        NationalitiesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteNationality(String id) =>
      (_db.delete(_db.nationalities)..where((t) => t.id.equals(id))).go();

  // --- Room Types ---
  Future<List<RoomType>> getRoomTypes() => _db.select(_db.roomTypes).get();

  Future<String> addRoomType(String name, {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.roomTypes).insert(RoomTypesCompanion.insert(
          id: id,
          name: name,
          nameAr: Value(nameAr),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateRoomType(String id, String name, {String? nameAr}) =>
      (_db.update(_db.roomTypes)..where((t) => t.id.equals(id))).write(
        RoomTypesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteRoomType(String id) =>
      (_db.delete(_db.roomTypes)..where((t) => t.id.equals(id))).go();

  // --- Unit Description Types ---
  Future<List<UnitDescriptionType>> getUnitDescriptionTypes() =>
      _db.select(_db.unitDescriptionTypes).get();

  Future<String> addUnitDescriptionType(String name, {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.unitDescriptionTypes).insert(
        UnitDescriptionTypesCompanion.insert(
            id: id,
            name: name,
            nameAr: Value(nameAr),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now()));
    return id;
  }

  Future<void> updateUnitDescriptionType(String id, String name,
          {String? nameAr}) =>
      (_db.update(_db.unitDescriptionTypes)..where((t) => t.id.equals(id)))
          .write(
        UnitDescriptionTypesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteUnitDescriptionType(String id) =>
      (_db.delete(_db.unitDescriptionTypes)..where((t) => t.id.equals(id)))
          .go();

  // --- Property Types ---
  Future<List<PropertyType>> getPropertyTypes() =>
      _db.select(_db.propertyTypes).get();

  Future<String> addPropertyType(String name, {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.propertyTypes).insert(PropertyTypesCompanion.insert(
          id: id,
          name: name,
          nameAr: Value(nameAr),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updatePropertyType(String id, String name, {String? nameAr}) =>
      (_db.update(_db.propertyTypes)..where((t) => t.id.equals(id))).write(
        PropertyTypesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deletePropertyType(String id) =>
      (_db.delete(_db.propertyTypes)..where((t) => t.id.equals(id))).go();

  // --- Regions ---
  Future<List<Region>> getRegions() => _db.select(_db.regions).get();

  Future<String> addRegion(String name, {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.regions).insert(RegionsCompanion.insert(
          id: id,
          name: name,
          nameAr: Value(nameAr),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateRegion(String id, String name, {String? nameAr}) =>
      (_db.update(_db.regions)..where((t) => t.id.equals(id))).write(
        RegionsCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteRegion(String id) =>
      (_db.delete(_db.regions)..where((t) => t.id.equals(id))).go();

  // --- Provinces ---
  Future<List<Province>> getProvinces() => _db.select(_db.provinces).get();

  Future<List<Province>> getProvincesByRegion(String regionId) =>
      (_db.select(_db.provinces)..where((t) => t.regionId.equals(regionId)))
          .get();

  Future<String> addProvince(String regionId, String name,
      {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.provinces).insert(ProvincesCompanion.insert(
          id: id,
          regionId: regionId,
          name: name,
          nameAr: Value(nameAr),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateProvince(String id, String name,
          {String? nameAr, String? regionId}) =>
      (_db.update(_db.provinces)..where((t) => t.id.equals(id))).write(
        ProvincesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          regionId: regionId != null ? Value(regionId) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteProvince(String id) =>
      (_db.delete(_db.provinces)..where((t) => t.id.equals(id))).go();

  // --- Cities ---
  Future<List<City>> getCities() => _db.select(_db.cities).get();

  Future<List<City>> getCitiesByProvince(String provinceId) =>
      (_db.select(_db.cities)..where((t) => t.provinceId.equals(provinceId)))
          .get();

  Future<String> addCity(String provinceId, String name,
      {String? nameAr}) async {
    final id = _uuid.v4();
    await _db.into(_db.cities).insert(CitiesCompanion.insert(
          id: id,
          provinceId: provinceId,
          name: name,
          nameAr: Value(nameAr),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateCity(String id, String name,
          {String? nameAr, String? provinceId}) =>
      (_db.update(_db.cities)..where((t) => t.id.equals(id))).write(
        CitiesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          provinceId:
              provinceId != null ? Value(provinceId) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteCity(String id) =>
      (_db.delete(_db.cities)..where((t) => t.id.equals(id))).go();

  // --- Services ---
  Future<List<Service>> getServices() => _db.select(_db.services).get();

  Future<String> addService(String name,
      {String? nameAr,
      String? description,
      String? descriptionAr,
      double? price}) async {
    final id = _uuid.v4();
    await _db.into(_db.services).insert(ServicesCompanion.insert(
          id: id,
          name: name,
          nameAr: Value(nameAr),
          description: Value(description),
          descriptionAr: Value(descriptionAr),
          price: Value(price),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateService(String id, String name,
          {String? nameAr,
          String? description,
          String? descriptionAr,
          double? price}) =>
      (_db.update(_db.services)..where((t) => t.id.equals(id))).write(
        ServicesCompanion(
          name: Value(name),
          nameAr: Value(nameAr),
          description: Value(description),
          descriptionAr: Value(descriptionAr),
          price: Value(price),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteService(String id) =>
      (_db.delete(_db.services)..where((t) => t.id.equals(id))).go();

  // --- Currencies ---
  Future<List<Currency>> getCurrencies() => _db.select(_db.currencies).get();

  Future<String> addCurrency(String code, String name,
      {String? nameAr, String? symbol, double? exchangeRate}) async {
    final id = _uuid.v4();
    await _db.into(_db.currencies).insert(CurrenciesCompanion.insert(
          id: id,
          code: code,
          name: name,
          nameAr: Value(nameAr),
          symbol: Value(symbol),
          exchangeRate: Value(exchangeRate ?? 1.0),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
    return id;
  }

  Future<void> updateCurrency(String id, String code, String name,
          {String? nameAr, String? symbol, double? exchangeRate}) =>
      (_db.update(_db.currencies)..where((t) => t.id.equals(id))).write(
        CurrenciesCompanion(
          code: Value(code),
          name: Value(name),
          nameAr: Value(nameAr),
          symbol: Value(symbol),
          exchangeRate:
              exchangeRate != null ? Value(exchangeRate) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> deleteCurrency(String id) =>
      (_db.delete(_db.currencies)..where((t) => t.id.equals(id))).go();
}
