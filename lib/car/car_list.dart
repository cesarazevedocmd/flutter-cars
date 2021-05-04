import 'package:car_project/car/drawer_list.dart';
import 'package:flutter/material.dart';

class CarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carros"), centerTitle: true),
      drawer: DrawerList(),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text(
        "César Alves",
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
