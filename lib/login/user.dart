class User {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  User.fromMap(Map<String, dynamic> map) {
    login = map["login"];
    nome = map["nome"];
    email = map["email"];
    urlFoto = map["urlFoto"];
    token = map["token"];
    roles = map["roles"] == null ? null : map["roles"].cast<String>(); //map["roles"]?.map<String>((role) => role.toString())?.toList();
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map["login"] = login;
    map["nome"] = nome;
    map["email"] = email;
    map["urlFoto"] = urlFoto;
    map["token"] = token;
    map["roles"] = roles;
    return map;
  }

  @override
  String toString() {
    return "login: $login, nome: $nome, email: $email, roles: $roles";
  }
}
