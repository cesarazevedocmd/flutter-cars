import 'package:car_project/api/api_response.dart';
import 'package:car_project/login/login_api.dart';
import 'package:car_project/util/alert.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import '../car/car_list.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _loginEditingController = TextEditingController(text: "admin");

  final _passwordEditingController = TextEditingController(text: "123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cars"), centerTitle: true),
      body: Padding(padding: EdgeInsets.all(16), child: _body()),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _myTextFormField("Login", _loginEditingController,
              validator: _validateLogin, keyboardType: TextInputType.emailAddress, inputAction: TextInputAction.next),
          _verticalSpace(10),
          _myTextFormField("Password", _passwordEditingController,
              validator: _validatePassword,
              keyboardType: TextInputType.number,
              inputAction: TextInputAction.done,
              hideText: true),
          _verticalSpace(10),
          _buttonLogin(showLoading: _showLoading)
        ],
      ),
    );
  }

  _buttonLogin({bool showLoading = false}) {
    return Container(
      height: 46,
      child: ElevatedButton(
        onPressed: _onClickLogin,
        child: showLoading
            ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black)))
            : Text("LOGIN", style: TextStyle(fontSize: 22, color: Colors.black)),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) return;

    var login = _loginEditingController.text;
    var password = _passwordEditingController.text;

    setState(() {
      _showLoading = true;
    });

    ApiResponse apiResponse = await LoginApi.login(login, password);

    if (apiResponse.success) {
      push(context, CarList(), replace: true);
    } else {
      alert(context, apiResponse.error);
    }

    setState(() {
      _showLoading = false;
    });
  }

  SizedBox _verticalSpace(double value) => SizedBox(height: value);

  TextFormField _myTextFormField(String label, TextEditingController controller,
      {bool hideText = false,
      FormFieldValidator<String> validator,
      TextInputType keyboardType,
      TextInputAction inputAction}) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: inputAction,
      validator: validator,
      controller: controller,
      style: TextStyle(color: Colors.blue, fontSize: 20),
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  String _validateLogin(String text) {
    return text.isEmpty ? "Fill up login" : null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) return "Fill up password";

    if (text.length < 3) return "Password must be at least 3 digits";

    return null;
  }
}
