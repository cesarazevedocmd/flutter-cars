import 'package:flutter/material.dart';

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
