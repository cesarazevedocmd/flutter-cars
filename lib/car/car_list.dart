import 'package:car_project/car/car_listview.dart';
import 'package:car_project/car/drawer_list.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
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
              Text("CLASSIC"),
              Text("SPORT"),
              Text("LUX"),
            ],
          ),
        ),
        drawer: DrawerList(),
        body: TabBarView(
          children: [
            CarListView(),
            CarListView(),
            CarListView(),
          ],
        ),
      ),
    );
  }
}
