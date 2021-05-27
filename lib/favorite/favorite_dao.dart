import 'package:car_project/util/sql/basic_dao.dart';
import 'package:car_project/favorite/favorite.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDAO extends BasicDAO<Favorite> {
  @override
  Favorite fromMap(Map<String, dynamic> map) {
    return Favorite.fromMap(map);
  }

  @override
  String get table => "favorite";

  Future<bool> isFavorite(int favoriteId) async {
    final dbClient = await db;

    final result = await dbClient.rawQuery("SELECT count(*) FROM $table WHERE id = ?", [favoriteId]);

    final quantity = Sqflite.firstIntValue(result);

    return quantity != 0;
  }

  Future<bool> isFavoriteV2(Favorite favorite) async {
    return (await super.findById(favorite.id)) != null;
  }
}
