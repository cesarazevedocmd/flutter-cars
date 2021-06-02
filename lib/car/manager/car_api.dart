import 'dart:convert';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/car/entity/car_type.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../entity/car.dart';

class CarApi {
  static Future<ApiResponse<List<Car>>> loadCars(CarType type) async {
    try {
      var url = Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros/tipo/${type.getType()}");

      Map headers = await getHeader();

      Response response = await http.get(url, headers: headers);

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

  static Future<ApiResponse<bool>> save(Car car) async {
    try {
      String url = "https://carros-springboot.herokuapp.com/api/v2/carros";
      if (car.id != null) url += "/${car.id}";

      Map headers = await getHeader();

      Response response = await (car.id == null
          ? http.post(Uri.parse(url), headers: headers, body: car.toJson())
          : http.put(Uri.parse(url), headers: headers, body: car.toJson()));

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        Map bodyMap = json.decode(response.body);

        Car car = Car.fromMap(bodyMap);

        print("NEW CAR: $car}");

        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Error, check your data");
      }

      Map mapError = json.decode(response.body);
      return ApiResponse.error(mapError["error"]);
    } catch (error) {
      return ApiResponse.error(error);
    }
  }

  static Future<Map<String, String>> getHeader() async {
    final token = (await UserManager.getUser()).token;
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    return headers;
  }
}
