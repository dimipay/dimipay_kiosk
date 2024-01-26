// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kiosk _$KioskFromJson(Map<String, dynamic> json) => Kiosk(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      name: json['name'] as String,
      disabled: json['disabled'] as bool,
      id: json['id'] as String,
    );

Map<String, dynamic> _$KioskToJson(Kiosk instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'disabled': instance.disabled,
      'id': instance.id,
    };
