import 'package:car_project/car/entity/car.dart';
import 'package:car_project/car/manager/car_dao.dart';
import 'package:car_project/favorite/favorite.dart';
import 'package:car_project/favorite/favorite_dao.dart';

class FavoriteService {
  static FavoriteDAO _favoriteDAO = FavoriteDAO();

  static setFavorite(Car car) async {
    final isFavorite = await _favoriteDAO.isFavorite(car.id);

    if (isFavorite) {
      _favoriteDAO.delete(car.id);
    } else {
      Favorite favorite = Favorite(car.id, car.nome);
      _favoriteDAO.save(favorite);
    }
  }

  static Future<bool> isFavorite(Car car) async {
    return _favoriteDAO.isFavorite(car.id);
  }

  static Future<List<Car>> getFavorites() async {
    return await CarDAO().findFavorites();
  }
}
