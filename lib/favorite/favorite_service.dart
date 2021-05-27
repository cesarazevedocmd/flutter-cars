import 'package:car_project/car/entity/car.dart';
import 'package:car_project/favorite/favorite.dart';
import 'package:car_project/favorite/favorite_dao.dart';

class FavoriteService {
  static FavoriteDAO _favoriteDAO = FavoriteDAO();

  static setFavorite(Car car) {
    Favorite favorite = Favorite(car.id, car.nome);
    _favoriteDAO.save(favorite);
  }

  static Future<bool> isFavorite(Car car) async {
    return _favoriteDAO.isFavorite(car.id);
  }

  static void removeFavorite(Car car) {
    _favoriteDAO.delete(car.id);
  }
}
