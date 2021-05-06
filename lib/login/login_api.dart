import 'dart:convert';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/login/user.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String login, String password) async {
    try{
      var url = "https://carros-springboot.herokuapp.com/api/v2/login";

      Map params = {"username": login, "password": password};

      Map<String, String> headers = {"Content-Type": "application/json"};

      var result = await http.post(Uri.parse(url), headers: headers, body: json.encode(params));

      Map resultBody = json.decode(result.body);

      if (result.statusCode == 200 || result.statusCode == 201) {
        final user = User.fromJson(resultBody);
        UserManager.saveUser(user);
        return ApiResponse.ok(user);
      }
      return ApiResponse.error(resultBody["error"]);
    } catch(error, exception){
      return ApiResponse.error("Login error $error => $exception");
    }
  }
}
