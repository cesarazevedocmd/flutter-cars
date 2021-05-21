import 'dart:async';

import 'package:car_project/car/car.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

// Data Access Object
class CarDAO {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Car car) async {
    var dbClient = await db;
    var id = await dbClient.insert("car", car.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<Car>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from car');

    final cars = list.map<Car>((json) => Car.fromJson(json)).toList();

    return cars;
  }

  Future<List<Car>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from car where tipo =? ',[tipo]);

    final cars = list.map<Car>((json) => Car.fromJson(json)).toList();

    return cars;
  }

  Future<Car> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from car where id = ?', [id]);

    if (list.length > 0) {
      return new Car.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(Car car) async {
    Car c = await findById(car.id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from car');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from car where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from car');
  }
}
