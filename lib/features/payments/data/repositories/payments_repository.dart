import 'package:realestate_app/core/database/database.dart';

class PaymentsRepository {
  final AppDatabase _database;

  PaymentsRepository(this._database);

  Future<List<Payment>> getPaymentsForContract(String contractId) async {
    return (_database.select(_database.payments)
          ..where((tbl) => tbl.contractId.equals(contractId)))
        .get();
  }

  Stream<List<Payment>> watchPaymentsForContract(String contractId) {
    return (_database.select(_database.payments)
          ..where((tbl) => tbl.contractId.equals(contractId)))
        .watch();
  }

  Future<int> createPayment(PaymentsCompanion payment) async {
    return _database.into(_database.payments).insert(payment);
  }

  Future<bool> updatePayment(PaymentsCompanion payment) async {
    final rowsAffected = await (_database.update(_database.payments)
          ..where((tbl) => tbl.id.equals(payment.id.value)))
        .write(payment);
    return rowsAffected > 0;
  }

  Future<int> deletePayment(String id) async {
    return (_database.delete(_database.payments)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
