import 'dart:convert';

import 'package:car_project/model/user.dart';
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
    if (userJson.isNotEmpty) return User.fromMap(json.decode(userJson));
    return null;
  }

  static void clearUser() {
    Prefs.setString("user.prefs", "");
  }
}
