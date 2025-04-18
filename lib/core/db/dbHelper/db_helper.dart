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
        onCreate: (db, version) => _createTable(db),
        onDowngrade: (db, oldVersion, newVersion) => print("onDowngrade"),
        onUpgrade: (db, oldVersion, newVersion) => _upgrade(db),
        onOpen: (db) => print("onOpen"),
        singleInstance: true
    );
  }

}
_upgrade(Database db) {
  try {
    db.execute(dropTable);
    _createTable(db);
  } on Exception catch (e) {
    print(e.toString());
  }
}

_createTable(Database db) {
  try {
    db.execute(createTable).then(
          (value) => print('Table created'),
    );
  } on Exception catch (e) {
    print(e.toString());
  }
}
