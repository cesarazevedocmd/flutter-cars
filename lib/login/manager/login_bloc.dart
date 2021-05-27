import 'dart:async';

import 'package:car_project/api/api_response.dart';
import 'package:car_project/api/basic_bloc.dart';
import 'package:car_project/login/user.dart';

import 'login_api.dart';

class LoginBloc extends BasicBloc<bool> {
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
