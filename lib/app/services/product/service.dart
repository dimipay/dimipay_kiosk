import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/product/model.dart';
import 'package:dimipay_kiosk/app/services/product/repository.dart';

class ProductService extends GetxController {
  static ProductService get to => Get.find<ProductService>();

  final ProductRepository repository;
  ProductService({ProductRepository? repository})
      : repository = repository ?? ProductRepository();

  Rx<List<Product>> productList = Rx([]);

  Future<void> addProduct(String barcode) async {
    productList.value.add(await repository.getProductByBarcode(
        barcode, AuthService.to.accessToken!));
    print(productList.value.length);
  }
}
