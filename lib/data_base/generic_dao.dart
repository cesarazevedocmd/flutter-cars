import 'package:car_project/data_base/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'entity.dart';

abstract class GenericDAO<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get table;

  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(table, entity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery("select * from $table");

    return list.map<T>((map) => fromMap(map));
  }

  Future<T> findById(int id) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery("select * from $table where id = ?", [id]);

    if (list.isNotEmpty) {
      return fromMap(list.first);
    }

    return null;
  }

  Future<int> count() async {
    final dbClient = await db;

    final itemsList = await dbClient.rawQuery("select count(*) from $table");

    return Sqflite.firstIntValue(itemsList);
  }

  Future<int> delete(int id) async {
    final dbClient = await db;

    final itemsDeleted = await dbClient.delete(table, where: "id = ?", whereArgs: [id]);

    return itemsDeleted;
  }

  Future<int> deleteAll() async {
    final dbClient = await db;

    final itemsDeleted = await dbClient.delete(table);

    return itemsDeleted;
  }
}
