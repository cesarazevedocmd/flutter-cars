class User {
  String login;
  String nome;
  String email;
  String token;
  List<String> roles;

  User.fromJson(Map<String, dynamic> map) {
    login = map["login"];
    nome = map["nome"];
    email = map["email"];
    token = map["token"];
    roles = map["roles"]?.map<String>((role) => role.toString())?.toList();
  }

  @override
  String toString() {
    return "login: $login, nome: $nome, email: $email, roles: $roles, token: $token";
  }
}
