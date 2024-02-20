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

class User {
  String id;
  String name;
  String profileImage;

  User({required this.id, required this.name, required this.profileImage});
}

class UserFace {
  final String code;
  final List<User> users;

  UserFace({required this.code, required this.users});

  factory UserFace.fromJson(Map<String, dynamic> json) {
    return UserFace(
        code: json['code'],
        users: json['users']
            .map<User>((user) => User(
                id: user['id'],
                name: user['name'],
                profileImage: user['profileImage']))
            .toList());
  }
}

class ReceivedCoupon {
  final String systemId;
  final int amount;
  final String name;
  final String issuer;

  ReceivedCoupon(
      {required this.systemId,
      required this.amount,
      required this.name,
      required this.issuer});
}

class PaymentMethod {
  final String name;
  final String color;
  final String systemId;
  final String last;

  PaymentMethod(
      {required this.name,
      required this.color,
      required this.systemId,
      required this.last});
}

class UserPayment {
  String name;
  String systemId;
  String profileImage;
  List<ReceivedCoupon> receivedCoupons;
  List<PaymentMethod> paymentMethod;

  UserPayment(
      {required this.name,
      required this.systemId,
      required this.profileImage,
      required this.receivedCoupons,
      required this.paymentMethod});

  factory UserPayment.fromJson(Map<String, dynamic> json) {
    return UserPayment(
        name: json['name'],
        systemId: json['systemId'],
        profileImage: json['profileImage'],
        receivedCoupons: json['receivedCoupons'] != null
            ? json['receivedCoupons']
                .map<ReceivedCoupon>((coupon) => ReceivedCoupon(
                    systemId: coupon['systemId'],
                    amount: coupon['amount'],
                    name: coupon['name'],
                    issuer: coupon['issuer']['name']))
                .toList()
            : [],
        paymentMethod: json['paymentMethod'].map<PaymentMethod>((method) {
          return PaymentMethod(
              name: method['name'],
              color: method['color'],
              systemId: method['systemId'],
              last: method['last']);
        }).toList());
  }
}
