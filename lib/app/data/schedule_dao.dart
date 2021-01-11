import 'package:flutter/material.dart';
import 'package:manipedi_studio/app/model/schedule.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:manipedi_studio/app/repositories/local/database/db_helper.dart';

class ScheduleDao {

  /// Insere um [Schedule] em sua tabela
  Future<int> insertSchedule(Schedule schedule) async {
    try {
      final db = await DbHelper.getDatabase();
      int generatedId;

      await db.insert(
        DbHelper.TABLE_SCHEDULE_NAME,
        schedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ).then((value) => generatedId = value);

      return generatedId;
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [Schedule]
  Future<void> updateSchedule(Schedule schedule) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_SCHEDULE_NAME,
      schedule.toMap(),
      where: "id = ?",
      whereArgs: [schedule.id],
    );
  }

  /// Remove um [Schedule]
  Future<void> removeSchedule(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_SCHEDULE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [Schedule].
  Future<List<Schedule>> getSchedules() async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_SCHEDULE_NAME);

      return List.generate(
        maps.length,
            (i) {
          return Schedule.fromMap(map: maps[i]);
        },
      );
    } catch (ex) {
      return <Schedule>[];
    }
  }
}
