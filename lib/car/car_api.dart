import 'dart:convert';

import 'package:car_project/api/api_response.dart';
import 'package:http/http.dart' as http;

import 'car.dart';

class CarApi {
  static Future<ApiResponse<List<Car>>> loadCars() async {
    /*try {
      var url = Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros");

      final token =
          "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTYyMTAyMTQ3Niwicm9sIjpbIlJPTEVfQURNSU4iXX0.eny5cc2CZfFgdmtE7cTGl6edr42h_rp3jt7uHVoUWIah15dkH3YsaJGxIerEbz5Mf_AHKEyusd7Cknfz9hBWhQ";
      var headers = {"Content-Type": "application/json", "Authorization": "Bearer $token"};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var bodyList = json.decode(response.body);
        List<Car> carList = bodyList.map<String>((car) => Car.fromJson(car));
        return ApiResponse.ok(carList);
      }

      return ApiResponse.error("Load cars Error");
    } catch (error, exception) {
      return ApiResponse.error("$error => $exception");
    }*/
  }
}
