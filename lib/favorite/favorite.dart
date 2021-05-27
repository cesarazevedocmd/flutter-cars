import 'package:car_project/util/sql/entity.dart';

class Favorite extends Entity {
  int id;
  String nome;

  Favorite(this.id, this.nome);

  Favorite.fromMap(Map<String, dynamic> map){
    this.id = map["id"];
    this.nome = map["nome"];
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map["id"] = id;
    map["nome"] = nome;
    return map;
  }
}
