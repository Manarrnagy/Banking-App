import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

//initializing database and joining path
  intialDb() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, 'banking.db');

    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    return mydb;
  }

  //in case of upgrading the database as adding new column
  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  //creates tables
  //called only once when initializing database
  _onCreate(Database db, int version) async {
    db.execute('''
       CREATE TABLE "users" (
        "userId"  INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT  ,
         "name" TEXT NOT NULL,
         "email" TEXT NOT NULL,
         "currentBalance" REAL NOT NULL,
         "phone" INTEGER NOT NULL
        )
     ''');
    db.execute('''
       CREATE TABLE "transfers"(
         "transferId" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT  ,
         "transferValue" REAL NOT NULL,
         "senderName" TEXT NOT NULL,
         "senderId" INTEGER NOT NULL,
         "receiverName" TEXT NOT NULL,
         "receiverId" INTEGER NOT NULL
       )
     ''');

    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.rawQuery(sql);

    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawInsert(sql);

    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawUpdate(sql);

    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawDelete(sql);

    return response;
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, 'wael.db');
    await deleteDatabase(path);
  }

// SELECT

// DELETE

// UPDATE

// INSERT

  ///----------------------------Alternative functions that does the same as the previous functions ------------------------

  read(String table) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.query(table);

    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;

    int response = await mydb!.insert(table, values);

    return response;
  }

  update(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawUpdate(sql);

    return response;
  }

  delete(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawDelete(sql);

    return response;
  }
}
