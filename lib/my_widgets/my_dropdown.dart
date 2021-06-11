import 'package:flutter/material.dart';

abstract class MyDropDownItem {
  String text();
}

class MyDropDown<T extends MyDropDownItem> extends StatefulWidget {
  List<T> items = [];
  T initialValue;
  String hint;
  ValueChanged<T> callback;

  MyDropDown(this.items, this.initialValue, this.hint, this.callback);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState<T extends MyDropDownItem> extends State<MyDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: widget.initialValue,
      isExpanded: true,
      hint: Text(widget.hint),
      items: _getItems(),
      onChanged: (itemClicked) => widget.callback(itemClicked),
    );
  }

  List<DropdownMenuItem<T>> _getItems() {
    return widget.items
        .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item.text()),
            ))
        .toList();
  }
}
