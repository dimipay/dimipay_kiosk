import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;
  String profileImage;
  PaymentMethods paymentMethods;

  User({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.paymentMethods,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class PaymentMethods {
  String mainPaymentMethodId;
  String paymentPinAuthURL;
  List<Method> methods;

  PaymentMethods({
    required this.mainPaymentMethodId,
    required this.paymentPinAuthURL,
    required this.methods,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}

@JsonSerializable()
class Method {
  String id;
  String name;
  int sequence;
  String type;
  String preview;
  String cardCode;

  Method({
    required this.id,
    required this.name,
    required this.sequence,
    required this.type,
    required this.preview,
    required this.cardCode,
  });

  factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);

  Map<String, dynamic> toJson() => _$MethodToJson(this);
}
