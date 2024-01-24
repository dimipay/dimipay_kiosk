import 'package:dimipay_pos_flutter/app/routes/routes.dart';
import 'package:get/get.dart';

class Product {
  final String product;
  final String productID;
  final double price;
  int count;

  Product(
      {required this.product,
      required this.productID,
      required this.price,
      required this.count});
}

class ProductPageController extends GetxController {
  static ProductPageController get to => Get.find<ProductPageController>();

  final _faceRecognitionLoading = true.obs;
  final _faceRecognitionSuccessed = false.obs;

  final _productCount = 0.obs;
  final _productList = <Product>[].obs;

  bool get faceRecognitionLoading => _faceRecognitionLoading.value;
  bool get faceRecognitionSuccessed => _faceRecognitionSuccessed.value;

  int get productCount => _productCount.value;
  List<Product> get productList => _productList.value;

  set faceRecognitionLoading(bool value) =>
      _faceRecognitionLoading.value = value;
  set faceRecognitionSuccessed(bool value) =>
      _faceRecognitionSuccessed.value = value;
  set productCount(int value) => _productCount.value = value;

  void addProduct(Product product) {
    if (productList.contains(product)) {
      productList[productList.indexOf(product)].count++;
    } else {
      productList.add(product);
    }
  }

  void removeProduct(Product product) {
    if (productList.contains(product)) {
      if (productList[productList.indexOf(product)].count > 1) {
        productList[productList.indexOf(product)].count--;
      } else {
        productList.remove(product);
      }
    }
  }
}
