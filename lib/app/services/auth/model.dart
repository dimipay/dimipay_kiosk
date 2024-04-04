class JWTToken {
  final String? accessToken;
  final String? refreshToken;

  JWTToken({this.accessToken, this.refreshToken});

  factory JWTToken.fromJson(Map<String, dynamic> json) {
    return JWTToken(
        accessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }
}
