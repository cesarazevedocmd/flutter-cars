import 'package:car_project/car/car_type.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'car_bloc.dart';
import 'car_details_page.dart';

class CarListView extends StatefulWidget {
  final CarType _type;

  CarListView(this._type);

  @override
  _CarListViewState createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> with AutomaticKeepAliveClientMixin<CarListView> {
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

        return _carListWidget(snapshot.data);
      },
    );
  }

  Container _carListWidget(List<Car> cars) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: cars != null ? cars.length : 0,
        itemBuilder: (BuildContext context, int index) {
          Car car = cars[index];
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
                  _buttons(car),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Center _carImage(Car car) {
    if (car.urlFoto != null && car.urlFoto.isNotEmpty) return Center(child: Image.network(car.urlFoto, height: 150));
    return Center(child: Text("Photo not found"));
  }

  ButtonBarTheme _buttons(Car car) {
    return ButtonBarTheme(
      data: ButtonBarTheme.of(context),
      child: ButtonBar(
        children: [
          TextButton(
            child: Text("DETAILS"),
            onPressed: () {
              push(context, CarDetailsPage(car));
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

  @override
  void dispose() {
    super.dispose();
    _carBloc.dispose();
  }
}
