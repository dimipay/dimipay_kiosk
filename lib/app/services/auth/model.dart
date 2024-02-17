import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

class JWTToken {
  final String? accessToken;
  final String? refreshToken;

  JWTToken({this.accessToken, this.refreshToken});
}

@JsonSerializable()
class Kiosk {
  String createdAt;
  String updatedAt;
  String name;
  bool disabled;
  String id;

  Kiosk(
      {required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.disabled,
      required this.id});
  factory Kiosk.fromJson(Map<String, dynamic> json) => _$KioskFromJson(json);
}

@JsonSerializable()
class User {
  String id;
  String name;
  String profileImage;

  User({required this.id, required this.name, required this.profileImage});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
