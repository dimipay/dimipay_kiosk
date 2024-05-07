class PaymentMethod {
  String id;
  String name;
  String code;
  String preview;

  PaymentMethod(
      {required this.id,
      required this.name,
      required this.code,
      required this.preview});
}

class PaymentMethods {
  String? mainPaymentMethodId;
  String? paymentPinAuthURL;
  List<PaymentMethod> methods;

  PaymentMethods(
      {required this.mainPaymentMethodId,
      required this.paymentPinAuthURL,
      required this.methods});
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
        profileImage:
            json["profileImage"] ?? "https://via.placeholder.com/36x36",
        paymentMethods: PaymentMethods(
            mainPaymentMethodId: json['paymentMethods']['mainPaymentMethodId'],
            paymentPinAuthURL: json['paymentMethods']['paymentPinAuthURL'],
            methods: json['paymentMethods']['methods']
                .map<PaymentMethod>((method) => PaymentMethod(
                    id: method['id'],
                    name: method['name'],
                    code: method['code'],
                    preview: method['preview']))
                .toList()));
  }
}

class AltUser {
  String id;
  String name;
  String profileImage;
  String paymentMethods;

  AltUser(
      {required this.id,
      required this.name,
      required this.profileImage,
      required this.paymentMethods});

  factory AltUser.fromJson(Map<String, dynamic> json) {
    return AltUser(
        id: json["id"],
        name: json["name"],
        profileImage: json["profileImage"],
        paymentMethods: json["paymentMethods"]);
  }
}
