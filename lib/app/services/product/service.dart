import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/health/service.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/product/model.dart';
import 'package:dimipay_kiosk/app/services/product/repository.dart';

class ProductListItem extends Product {
  String barcode = "";
  RxInt count = 1.obs;
  ProductListItem({
    required super.id,
    required super.name,
    required super.alias,
    required super.price,
    required barcode,
  });
}

class ProductService extends GetxController {
  static ProductService get to => Get.find<ProductService>();

  final ProductRepository repository;
  ProductService({ProductRepository? repository})
      : repository = repository ?? ProductRepository();

  final Rx<Map<String, ProductListItem>> _productList = Rx({});
  final RxInt _productTotalCount = 0.obs;
  final RxInt _productTotalPrice = 0.obs;

  Map<String, ProductListItem> get productList => _productList.value;
  int get productTotalCount => _productTotalCount.value;
  int get productTotalPrice => _productTotalPrice.value;

  Future<bool> addProduct(String barcode) async {
    try {
      if (_productList.value.containsKey(barcode)) {
        _productList.value[barcode]!.count++;
      } else {
        var product = await repository.getProduct(barcode);
        _productList.value[barcode] = ProductListItem(
            id: product.id,
            name: product.name,
            alias: product.alias,
            price: product.price,
            barcode: barcode);
      }
      _productTotalCount.value++;
      _productTotalPrice.value += _productList.value[barcode]!.price;
      return true;
    } catch (_) {
      return false;
    }
  }

  void resetProduct() {
    FaceSignService.to.stop();
    Get.back();
    HealthService.to.checkHealth();
  }

  void removeProduct(String barcode) {
    _productTotalCount.value--;
    _productTotalPrice.value -= _productList.value[barcode]!.price;
    if (_productList.value[barcode]!.count > 1) {
      _productList.value[barcode]!.count--;
    } else {
      _productList.value.remove(barcode);
    }
    _productList.refresh();
    if (_productList.value.isEmpty) resetProduct();
  }

  void deleteProduct(String barcode) {
    _productTotalCount.value -= _productList.value[barcode]!.count.value;
    _productTotalPrice.value -= _productList.value[barcode]!.price *
        _productList.value[barcode]!.count.value;
    _productList.value.remove(barcode);
    _productList.refresh();
    if (_productList.value.isEmpty) resetProduct();
  }

  void clearProduct() {
    _productTotalCount.value = 0;
    _productTotalPrice.value = 0;
    _productList.value.clear();
    _productList.refresh();
    resetProduct();
  }
}
