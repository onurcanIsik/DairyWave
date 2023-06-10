import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DairySql {
  static Future<void> createTable(sql.Database database) async {
    await database.execute(""" CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      dairyTitle TEXT,
      dairyText TEXT,
      dairyDate TEXT,
      dairyImage TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dairyData.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

  //! CREATE DAIRY

  static Future<int> createDairy(
    String? dairyTitle,
    String? dairyText,
    String? dairyDate,
    String? dairyImage,
  ) async {
    final db = await DairySql.db();
    final data = {
      'dairyTitle': dairyTitle,
      'dairyText': dairyText,
      'dairyDate': dairyDate,
      'dairyImage': dairyImage,
    };
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }
  //! GET DAIRY

  static Future<List<Map<String, dynamic>>> getDairy() async {
    final db = await DairySql.db();
    return db.query('items', orderBy: 'id');
  }

  //! UPDATE DAIRY

  static Future<int> updateDairy(
    int id,
    String? dairyTitle,
    String? dairyText,
  ) async {
    final db = await DairySql.db();
    final data = {
      'dairyTitle': dairyTitle,
      'dairyText': dairyText,
    };
    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //! DELETE DAIRY

  static Future<void> deleteDairy(int id) async {
    final db = await DairySql.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      Fluttertoast.showToast(
        msg: "Something went wrong!",
        timeInSecForIosWeb: 3,
      );
    }
  }

  //! DELETE ALL DAIRY
  static Future<void> deleteAllDairy() async {
    final db = await DairySql.db();
    await db.delete('items');
  }
}
