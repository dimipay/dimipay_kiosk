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
  String? paymentPinAuthUrl;
  List<PaymentMethod> methods;

  PaymentMethods(
      {required this.mainPaymentMethodId,
      required this.paymentPinAuthUrl,
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
        profileImage: json["profileImage"],
        paymentMethods: PaymentMethods(
            mainPaymentMethodId: json['paymentMethods']['mainPaymentMethodId'],
            paymentPinAuthUrl: json['paymentMethods']['paymentPinAuthUrl'],
            methods: json['paymentMethods']['methods']
                .map<PaymentMethod>((method) => PaymentMethod(
                    id: method['id'],
                    name: method['name'],
                    code: method['code'],
                    preview: method['preview']))
                .toList()));
  }
}
