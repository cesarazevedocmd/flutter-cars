import 'package:car_project/car/entity/car.dart';
import 'package:car_project/car/entity/car_type.dart';
import 'package:car_project/util/sql/basic_dao.dart';

class CarDAO extends BasicDAO<Car> {
  @override
  Car fromMap(Map<String, dynamic> map) => Car.fromMap(map);

  @override
  String get table => "car";

  Future<List<Car>> findAllByType(CarType type) async {
    return await query("select * from $table where tipo = ?", [type.getType()]);
  }

  Future<List<Car>> findFavorites() async {
    return await query("SELECT * FROM car c, favorite f WHERE c.id = f.id");
  }
}
