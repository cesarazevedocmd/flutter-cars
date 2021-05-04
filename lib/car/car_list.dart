import 'package:car_project/api/api_response.dart';
import 'package:car_project/car/car_api.dart';
import 'package:car_project/car/drawer_list.dart';
import 'package:flutter/material.dart';

import 'car.dart';

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
      body: _body(),
    );
  }

  _body() {
    var future = CarApi.loadCars();

    FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ApiResponse response = snapshot.data;
          return _carListWidget(response.result);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Container _carListWidget(List<Car> cars) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: cars != null ? cars.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Car car = cars[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(car.urlFoto, height: 150, fit: BoxFit.cover)),
                  Text(car.nome, style: TextStyle(fontSize: 22)),
                  Text("Descrição...", style: TextStyle(fontSize: 16)),
                  _buttons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ButtonBarTheme _buttons() {
    return ButtonBarTheme(
      data: ButtonBarTheme.of(context),
      child: ButtonBar(
        children: [
          TextButton(onPressed: () {}, child: Text("DETAILS")),
          TextButton(onPressed: () {}, child: Text("SHARE")),
        ],
      ),
    );
  }
}
