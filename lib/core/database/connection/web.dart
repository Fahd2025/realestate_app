import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

/// Opens a connection to the database for web platforms using IndexedDB and sqlite3.wasm
QueryExecutor connect() {
  return LazyDatabase(() async {
    final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
    final fs = await IndexedDbFileSystem.open(dbName: 'realestate_db');
    sqlite3.registerVirtualFileSystem(fs, makeDefault: true);

    return WasmDatabase(
      sqlite3: sqlite3,
      path: '/drift/realestate.db',
    );
  });
}
