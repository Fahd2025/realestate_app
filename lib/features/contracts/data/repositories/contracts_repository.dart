import 'package:drift/drift.dart';
import 'package:realestate_app/core/database/database.dart';

class ContractsRepository {
  final AppDatabase _database;

  ContractsRepository(this._database);

  Future<List<Contract>> getContracts({String? type}) async {
    final query = _database.select(_database.contracts);
    if (type != null) {
      query.where((tbl) => tbl.contractType.equals(type));
    }
    return query.get();
  }

  Stream<List<Contract>> watchContracts({String? type}) {
    final query = _database.select(_database.contracts);
    if (type != null) {
      query.where((tbl) => tbl.contractType.equals(type));
    }
    return query.watch();
  }

  Future<Contract?> getContractById(String id) async {
    return (_database.select(_database.contracts)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> createContract(ContractsCompanion contract) async {
    return _database.into(_database.contracts).insert(contract);
  }

  Future<bool> updateContract(ContractsCompanion contract) async {
    return await _database.update(_database.contracts).replace(contract);
  }

  Future<int> deleteContract(String id) async {
    return (_database.delete(_database.contracts)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // Advanced query with joins to get property and user details
  Stream<List<ContractWithDetails>> watchContractsWithDetails({String? type}) {
    // Create aliases for multiple joins on users table
    final ownerAlias = _database.alias(_database.users, 'owner');
    final tenantBuyerAlias = _database.alias(_database.users, 'tenant_buyer');

    final query = _database.select(_database.contracts).join([
      innerJoin(
        _database.properties,
        _database.properties.id.equalsExp(_database.contracts.propertyId),
      ),
      leftOuterJoin(
        ownerAlias,
        ownerAlias.id.equalsExp(_database.contracts.ownerId),
      ),
      leftOuterJoin(
        tenantBuyerAlias,
        tenantBuyerAlias.id.equalsExp(_database.contracts.tenantBuyerId),
      ),
    ]);

    if (type != null) {
      query.where(_database.contracts.contractType.equals(type));
    }

    return query.watch().map((rows) {
      return rows.map((row) {
        return ContractWithDetails(
          contract: row.readTable(_database.contracts),
          property: row.readTable(_database.properties),
          owner: row.readTableOrNull(ownerAlias),
          tenantBuyer: row.readTableOrNull(tenantBuyerAlias),
        );
      }).toList();
    });
  }
}

class ContractWithDetails {
  final Contract contract;
  final Property property;
  final User? owner;
  final User? tenantBuyer;

  ContractWithDetails({
    required this.contract,
    required this.property,
    this.owner,
    this.tenantBuyer,
  });
}
