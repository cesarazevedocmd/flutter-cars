import 'package:car_project/login/widgets/login_page.dart';
import 'package:car_project/login/user.dart';
import 'package:car_project/login/user_manager.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            FutureBuilder<User>(
                future: UserManager.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) return _header(snapshot.data);

                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                }),
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

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(user.urlFoto)),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
