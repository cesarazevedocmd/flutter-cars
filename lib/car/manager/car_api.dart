import 'dart:convert';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:car_project/model/car_type.dart';
import 'package:http/http.dart' as http;

import '../../model/car.dart';

class CarApi {
  static Future<ApiResponse<List<Car>>> loadCars(CarType type) async {
    try {
      var url = Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros/tipo/${type.getType()}");
      print("GET => $url");
      final token = (await UserManager.getUser()).token;
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.get(url, headers: headers);

      List bodyList = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final carList = bodyList.map<Car>((e) => Car.fromMap(e)).toList();
        return ApiResponse.ok(carList);
      }
      return ApiResponse.ok([]);
    } catch (error) {
      throw error;
    }
  }
}