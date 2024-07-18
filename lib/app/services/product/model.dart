class Product {
  String id;
  String name;
  String? alias;
  int price;

  Product({
    required this.id,
    required this.name,
    this.alias,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      alias: json["alias"],
      price: json["price"],
    );
  }
}
