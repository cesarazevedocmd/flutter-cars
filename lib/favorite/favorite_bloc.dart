import 'package:car_project/api/basic_bloc.dart';
import 'package:car_project/car/entity/car.dart';
import 'package:car_project/favorite/favorite_service.dart';

class FavoriteBloc extends BasicBloc<List<Car>> {
  Future<List<Car>> load() async {
    final favorites = await FavoriteService.getFavorites();
    add(favorites);
    return favorites;
  }
}
