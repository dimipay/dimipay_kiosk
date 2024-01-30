import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/product/model.dart';
import 'package:dimipay_kiosk/app/services/product/repository.dart';

class ProductListItem extends Product {
  RxInt count = 1.obs;
  ProductListItem(
      {required super.systemId,
      required super.name,
      required super.sellingPrice,
      required super.barcode});
}

class ProductService extends GetxController {
  static ProductService get to => Get.find<ProductService>();

  final ProductRepository repository;
  ProductService({ProductRepository? repository})
      : repository = repository ?? ProductRepository();

  final Rx<Map<String, ProductListItem>> _productList = Rx({});
  // productList = {
  //  "barcoce": Product(),
  // }
  final RxInt _productTotalCount = 0.obs;
  final RxInt _productTotalPrice = 0.obs;

  Map<String, ProductListItem> get productList => _productList.value;
  int get productTotalCount => _productTotalCount.value;
  int get productTotalPrice => _productTotalPrice.value;

  Future<bool> addProduct(String barcode) async {
    // delete on production
    // final samepleProduct = Product(
    //     barcode: "8806718073624",
    //     name: "코카콜라",
    //     sellingPrice: 1500,
    //     systemId: "1");

    // _productList.value["8806718073624"] = ProductListItem(
    //     systemId: samepleProduct.systemId,
    //     name: samepleProduct.name,
    //     sellingPrice: samepleProduct.sellingPrice,
    //     barcode: samepleProduct.barcode);

    try {
      if (_productList.value.containsKey(barcode)) {
        _productList.value[barcode]!.count++;
      } else {
        var product = await repository.getProductByBarcode(
            barcode, AuthService.to.accessToken!);

        _productList.value[barcode] = ProductListItem(
            systemId: product.systemId,
            name: product.name,
            sellingPrice: product.sellingPrice,
            barcode: product.barcode);
      }
      _productTotalCount.value++;
      _productTotalPrice.value += _productList.value[barcode]!.sellingPrice;
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isProductListEmpty() {
    if (_productList.value.isEmpty) {
      Get.back();
      return true;
    } else {
      return false;
    }
  }

  void removeProduct(String barcode) {
    _productTotalCount.value--;
    _productTotalPrice.value -= _productList.value[barcode]!.sellingPrice;
    if (_productList.value[barcode]!.count > 1) {
      _productList.value[barcode]!.count--;
    } else {
      _productList.value.remove(barcode);
    }
    _productList.refresh();
    isProductListEmpty();
  }

  void deleteProduct(String barcode) {
    _productTotalCount.value -= _productList.value[barcode]!.count.value;
    _productTotalPrice.value -= _productList.value[barcode]!.sellingPrice *
        _productList.value[barcode]!.count.value;
    _productList.value.remove(barcode);
    _productList.refresh();
    isProductListEmpty();
  }

  void cleanProduct() {
    _productTotalCount.value = 0;
    _productTotalPrice.value = 0;
    _productList.value.clear();
    _productList.refresh();
    Get.back();
  }
}
