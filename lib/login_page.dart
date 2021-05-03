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
        Text("Login"),
        TextFormField(),
        SizedBox(height: 10),
        Text("Password"),
        TextFormField(obscureText: true),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {},
            child: Text(
              "LOGIN",
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
