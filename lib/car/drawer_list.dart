import 'package:car_project/login/login_page.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  String _name = "";
  String _email = "";
  String _urlPhoto = "";
  bool _userNotLoaded = true;

  @override
  Widget build(BuildContext context) {
    _loadUser();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            _userNotLoaded ? _loader() : _header(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sign out"),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  Center _loader() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }

  UserAccountsDrawerHeader _header() {
    return UserAccountsDrawerHeader(
      accountName: Text(_name),
      accountEmail: Text(_email),
      currentAccountPicture: CircleAvatar(backgroundImage: _urlPhoto.isEmpty ? null : NetworkImage(_urlPhoto)),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }

  void _loadUser() {
    if (_userNotLoaded) {
      UserManager.getUser().then((user) {
        if (user != null) {
          setState(() {
            _name = user.nome;
            _email = user.email;
            _urlPhoto = user.urlFoto;
          });
          _userNotLoaded = false;
        }
      });
    }
  }
}
