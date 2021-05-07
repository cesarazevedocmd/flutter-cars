import 'package:car_project/api/api_response.dart';
import 'package:car_project/car/car_details_page.dart';
import 'package:car_project/car/car_type.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'car_api.dart';

class CarListView extends StatefulWidget {
  final CarType _type;

  CarListView(this._type);

  @override
  _CarListViewState createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> with AutomaticKeepAliveClientMixin<CarListView> {
  @override
  bool get wantKeepAlive => true;

  ApiResponse<List<Car>> _responseCars;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    CarApi.loadCars(widget._type).then((response) {
      setState(() {
        _responseCars = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    if (_responseCars == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (!_responseCars.success) {
      return Center(
          child: Text(
        "Cars not loaded ${_responseCars.error}",
        style: TextStyle(color: Colors.red, fontSize: 20),
      ));
    }

    return _carListWidget(_responseCars.result);
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
                  _buttons(car),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Center _carImage(Car car) {
    if (car.urlFoto != null && car.urlFoto.isNotEmpty) return Center(child: Image.network(car.urlFoto, height: 150));
    return Center(child: Text("Photo not found"));
  }

  ButtonBarTheme _buttons(Car car) {
    return ButtonBarTheme(
      data: ButtonBarTheme.of(context),
      child: ButtonBar(
        children: [
          TextButton(
            child: Text("DETAILS"),
            onPressed: () {
              push(context, CarDetailsPage(car));
            },
          ),
          TextButton(
            child: Text("SHARE"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
