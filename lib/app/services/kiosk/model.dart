import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Product {
  String id;
  String name;
  String? alias;
  int price;

  Product({
    required this.id,
    required this.name,
    required this.alias,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductItem {
  String id;
  String name;
  int price;
  int amount;

  ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
