import 'package:car_project/car/car_type.dart';
import 'package:car_project/car/cars_listview.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'car_bloc.dart';

class CarsPage extends StatefulWidget {
  final CarType _type;

  CarsPage(this._type);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> with AutomaticKeepAliveClientMixin<CarsPage> {
  @override
  bool get wantKeepAlive => true;

  CarBloc _carBloc = CarBloc();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  void _loadData() async {
    _carBloc.load(widget._type);
  }

  StreamBuilder _body() {
    return StreamBuilder<List<Car>>(
      stream: _carBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("ERROR LOAD CARS : ${snapshot.error}");
          return Center(child: Text("Cars not loaded", style: TextStyle(color: Colors.red, fontSize: 20)));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: _requestCars,
          child: CarsListView(snapshot.data),
        );
      },
    );
  }

  Future _requestCars() {
    return _carBloc.load(widget._type);
  }

  @override
  void dispose() {
    super.dispose();
    _carBloc.dispose();
  }
}
