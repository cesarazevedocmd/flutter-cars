import 'package:car_project/model/car_type.dart';
import 'package:car_project/car/widgets/cars_page.dart';
import 'package:car_project/car/widgets/drawer_list.dart';
import 'package:car_project/util/prefs.dart';
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

    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      Prefs.setInt("tabIndex", _tabController.index);
    });
    Prefs.getInt("tabIndex").then((value) {
      _tabController.index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
        bottom: _tabBarOrNull(),
      ),
      drawer: DrawerList(),
      body: _tabBarViewOrNull(),
    );
  }

  TabBarView _tabBarViewOrNull() {
    return _tabController == null
        ? Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: [
              CarsPage(CarType.classic),
              CarsPage(CarType.sport),
              CarsPage(CarType.lux),
            ],
          );
  }

  TabBar _tabBarOrNull() {
    return _tabController == null
        ? null
        : TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "CLASSIC"),
              Tab(text: "SPORT"),
              Tab(text: "LUX"),
            ],
          );
  }
}
