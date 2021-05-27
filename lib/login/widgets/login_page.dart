import 'package:car_project/api/api_response.dart';
import 'package:car_project/login/manager/login_bloc.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:car_project/util/alert.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import '../../car/widgets/car_list.dart';
import '../user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _loginEditingController = TextEditingController();

  final _passwordEditingController = TextEditingController();

  final LoginBloc _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    UserManager.getUser().then((user) {
      if (user != null) {
        setState(() {
          _loginEditingController.text = user.nome;
        });
      }
    });
  }

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
          StreamBuilder<bool>(
            initialData: false,
            stream: _loginBloc.stream,
            builder: (context, snapshot) {
              return _buttonLogin(showLoading: snapshot.data);
            },
          ),
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
            ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)))
            : Text("LOGIN", style: TextStyle(fontSize: 22, color: Colors.white)),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) return;

    var login = _loginEditingController.text;
    var password = _passwordEditingController.text;

    final apiResponse = await _loginBloc.doLogin(login, password);

    validateResult(apiResponse);
  }

  void validateResult(ApiResponse<User> apiResponse) {
    if (apiResponse.success) {
      push(context, CarList(), replace: true);
    } else {
      alert(context, apiResponse.error);
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

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }
}
