import 'package:car_project/pages/login_api.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _loginEditingController = TextEditingController();

  final _passwordEditingController = TextEditingController();

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
          _buttonLogin()
        ],
      ),
    );
  }

  ElevatedButton _buttonLogin() {
    return ElevatedButton(
      onPressed: _onClickLogin,
      child: Text(
        "LOGIN",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) return;

    var login = _loginEditingController.text;
    var password = _passwordEditingController.text;

    print("Login: $login => Password: $password");

    var result = await LoginApi.login(login, password);

    if (result) {
      push(context, HomePage());
    } else {
      print("LOGIN FAIL");
    }
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
