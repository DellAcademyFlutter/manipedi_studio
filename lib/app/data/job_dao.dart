import 'package:flutter/material.dart';
import 'package:manipedi_studio/app/model/job.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:manipedi_studio/app/repositories/local/database/db_helper.dart';

class JobDao {
  /// Insere um [Job] em sua tabela
  Future insertJob(Job job) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        DbHelper.TABLE_JOB_NAME,
        job.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [Job]
  Future<void> updateJob(Job job) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_JOB_NAME,
      job.toMap(),
      where: "id = ?",
      whereArgs: [job.id],
    );
  }

  /// Remove um [Job]
  Future<void> removeJob(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_JOB_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [Job].
  Future<List<Job>> getJobs() async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_JOB_NAME);

      return List.generate(
        maps.length,
        (i) {
          return Job.fromMap(map: maps[i]);
        },
      );
    } catch (ex) {
      return <Job>[];
    }
  }
}
