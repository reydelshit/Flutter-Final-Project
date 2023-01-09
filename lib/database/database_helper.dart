import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  //Create Database Function
  static Future<sql.Database> createDatabase() async {
    return await sql.openDatabase('finalproj.db', version: 1,
        onCreate: (sql.Database database, version) async {
      await createTables(database);
    });
  }

  //Create Tables Function
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE logbook(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        fullName TEXT,
        purpose TEXT,
        contact INTEGER,
        timeIn TEXT,
        timeOut TEXT,
        dateCreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  ///Insert Student function
  static Future<int> insertLogBook(String? fullName, String? purpose,
      String? contact, String? timeIn, String? timeOut) async {
    final db = await DatabaseHelper.createDatabase();
    final data = {
      'fullname': fullName,
      'purpose': purpose,
      'contact': contact,
      'timeIn': timeIn,
      'timeOut': timeOut
    };
    final res = db.insert('logbook', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return res;
  }

  //Function to retrieve all Student data
  static Future<List<Map<String, dynamic>>>? retrieveLogBook() async {
    final db = await DatabaseHelper.createDatabase();
    return await db.query('logbook', orderBy: 'timeIn');
  }

  //Function to update student data
  static Future<int> updateLogBook(int id, String? fullName, String? purpose,
      String? contact, String? timeIn) async {
    final db = await DatabaseHelper.createDatabase();
    final res = db.rawUpdate(
        "UPDATE logbook SET fullname = '$fullName', purpose ='$purpose', contact ='$contact', timeIn = '$timeIn' WHERE id = $id ");
    return res;
  }

  //Function to delete student data
  static Future<int> deleteLogBook(int id) async {
    final db = await DatabaseHelper.createDatabase();
    final res = db.rawDelete("DELETE FROM logbook WHERE id = $id");
    return res;
  }
}
