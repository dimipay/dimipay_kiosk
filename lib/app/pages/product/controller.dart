import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';

class Product {
  final String name;
  final int price;
  RxInt count = 1.obs;

  Product({required this.name, required this.price});
}

class ProductPageController extends GetxController {
  static ProductPageController get to => Get.find<ProductPageController>();

  final _faceRecognitionLoading = true.obs;
  final _faceRecognitionSuccessed = false.obs;
  final _pressedButton = "".obs;
  final _productTotalCount = 0.obs;
  final _productTotalPrice = 0.obs;
  final _productList = <String, Product>{}.obs;

  bool get faceRecognitionLoading => _faceRecognitionLoading.value;
  bool get faceRecognitionSuccessed => _faceRecognitionSuccessed.value;
  String get pressedButton => _pressedButton.value;
  int get productTotalCount => _productTotalCount.value;
  int get productTotalPrice => _productTotalPrice.value;
  Map<String, Product> get productList => _productList;
  // productList = {
  //  "id" : {
  //    "name" : "콜라",
  //    "price" : "1000",
  //    "count" : "1"
  //  }
  // }

  set faceRecognitionLoading(bool value) =>
      _faceRecognitionLoading.value = value;
  set faceRecognitionSuccessed(bool value) =>
      _faceRecognitionSuccessed.value = value;
  set pressedButton(String value) => _pressedButton.value = value;
  set productTotalCount(int value) => _productTotalCount.value = value;
  set productTotalPrice(int value) => _productTotalPrice.value = value;

  @override
  void onInit() {
    super.onInit();
    addProduct("0001");
    addProduct("0001");
    addProduct("0002");
    addProduct("0002");
    addProduct("0002");
    addProduct("0002");
  }

  void addProduct(String id) {
    if (productList.containsKey(id)) {
      productList[id]!.count++;
    } else {
      productList[id] = Product(name: "콜라", price: 1000);
    }
    productTotalCount++;
    productTotalPrice += productList[id]!.price;
  }

  void removeProduct(String id) {
    productTotalCount--;
    productTotalPrice -= productList[id]!.price;

    if (productList[id]!.count > 1) {
      productList[id]!.count--;
    } else {
      productList.remove(id);
    }
  }

  void deleteProduct(String id) {
    productTotalCount -= productList[id]!.count.value;
    productTotalPrice -= productList[id]!.price * productList[id]!.count.value;
    productList.remove(id);
  }

  void cleanProduct() {
    productTotalCount = 0;
    productTotalPrice = 0;
    productList.clear();
  }
}
