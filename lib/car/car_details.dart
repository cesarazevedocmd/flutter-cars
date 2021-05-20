import 'package:car_project/car/car.dart';
import 'package:flutter/material.dart';

import 'car_details_options_menu.dart';

class CarDetailsPage extends StatelessWidget {
  Car _car;

  CarDetailsPage(this._car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_car.nome),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.place),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam),
          ),
          PopupMenuButton<MyPopupMenuItem>(
            onSelected: (item) => item.performClick(),
            itemBuilder: (context) => MyPopupMenuItem.getPopupOptions(),
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Image.network(_car.urlFoto);
  }
}
