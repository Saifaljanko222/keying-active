import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class sqldb {
  static Database? _db;

  Future<Database?> get db async {
    //check database if موجود

    if (db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<bool> checkDatabaseConnection() async {
    // Get the path to the database file
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, 'shop.db');

    // Open the database
    Database database = await openDatabase(
      fullPath,
    );

    bool isConnected = await database.isOpen;
//   s
    print('Concreate========================================');

    // Close the database
    // await database.close();

    return isConnected;
  }

  Future<List<Map<String, dynamic>>> selectData() async {
    // Get the path to the database file
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, 'shop.db');

    // Open the database
    Database database = await openDatabase(fullPath);

    // Execute the select query
    List<Map<String, dynamic>> results = await database.query('FIRESTTABLE');

    // Close the database
    await database.close();

    return results;
  }

  Future<void> insertData(String key) async {
    // Get the path to the database file
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, 'shop.db');

    // Open the database
    Database database = await openDatabase(fullPath);

    // Create a map of values to be inserted
    Map<String, dynamic> row = {
      'key': key,
    };
    await database.insert('FIRESTTABLE', row);

    // Close the database
    await database.close();
  }

  Future<void> deleteRow(int id) async {
    // Get the path to the database file
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, 'shop.db');

    // Open the database
    Database database = await openDatabase(fullPath);

    // Delete the row from the table
    await database.delete(
      'FIRESTTABLE',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Close the database
    await database.close();
  }

  intialDb() async {
    //create databse
    String database = await getDatabasesPath();
    String path = join(database, 'shop.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate,
        version: 1,
        onUpgrade: _onUpgrade); //to change data base
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("upgrade=======================================");
  }

  _onCreate(Database db, int virsion) async {
    //create table in database
    await db.execute(
        '''
        CREATE TABLE "FIRESTTABLE" (
        "id"  NOT NULL PRIMARY KEY AUTOINCREMENT,
        "KEY"  TEXT NOT NULL
        )
''');

    print('Concreate========================================');
  }

  //select data
  selectdata(String sql) async {
    Database? mydb = await db; //!
    List<Map> respons = await mydb!.rawQuery(sql);
    return respons;
  }

  ///insert into database
  ///
  ///
  Future<int> Insertdata(String sql) async {
    Database? mydb = await db; //!
    int respons = await mydb!.rawInsert(sql);
    return respons;
  }

  insertdata(String sql) async {
    Database? mydb = await db; //!
    int respons = await mydb!.rawInsert(sql);
    return respons;
  }

  //updata data
  updatedata(String sql) async {
    Database? mydb = await db; //!
    int respons = await mydb!.rawUpdate(sql);
    return respons;
  }

//delete data
  deletedata(String sql) async {
    Database? mydb = await db; //!
    int respons = await mydb!.rawDelete(sql);
    return respons;
  }
}
