import 'dart:async';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/api/basic_stream.dart';
import 'package:car_project/car/car.dart';
import 'package:car_project/car/car_api.dart';
import 'package:car_project/car/car_type.dart';

class CarBloc extends BasicBloc<List<Car>>{

  Future<List<Car>> load(CarType carType) async {
    try {
      ApiResponse<List<Car>> response = await CarApi.loadCars(carType);
      add(response.result);
      return response.result;
    } catch (error) {
      addError(error);
      return null;
    }
  }
}
