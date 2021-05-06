import 'dart:convert';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/car/car_type.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:http/http.dart' as http;

import 'car.dart';

class CarApi {
  static Future<ApiResponse<List<Car>>> loadCars(CarType type) async {
    var url = Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros/tipo/${type.getType()}");
    final token = (await UserManager.getUser()).token;
    var headers = {"Content-Type": "application/json", "Authorization": "Bearer $token"};

    var response = await http.get(url, headers: headers);

    List bodyList = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final carList = bodyList.map<Car>((e) => Car.fromJson(e)).toList();
      return ApiResponse.ok(carList);
    }
    return ApiResponse.ok([]);
  }
}
