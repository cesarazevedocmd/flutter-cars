import 'package:car_project/car/car.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  Car _car;

  CarDetailsPage(this._car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_car.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Image.network(_car.urlFoto);
  }
}
