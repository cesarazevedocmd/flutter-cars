import 'package:car_project/car/manager/car_bloc.dart';
import 'package:car_project/car/entity/car_type.dart';
import 'package:car_project/car/widgets/cars_listview.dart';
import 'package:flutter/material.dart';

import '../entity/car.dart';

class CarsPageByType extends StatefulWidget {
  final CarType _type;

  CarsPageByType(this._type);

  @override
  _CarsPageByTypeState createState() => _CarsPageByTypeState();
}

class _CarsPageByTypeState extends State<CarsPageByType> with AutomaticKeepAliveClientMixin<CarsPageByType> {
  @override
  bool get wantKeepAlive => true;

  CarBloc _carBloc = CarBloc();

  CarType get carType => widget._type;

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
    _carBloc.load(carType);
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
    return _carBloc.load(carType);
  }

  @override
  void dispose() {
    super.dispose();
    _carBloc.dispose();
  }
}
