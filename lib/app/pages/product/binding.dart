import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';

class ProductPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductPageController());
    Get.lazyPut(() => TransactionService());
    Get.lazyPut(() => AlertModal());
  }
}
