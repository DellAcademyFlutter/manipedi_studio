import 'package:flutter/cupertino.dart';
import 'package:manipedi_studio/app/model/scheduling.dart';
import 'package:manipedi_studio/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class SchedulingDao {
  /// Insere um [scheduling] em sua tabela.
  Future insertScheduling(Scheduling scheduling) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        DbHelper.TABLE_SCHEDULING_NAME,
        scheduling.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [scheduling]
  Future<void> updateJob(Scheduling scheduling) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_SCHEDULING_NAME,
      scheduling.toMap(),
      where: "customerId = ? and scheduleId = ? and jobId = ?",
      whereArgs: [
        scheduling.customerId,
        scheduling.scheduleId,
        scheduling.jobId
      ],
    );
  }

  /// Deleta um [scheduling]
  Future<void> deleteScheduling(Scheduling scheduling) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_SCHEDULING_NAME,
      where: "customerId = ? and scheduleId = ? and jobId = ?",
      whereArgs: [
        scheduling.customerId,
        scheduling.scheduleId,
        scheduling.jobId
      ],
    );
  }

  /// Deleta um [customer] de um [scheduling]
  Future<void> deleteJobsCustomer({int customerId, int scheduleId}) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_SCHEDULING_NAME,
      where: "customerId = ? and scheduleId = ?",
      whereArgs: [customerId, scheduleId],
    );
  }

  /// Deleta um [job] de [schedulings]
  Future<void> deleteJobSchedulings({int jobId}) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_SCHEDULING_NAME,
      where: "jobId = ?",
      whereArgs: [jobId],
    );
  }

  /// Deleta um [schedule] de um [schedulings]
  Future<void> deleteScheduleSchedulings({int scheduleId}) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_SCHEDULING_NAME,
      where: "scheduleId = ?",
      whereArgs: [scheduleId],
    );
  }

  /// Retorna uma [List] de objetos [scheduling].
  Future<List<Scheduling>> getScheduleSchedulings(
      {int customerId, int scheduleId}) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_SCHEDULING_NAME);

      final userScheduling = <Scheduling>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i]['customerId'] == customerId &&
            maps[i]['scheduleId'] == scheduleId) {
          userScheduling.add(Scheduling.fromMap(map: maps[i]));
        }
      }
      return userScheduling;
    } catch (ex) {
      return <Scheduling>[];
    }
  }

  /// Retorna uma [List] de objetos [scheduling].
  Future<List<int>> getScheduleJobsIds({int scheduleId}) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_SCHEDULING_NAME);

      final userSchedulingIds = <int>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i]['scheduleId'] == scheduleId) {
          userSchedulingIds.add(maps[i]['jobId']);
        }
      }
      return userSchedulingIds;
    } catch (ex) {
      return <int>[];
    }
  }
}
