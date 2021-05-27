import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';
import 'entity.dart';

abstract class BasicDAO<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get table;

  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(table, entity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<T>> query(String sql, [List<Object> arguments]) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(sql, arguments);

    return list.map<T>((map) => fromMap(map)).toList();
  }

  Future<List<T>> findAll() async {
    return query("select * from $table");
  }

  Future<T> findById(int id) async {
    final list = await query("select * from $table where id = ?", [id]);

    return list.first ?? null;
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
