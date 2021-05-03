import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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

  void _onClickLogin() {
    if (!_formKey.currentState.validate()) return;
    print("Login: ${_loginEditingController.text} => Password: ${_passwordEditingController.text}");
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
