import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  var _loginEditinContoller = TextEditingController();
  var _passwordEditinContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cars"), centerTitle: true),
      body: Padding(padding: EdgeInsets.all(16), child: _body()),
    );
  }

  _body() {
    return ListView(
      children: [
        _myTextFormField("Login", _loginEditinContoller),
        _verticalSpace(10),
        _myTextFormField("Password", _passwordEditinContoller, hideText: true),
        _verticalSpace(10),
        _buttonLogin()
      ],
    );
  }

  ElevatedButton _buttonLogin() {
    return ElevatedButton(
      onPressed: () {
        print(
            "Login: ${_loginEditinContoller.text} => Password: ${_passwordEditinContoller.text}");
      },
      child: Text(
        "LOGIN",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  SizedBox _verticalSpace(double value) => SizedBox(height: value);

  TextFormField _myTextFormField(String label, TextEditingController controller,
      {bool hideText = false}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.blue, fontSize: 20),
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
