import 'dart:async';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/api/basic_stream.dart';
import 'package:car_project/data_base/car_dao.dart';
import 'package:car_project/model/car.dart';
import 'package:car_project/model/car_type.dart';

import 'car_api.dart';

class CarBloc extends BasicBloc<List<Car>> {
  Future<List<Car>> load(CarType carType) async {
    try {
      ApiResponse<List<Car>> response = await CarApi.loadCars(carType);

      CarDAO carDao = CarDAO();
      response.result.forEach((car) => carDao.save(car));

      add(response.result);
      return response.result;
    } catch (error) {
      addError(error);
      return null;
    }
  }
}
