import 'package:car_project/car/car_listview.dart';
import 'package:car_project/car/car_type.dart';
import 'package:car_project/car/drawer_list.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> with SingleTickerProviderStateMixin<CarList> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 1);
    _tabController.addListener(() {
      print("INDEX SELECTED: ${_tabController.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "CLASSIC"),
            Tab(text: "SPORT"),
            Tab(text: "LUX"),
          ],
        ),
      ),
      drawer: DrawerList(),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarListView(CarType.classic),
          CarListView(CarType.sport),
          CarListView(CarType.lux),
        ],
      ),
    );
  }
}
