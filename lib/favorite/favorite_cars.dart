import 'package:car_project/car/widgets/cars_listview.dart';
import 'package:flutter/material.dart';

import '../car/entity/car.dart';
import 'favorite_bloc.dart';

class FavoriteCars extends StatefulWidget {
  @override
  _FavoriteCarsState createState() => _FavoriteCarsState();
}

class _FavoriteCarsState extends State<FavoriteCars> with AutomaticKeepAliveClientMixin<FavoriteCars> {
  @override
  bool get wantKeepAlive => true;

  FavoriteBloc _favoriteBloc = FavoriteBloc();

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
    _favoriteBloc.load();
  }

  StreamBuilder _body() {
    return StreamBuilder<List<Car>>(
      stream: _favoriteBloc.stream,
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
    return _favoriteBloc.load();
  }

  @override
  void dispose() {
    super.dispose();
    _favoriteBloc.dispose();
  }
}
