import 'dart:convert';
import 'dart:io';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/car/entity/car_type.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../entity/car.dart';

class CarApi {
  static Future<ApiResponse<List<Car>>> loadCars(CarType type) async {
    try {
      var url = Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros/tipo/${type.getType()}");

      Map headers = await getHeader();

      http.Response response = await http.get(url, headers: headers);

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

      http.Response response = await (car.id == null
          ? http.post(Uri.parse(url), headers: headers, body: car.toJson())
          : http.put(Uri.parse(url), headers: headers, body: car.toJson()));

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        Map bodyMap = json.decode(response.body);

        Car car = Car.fromMap(bodyMap);

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

  static Future<ApiResponse<bool>> delete(Car car) async {
    try {
      String uri = "https://carros-springboot.herokuapp.com/api/v2/carros/${car.id}";

      Map headers = await getHeader();

      http.Response response = await http.delete(Uri.parse(uri), headers: headers);

      if (response.statusCode == 200 && response.body != null && response.body.isNotEmpty) return ApiResponse.ok(true);
      return ApiResponse.error("Car not deleted");
    } catch (error) {
      return ApiResponse.error(error);
    }
  }

  static Future<ApiResponse<String>> uploadImage(File imageFile) async {
    try {
      Uri uri = Uri.parse("https://carros-springboot.herokuapp.com/api/v1/upload");

      Map headers = await getHeader();

      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64 = base64Encode(imageBytes);
      String name = path.basename(imageFile.path);

      Map<String, String> body = {"fileName": name, "mimeType": "image.jpeg", "base64": base64};
      String jsonBody = json.encode(body);

      http.Response response = await http.post(uri, headers: headers, body: jsonBody);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.body != null &&
          response.body.isNotEmpty) {
        Map result = json.decode(response.body);

        return ApiResponse.ok(result["url"]);
      }
      return ApiResponse.error("fail to upload image");
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
