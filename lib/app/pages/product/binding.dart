import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/pages/product/controller.dart';

class ProductPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductPageController());
  }
}
