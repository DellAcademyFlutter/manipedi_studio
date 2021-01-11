import 'package:flutter/material.dart';

import 'package:manipedi_studio/app/model/customer.dart';
import 'package:manipedi_studio/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class CustomerDao {
  /// Insere um [Customer] em sua tabela
  Future insertCustomer(Customer customer) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        DbHelper.TABLE_CUSTOMER_SERVICE,
        customer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Atualiza um [Customer]
  Future<void> updateCustomer(Customer customer) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      DbHelper.TABLE_CUSTOMER_SERVICE,
      customer.toMap(),
      where: "id = ?",
      whereArgs: [customer.id],
    );
  }

  /// Remove um [Customer]
  Future<void> removeCustomer(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      DbHelper.TABLE_CUSTOMER_SERVICE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Retorna uma [List] de objetos [Customers].
  Future<List<Customer>> getCustomers() async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(DbHelper.TABLE_CUSTOMER_SERVICE);

      return List.generate(
        maps.length,
        (i) {
          return Customer.fromMap(map: maps[i]);
        },
      );
    } catch (ex) {
      return <Customer>[];
    }
  }
}
