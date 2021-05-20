import 'package:car_project/car/car.dart';
import 'package:flutter/material.dart';

import 'car_details_options_menu.dart';

class CarDetails extends StatelessWidget {
  Car _car;

  CarDetails(this._car);

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
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Image.network(_car.urlFoto),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _car.nome,
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _car.tipo,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red, size: 40),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.blueGrey, size: 40),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
