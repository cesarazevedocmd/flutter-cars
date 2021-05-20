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

class MyPopupMenuItem {
  String value;
  Function _click;

  MyPopupMenuItem(this.value, this._click);

  performClick() => this._click.call();

  static List<PopupMenuItem<MyPopupMenuItem>> getPopupOptions() {
    return [
      PopupMenuItem(value: MyPopupMenuItem("Edit", () => print("Edit Clicked")), child: Text("Edit")),
      PopupMenuItem(value: MyPopupMenuItem("Delete", () => print("Delete Clicked")), child: Text("Delete")),
      PopupMenuItem(value: MyPopupMenuItem("Share", () => print("Share Clicked")), child: Text("Share"))
    ];
  }
}
