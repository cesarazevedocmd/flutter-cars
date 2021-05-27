import 'package:car_project/util/sql/basic_dao.dart';
import 'package:car_project/car/entity/car.dart';
import 'package:car_project/car/entity/car_type.dart';

class CarDAO extends BasicDAO<Car> {
  @override
  Car fromMap(Map<String, dynamic> map) => Car.fromMap(map);

  @override
  String get table => "car";

  Future<List<Car>> findAllByType(CarType type) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery("select * from $table where tipo = ?", [type.getType()]);

    return list.map<Car>((car) => fromMap(car)).toList();
  }
}
