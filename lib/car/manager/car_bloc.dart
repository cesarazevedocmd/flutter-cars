import 'dart:async';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/api/basic_bloc.dart';
import 'package:car_project/car/manager/car_dao.dart';
import 'package:car_project/car/entity/car.dart';
import 'package:car_project/car/entity/car_type.dart';
import 'package:car_project/util/network.dart';

import 'car_api.dart';

class CarBloc extends BasicBloc<List<Car>> {
  Future<List<Car>> load(CarType carType) async {
    try {
      bool isConnection = await Network.isConnected();

      if (isConnection) {
        ApiResponse<List<Car>> response = await CarApi.loadCars(carType);
        response.result.forEach((car) => CarDAO().save(car));
        add(response.result);
        return response.result;
      } else {
        List<Car> cars = await CarDAO().findAllByType(carType);
        add(cars);
        return cars;
      }
    } catch (error) {
      addError(error);
      return null;
    }
  }
}
