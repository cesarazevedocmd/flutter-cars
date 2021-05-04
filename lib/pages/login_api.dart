import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String password) async {
    var url = "http://livrowebservices.com.br/rest/login";

    var params = {"login": login, "senha": password};

    var response = await http.post(Uri.parse(url), body: params);

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
