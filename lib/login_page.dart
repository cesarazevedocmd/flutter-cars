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
        TextFormField(
          style: TextStyle(color: Colors.blue, fontSize: 20),
          decoration: InputDecoration(
            labelText: "Login",
            labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          obscureText: true,
          style: TextStyle(color: Colors.blue, fontSize: 20),
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            "LOGIN",
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
