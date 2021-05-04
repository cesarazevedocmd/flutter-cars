import 'package:car_project/api/api_response.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'car_api.dart';

class CarsListView extends StatefulWidget {

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  FutureBuilder _body() {
    var future = CarApi.loadCars();

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("ERROR LOAD CARS : ${snapshot.error}");
          return Center(child: Text("Cars not loaded", style: TextStyle(color: Colors.red, fontSize: 20)));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        ApiResponse response = snapshot.data;
        return _carListWidget(response.result);
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
                  _carImage(car),
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

  Center _carImage(Car car) {
    if (car.urlFoto != null && car.urlFoto.isNotEmpty)
      return Center(child: Image.network(car.urlFoto, height: 150));
    return Center(child: Text("Photo not found"));
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
