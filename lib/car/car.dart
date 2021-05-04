class Car {
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Car({this.id, this.nome, this.tipo, this.descricao, this.urlFoto, this.urlVideo, this.latitude, this.longitude});

  Car.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.nome = map["nome"];
    this.tipo = map["tipo"];
    this.descricao = map["descricao"];
    this.urlFoto = map["urlFoto"];
    this.urlVideo = map["urlVideo"];
    this.latitude = map["latitude"];
    this.longitude = map["longitude"];
  }
}
