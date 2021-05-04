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
            ListTile()
          ],
        ),
      ),
    );
  }
}
