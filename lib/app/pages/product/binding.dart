import 'package:dimipay_pos_flutter/app/pages/product/controller.dart';
import 'package:get/get.dart';

class ProductPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductPageController());
  }
}
