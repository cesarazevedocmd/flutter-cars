import 'dart:async';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/api/basic_stream.dart';
import 'package:car_project/login/login_api.dart';
import 'package:car_project/login/user.dart';

class LoginBloc extends BasicStream<bool> {
  Future<ApiResponse<User>> doLogin(String login, String password) async {
    try {
      add(true);
      ApiResponse<User> apiResponse = await LoginApi.login(login, password);
      add(false);

      return apiResponse;
    } catch (error) {
      addError(error);
      return ApiResponse.error(error);
    }
  }
}
