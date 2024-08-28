// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResult _$TransactionResultFromJson(Map<String, dynamic> json) =>
    TransactionResult(
      status: json['status'] as String,
      message: json['message'] as String,
      totalPrice: (json['totalPrice'] as num).toInt(),
    );

Map<String, dynamic> _$TransactionResultToJson(TransactionResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'totalPrice': instance.totalPrice,
    };
