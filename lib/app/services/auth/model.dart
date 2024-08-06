class JWTToken {
  final String? accessToken;
  final String? refreshToken;

  JWTToken({this.accessToken, this.refreshToken});

  factory JWTToken.fromJson(Map<String, dynamic> json) {
    return JWTToken(accessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }
}

class Login {
  final String name;
  final JWTToken tokens;

  Login({required this.name, required this.tokens});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(name: json['name'], tokens: JWTToken.fromJson(json['tokens']));
  }
}
