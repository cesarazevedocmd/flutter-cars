import 'package:car_project/login/login_page.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("César Alves"),
                accountEmail: Text("cesarazevedocmd@gmail.com"),
                currentAccountPicture: CircleAvatar()),
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

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
