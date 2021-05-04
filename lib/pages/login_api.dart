import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String password) async {
    var url = "https://carros-springboot.herokuapp.com/api/v2/login";

    Map params = {"username": login, "password": password};

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(params));

    print("STATUS => ${response.statusCode}");
    print("BODY => ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201){

      Map mapResponse = json.decode(response.body);
      String name = mapResponse["nome"];
      String email = mapResponse["email"];

      print("NAME => $name");
      print("EMAIL => $email");

      return true;
    }
    return false;
  }
}
