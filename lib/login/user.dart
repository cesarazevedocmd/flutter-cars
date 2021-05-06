class User {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  User.fromJson(Map<String, dynamic> map) {
    login = map["login"];
    nome = map["nome"];
    email = map["email"];
    urlFoto = map["urlFoto"];
    token = map["token"];
    roles = map["roles"]?.map<String>((role) => role.toString())?.toList();
  }

  @override
  String toString() {
    return "login: $login, nome: $nome, email: $email, roles: $roles";
  }
}
