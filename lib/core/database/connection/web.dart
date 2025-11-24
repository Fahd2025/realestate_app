import 'package:drift/drift.dart';
import 'package:drift/web.dart';

/// Opens a connection to the database for web platforms using IndexedDB
QueryExecutor connect() {
  return LazyDatabase(() async {
    final storage = await DriftWebStorage.indexedDbIfSupported('realestate_db');
    return WebDatabase.withStorage(storage);
  });
}
