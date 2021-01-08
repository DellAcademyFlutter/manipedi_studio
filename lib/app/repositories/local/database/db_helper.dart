import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DATABASE_NAME = "manipedi_studio.db";
  static const TABLE_CUSTOMER_NAME = "customer";
  static const SCRIPT_CREATE_TABLE_CUSTOMER_SQL =
      "CREATE TABLE IF NOT EXISTS customer (id INTEGER NOT NULL, name TEXT NOT NULL, "
      "number TEXT NOT NULL, numServices INTEGER, PRIMARY KEY(id AUTOINCREMENT))";

  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(SCRIPT_CREATE_TABLE_CUSTOMER_SQL);
      },
      version: 1,
    );
  }
}
