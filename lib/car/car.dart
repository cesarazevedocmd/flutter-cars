import 'package:car_project/data_base/entity.dart';

class Car extends Entity{
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Car({this.id, this.nome, this.tipo, this.descricao, this.urlFoto, this.urlVideo, this.latitude, this.longitude});

  Car.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.nome = map["nome"];
    this.tipo = map["tipo"];
    this.descricao = map["descricao"];
    this.urlFoto = map["urlFoto"];
    this.urlVideo = map["urlVideo"];
    this.latitude = map["latitude"];
    this.longitude = map["longitude"];
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map["id"] = this.id;
    map["nome"] = this.nome;
    map["tipo"] = this.tipo;
    map["descricao"] = this.descricao;
    map["urlFoto"] = this.urlFoto;
    map["urlVideo"] = this.urlVideo;
    map["latitude"] = this.latitude;
    map["longitude"] = this.longitude;
    return map;
  }
}
