import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class TransactionResult {
  String status;
  String message;
  int totalPrice;

  TransactionResult({
    required this.status,
    required this.message,
    required this.totalPrice,
  });

  factory TransactionResult.fromJson(Map<String, dynamic> json) =>
      _$TransactionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResultToJson(this);
}
