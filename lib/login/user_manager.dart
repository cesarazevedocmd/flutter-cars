import 'dart:convert';

import 'package:car_project/login/user.dart';
import 'package:car_project/util/prefs.dart';

class UserManager {
  static void saveUser(User user) {
    if (user != null) {
      var userJson = json.encode(user.toMap());
      Prefs.setString("user.prefs", userJson);
    }
  }

  static Future<User> getUser() async {
    String userJson = await Prefs.getString("user.prefs");
    if (userJson.isNotEmpty) return User.fromJson(json.decode(userJson));
    return null;
  }
}
