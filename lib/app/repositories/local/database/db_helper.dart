import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DATABASE_NAME = "manipedi_studio.db";
  static const TABLE_CUSTOMER_SERVICE = "customer";
  static const TABLE_JOB_NAME = "job";
  static const TABLE_SCHEDULE_NAME = "schedule";
  static const TABLE_SCHEDULING_NAME = "scheduling";

  static const SCRIPT_CREATE_TABLE_CUSTOMER_SQL =
      "CREATE TABLE IF NOT EXISTS customer (id INTEGER NOT NULL, name TEXT NOT NULL, "
      "number TEXT NOT NULL, numServices INTEGER, PRIMARY KEY(id AUTOINCREMENT))";

  static const SCRIPT_CREATE_TABLE_JOB_SQL =
      "CREATE TABLE IF NOT EXISTS job (id INTEGER NOT NULL, name TEXT NOT NULL, "
      "price REAL NOT NULL, PRIMARY KEY(id AUTOINCREMENT))";

  static const SCRIPT_CREATE_TABLE_SCHEDULE_SQL =
      "CREATE TABLE IF NOT EXISTS schedule (id INTEGER NOT NULL, date TEXT NOT NULL, "
      "time TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))";

  static const SCRIPT_CREATE_TABLE_SCHEDULING_SQL =
      "CREATE TABLE IF NOT EXISTS scheduling (customerId INTEGER NOT NULL, "
      "scheduleId INTEGER NOT NULL, jobId INTEGER NOT NULL, FOREIGN KEY(customerId) REFERENCES customer(id), "
      " FOREIGN KEY(jobId) REFERENCES job(id),  FOREIGN KEY(scheduleId) REFERENCES schedule(id))";

  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(SCRIPT_CREATE_TABLE_CUSTOMER_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_JOB_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_SCHEDULE_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_SCHEDULING_SQL);
      },
      version: 1,
    );
  }
}
