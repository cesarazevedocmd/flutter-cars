import 'package:car_project/car/entity/car_type.dart';
import 'package:car_project/car/widgets/car_form_page.dart';
import 'package:car_project/car/widgets/cars_page_by_type.dart';
import 'package:car_project/car/widgets/drawer_list.dart';
import 'package:car_project/favorite/favorite_cars.dart';
import 'package:car_project/util/nav.dart';
import 'package:car_project/util/prefs.dart';
import 'package:flutter/material.dart';

class CarTabsView extends StatefulWidget {
  @override
  _CarTabsViewState createState() => _CarTabsViewState();
}

class _CarTabsViewState extends State<CarTabsView> with SingleTickerProviderStateMixin<CarTabsView> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);
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
      floatingActionButton: _floatinActionButton(),
    );
  }

  FloatingActionButton _floatinActionButton() {
    return FloatingActionButton(
      onPressed: () {
        push(context, CarFormPage());
      },
      child: Icon(Icons.add),
    );
  }

  TabBarView _tabBarViewOrNull() {
    return _tabController == null
        ? Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: [
              CarsPageByType(CarType.classic),
              CarsPageByType(CarType.sport),
              CarsPageByType(CarType.lux),
              FavoriteCars(),
            ],
          );
  }

  TabBar _tabBarOrNull() {
    return _tabController == null
        ? null
        : TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "CLASSIC", icon: Icon(Icons.directions_car)),
              Tab(text: "SPORT", icon: Icon(Icons.directions_car)),
              Tab(text: "LUX", icon: Icon(Icons.directions_car)),
              Tab(text: "FAVORITES", icon: Icon(Icons.favorite)),
            ],
          );
  }
}
