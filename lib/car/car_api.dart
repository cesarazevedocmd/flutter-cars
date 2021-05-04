import 'dart:convert';

import 'package:car_project/api/api_response.dart';
import 'package:http/http.dart' as http;

import 'car.dart';

class CarApi {
  static Future<ApiResponse<List<Car>>> loadCars() async {
    var url = Uri.parse("https://carros-springboot.herokuapp.com/api/v1/carros");

    final token =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTYyMTAyMTQ3Niwicm9sIjpbIlJPTEVfQURNSU4iXX0.eny5cc2CZfFgdmtE7cTGl6edr42h_rp3jt7uHVoUWIah15dkH3YsaJGxIerEbz5Mf_AHKEyusd7Cknfz9hBWhQ";
    var headers = {"Content-Type": "application/json", "Authorization": "Bearer $token"};

    var response = await http.get(url, headers: headers);

    List bodyList = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Car> carList = bodyList.map<Car>((e) => Car.fromJson(e)).toList();
      return ApiResponse.ok(carList);
    }
    return ApiResponse.ok([]);
  }
}
