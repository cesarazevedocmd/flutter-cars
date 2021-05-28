import 'package:car_project/car/widgets/car_form_page.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import 'entity/car.dart';

class MyPopupMenuItem {
  String value;
  Function _click;

  MyPopupMenuItem(this.value, this._click);

  performClick() => this._click();

  static List<PopupMenuItem<MyPopupMenuItem>> getPopupOptions(BuildContext context, Car car) {
    return [
      PopupMenuItem(value: MyPopupMenuItem("Edit", () => push(context, CarFormPage(car: car))), child: Text("Edit")),
      PopupMenuItem(value: MyPopupMenuItem("Delete", () => print("Delete Clicked")), child: Text("Delete")),
      PopupMenuItem(value: MyPopupMenuItem("Share", () => print("Share Clicked")), child: Text("Share"))
    ];
  }
}
