import 'package:car_project/car/cars_listview.dart';
import 'package:car_project/car/drawer_list.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carros"), centerTitle: true),
      drawer: DrawerList(),
      body: CarsListView(),
    );
  }
}
