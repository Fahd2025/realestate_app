import 'package:drift/drift.dart';
import '../../../core/database/database.dart';

class CompanyInfoRepository {
  final AppDatabase _db;
  static const String _companyInfoId = 'company_info_main';

  CompanyInfoRepository(this._db);

  Future<CompanyInfoData?> getCompanyInfo() async {
    return await (_db.select(_db.companyInfo)
          ..where((t) => t.id.equals(_companyInfoId)))
        .getSingleOrNull();
  }

  Future<void> saveCompanyInfo(CompanyInfoCompanion info) async {
    final existing = await getCompanyInfo();

    // Ensure ID is set
    final companionWithId = info.copyWith(
      id: const Value(_companyInfoId),
      updatedAt: Value(DateTime.now()),
    );

    if (existing != null) {
      await (_db.update(_db.companyInfo)
            ..where((t) => t.id.equals(_companyInfoId)))
          .write(companionWithId);
    } else {
      await _db.into(_db.companyInfo).insert(
            companionWithId.copyWith(
              createdAt: Value(DateTime.now()),
            ),
          );
    }
  }
}
