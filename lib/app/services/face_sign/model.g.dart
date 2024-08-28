// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String,
      paymentMethods: PaymentMethods.fromJson(
          json['paymentMethods'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'paymentMethods': instance.paymentMethods,
    };

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      mainPaymentMethodId: json['mainPaymentMethodId'] as String,
      paymentPinAuthURL: json['paymentPinAuthURL'] as String,
      methods: (json['methods'] as List<dynamic>)
          .map((e) => Method.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'mainPaymentMethodId': instance.mainPaymentMethodId,
      'paymentPinAuthURL': instance.paymentPinAuthURL,
      'methods': instance.methods,
    };

Method _$MethodFromJson(Map<String, dynamic> json) => Method(
      id: json['id'] as String,
      name: json['name'] as String,
      sequence: (json['sequence'] as num).toInt(),
      type: json['type'] as String,
      preview: json['preview'] as String,
      cardCode: json['cardCode'] as String,
    );

Map<String, dynamic> _$MethodToJson(Method instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sequence': instance.sequence,
      'type': instance.type,
      'preview': instance.preview,
      'cardCode': instance.cardCode,
    };
