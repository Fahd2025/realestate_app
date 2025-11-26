import '../../../core/database/database.dart';

// Temporary data structures for managing units before saving
class TempUnit {
  final String? id; // null for new units
  final String unitType;
  final String unitNumber;
  final String? floorNumber;
  final String status;
  final TempUnitDescription description;

  TempUnit({
    this.id,
    required this.unitType,
    required this.unitNumber,
    this.floorNumber,
    required this.status,
    required this.description,
  });

  factory TempUnit.fromDatabase(BuildingUnit unit, UnitDescription? desc) {
    return TempUnit(
      id: unit.id,
      unitType: unit.unitType,
      unitNumber: unit.unitNumber,
      floorNumber: unit.floorNumber,
      status: unit.status,
      description: TempUnitDescription.fromDatabase(desc),
    );
  }
}

class TempUnitDescription {
  final int? rooms;
  final int? bathrooms;
  final int? kitchens;
  final String? description;
  final String? descriptionAr;

  TempUnitDescription({
    this.rooms,
    this.bathrooms,
    this.kitchens,
    this.description,
    this.descriptionAr,
  });

  factory TempUnitDescription.fromDatabase(UnitDescription? desc) {
    if (desc == null) {
      return TempUnitDescription();
    }
    return TempUnitDescription(
      rooms: desc.rooms,
      bathrooms: desc.bathrooms,
      kitchens: desc.kitchens,
      description: desc.description,
      descriptionAr: desc.descriptionAr,
    );
  }
}

class UnitWithDescription {
  final BuildingUnit unit;
  final UnitDescription? description;

  UnitWithDescription({required this.unit, this.description});
}
