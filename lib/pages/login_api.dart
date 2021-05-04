import 'dart:convert';

import 'package:car_project/api_respose.dart';
import 'package:car_project/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String login, String password) async {
    try{
      var url = "https://carros-springboot.herokuapp.com/api/v2/login";

      Map params = {"username": login, "password": password};

      Map<String, String> headers = {"Content-Type": "application/json"};

      var result = await http.post(Uri.parse(url), headers: headers, body: json.encode(params));

      print("STATUS => ${result.statusCode}");
      print("BODY => ${result.body}");
      Map resultBody = json.decode(result.body);

      if (result.statusCode == 200 || result.statusCode == 201) {
        return ApiResponse.ok(User.fromJson(resultBody));
      }
      return ApiResponse.error(resultBody["error"]);
    } catch(error, exception){
      print("Login error $error => $exception");
      return ApiResponse.error("Login error $error => $exception");
    }
  }
}
