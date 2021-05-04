import 'package:car_project/car/car_listview.dart';
import 'package:car_project/car/car_type.dart';
import 'package:car_project/car/drawer_list.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> with SingleTickerProviderStateMixin<CarList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "CLASSIC"),
              Tab(text: "SPORT"),
              Tab(text: "LUX"),
            ],
          ),
        ),
        drawer: DrawerList(),
        body: TabBarView(
          children: [
            CarListView(CarType.classic),
            CarListView(CarType.sport),
            CarListView(CarType.lux),
          ],
        ),
      ),
    );
  }
}
