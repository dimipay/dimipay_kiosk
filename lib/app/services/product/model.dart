import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class Product {
  String systemId;
  String name;
  int sellingPrice;
  String barcode;
  String id;

  Product({
    required this.systemId,
    required this.name,
    required this.sellingPrice,
    required this.barcode,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
