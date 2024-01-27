// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      systemId: json['systemId'] as String,
      name: json['name'] as String,
      sellingPrice: json['sellingPrice'] as int,
      barcode: json['barcode'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'systemId': instance.systemId,
      'name': instance.name,
      'sellingPrice': instance.sellingPrice,
      'barcode': instance.barcode,
      'id': instance.id,
    };
