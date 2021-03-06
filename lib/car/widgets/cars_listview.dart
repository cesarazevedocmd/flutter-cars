import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../entity/car.dart';
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
          return InkWell(
            onTap: () => _onClickCar(context, car),
            onLongPress: () => _onLongClickCar(context, car),
            child: Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _carImage(car),
                    Text(car.nome, style: TextStyle(fontSize: 22)),
                    Text("Description...", style: TextStyle(fontSize: 16)),
                    _buttons(context, car),
                  ],
                ),
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
            onPressed: () => _onClickCar(context, car),
          ),
          TextButton(
            child: Text("SHARE"),
            onPressed: () => _onClickShare(car),
          ),
        ],
      ),
    );
  }

  _onClickCar(BuildContext context, Car car) {
    push(context, CarDetails(car));
  }

  _onLongClickCar(BuildContext context, Car car) {
    openModal(context, car);
  }

  void openDialog(BuildContext context, Car car) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: Text(car.nome), children: [
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text("Details"),
              onTap: () {
                pop(context);
                _onClickCar(context, car);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              onTap: () {
                pop(context);
                _onClickShare(car);
              },
            ),
          ]);
        });
  }

  void openModal(BuildContext context, Car car) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(car.nome, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text("Details"),
                onTap: () {
                  pop(context);
                  _onClickCar(context, car);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () {
                  pop(context);
                  _onClickShare(car);
                },
              ),
            ],
          );
        });
  }

  void _onClickShare(Car car) {
    Share.share("Name: ${car.nome}\nDescription: ${car.descricao}", subject: "Share Car");
  }
}
