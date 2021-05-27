import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import '../../model/car.dart';
import 'car_details.dart';

class CarsListView extends StatelessWidget {
  List<Car> _cars;

  CarsListView(this._cars);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: _cars != null ? _cars.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Car car = _cars[index];
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
                  _buttons(context, car),
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
      return Center(
        child: CachedNetworkImage(
          imageUrl: car.urlFoto,
          height: 150,
        ),
      );
    return Center(child: Text("Photo not found"));
  }

  ButtonBarTheme _buttons(BuildContext context, Car car) {
    return ButtonBarTheme(
      data: ButtonBarTheme.of(context),
      child: ButtonBar(
        children: [
          TextButton(
            child: Text("DETAILS"),
            onPressed: () {
              push(context, CarDetails(car));
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
