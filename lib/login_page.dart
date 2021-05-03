import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

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
        _myTextFormField("Login"),
        _verticalSpace(10),
        _myTextFormField("Password", hideText: true),
        _verticalSpace(10),
        _buttonLogin()
      ],
    );
  }

  ElevatedButton _buttonLogin() {
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          "LOGIN",
          style: TextStyle(fontSize: 18),
        ),
      );
  }

  SizedBox _verticalSpace(double value) => SizedBox(height: value);

  TextFormField _myTextFormField(String label, {bool hideText = false}) {
    return TextFormField(
      style: TextStyle(color: Colors.blue, fontSize: 20),
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
