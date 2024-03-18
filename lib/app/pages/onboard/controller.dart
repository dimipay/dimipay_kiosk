import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class OnboardPageController extends GetxController {
  static OnboardPageController get to => Get.find<OnboardPageController>();

  final Rx<Kiosk?> kiosk = Rx(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    kiosk.value =
        await AuthService.to.repository.getHealth(AuthService.to.accessToken!);
    Get.lazyPut(() => ProductService());
    if (kDebugMode) {
      if (await ProductService.to.addProduct("1202303246757")) {
        Get.toNamed(Routes.PRODUCT);
      }
    }
  }
}
