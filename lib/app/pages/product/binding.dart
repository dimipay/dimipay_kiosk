import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:get/get.dart';

class ProductPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductPageController());
  }
}
