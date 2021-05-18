import 'dart:async';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/api/basic_stream.dart';
import 'package:car_project/car/car.dart';
import 'package:car_project/car/car_api.dart';
import 'package:car_project/car/car_type.dart';

class CarBloc extends BasicStream<List<Car>>{

  void load(CarType carType) async {
    try {
      ApiResponse<List<Car>> response = await CarApi.loadCars(carType);
      add(response.result);
    } catch (error) {
      addError(error);
    }
  }
}
