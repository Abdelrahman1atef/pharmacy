import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../cart/cart_table_constants.dart';
import 'db_constants.dart';

class DbHelper {
  //2- get Db Path
  Future<String> _getDbPath() async {
    String path = await getDatabasesPath();
    return join(path, dbName);
  }

  //3- Create Db
  Future<Database> getDbInstance() async {
    String path = await _getDbPath();
    return await openDatabase(
        path,
        version: dbVersion,
        onConfigure: (db) => print("onConfigure"),
        onCreate: (db, version) => _createTables(db),
        onDowngrade: (db, oldVersion, newVersion) => print("onDowngrade"),
        onUpgrade: (db, oldVersion, newVersion) => _upgrade(db, oldVersion, newVersion),
        onOpen: (db) => print("onOpen"),
        singleInstance: true
    );
  }

  void _upgrade(Database db, int oldVersion, int newVersion) {
    try {
      if (oldVersion < 3) {
        // Create cache table for new version
        db.execute(createCacheTable);
        print('Cache table created during upgrade');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void _createTables(Database db) {
    try {
      // Create cart table
      db.execute(createTable).then(
        (value) => print('Cart table created'),
      );
      
      // Create cache table
      db.execute(createCacheTable).then(
        (value) => print('Cache table created'),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
