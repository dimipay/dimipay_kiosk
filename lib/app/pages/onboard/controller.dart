import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class OnboardPageController extends GetxController {
  static OnboardPageController get to => Get.find<OnboardPageController>();

  RxBool isHealthy = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    Get.lazyPut(() => ProductService());

    isHealthy.value = true;
    if (kDebugMode) {
      if (await ProductService.to.addProduct("1202303246757")) {
        Get.toNamed(Routes.PRODUCT);
      }
    }
  }
}
