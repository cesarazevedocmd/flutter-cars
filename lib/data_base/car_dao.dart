import 'package:car_project/model/car.dart';
import 'package:car_project/model/car_type.dart';
import 'package:car_project/data_base/generic_dao.dart';

class CarDAO extends GenericDAO<Car> {
  @override
  Car fromMap(Map<String, dynamic> map) => Car.fromMap(map);

  @override
  String get table => "car";

  Future<List<Car>> findAllByType(CarType type) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery("select * from $table where tipo = ?", [type.getType()]);

    return list.map<Car>((map) => fromMap(map));
  }
}