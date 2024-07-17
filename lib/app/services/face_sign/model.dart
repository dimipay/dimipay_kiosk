import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethod {
  String id;
  String name;
  String type;
  String preview;
  Widget image;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    required this.preview,
    required this.image,
  });
}

class PaymentMethods {
  String? mainPaymentMethodId;
  String? paymentPinAuthURL;
  List<PaymentMethod> methods;

  PaymentMethods({
    required this.mainPaymentMethodId,
    required this.paymentPinAuthURL,
    required this.methods,
  });
}

class PaymentApprove {
  String status;
  String message;
  int totalPrice;

  PaymentApprove({
    required this.status,
    required this.message,
    required this.totalPrice,
  });

  factory PaymentApprove.fromJson(Map<String, dynamic> json) {
    return PaymentApprove(
      status: json["status"],
      message: json["message"],
      totalPrice: json["totalPrice"],
    );
  }
}

class User {
  String id;
  String name;
  String profileImage;
  PaymentMethods paymentMethods;

  User(
      {required this.id,
      required this.name,
      required this.profileImage,
      required this.paymentMethods});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      profileImage: json["profileImage"] ?? "https://via.placeholder.com/36x36",
      paymentMethods: PaymentMethods(
        mainPaymentMethodId: json['paymentMethods']['mainPaymentMethodId'],
        paymentPinAuthURL: json['paymentMethods']['paymentPinAuthURL'],
        methods: json['paymentMethods']['methods']
            .map<PaymentMethod>(
              (method) => PaymentMethod(
                  id: method['id'],
                  name: method['name'],
                  type: method['type'],
                  preview: method['preview'],
                  image: SvgPicture.asset(
                      "assets/images/cards/${method['cardCode']}.svg")),
            )
            .toList(),
      ),
    );
  }
}

class AltUser {
  String id;
  String name;
  String profileImage;
  String paymentMethods;

  AltUser({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.paymentMethods,
  });

  factory AltUser.fromJson(Map<String, dynamic> json) {
    return AltUser(
      id: json["id"],
      name: json["name"],
      profileImage: json["profileImage"],
      paymentMethods: json["paymentMethods"],
    );
  }
}
