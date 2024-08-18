import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/widgets/press.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class ProductPageController extends GetxController with Press {
  static ProductPageController get to => Get.find<ProductPageController>();

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    resetTimer();
  }

  @override
  void onClose() {
    super.onClose();
    cancelTimer();
  }

  void resetTimer() {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(minutes: 1), () {
      if (Get.currentRoute == Routes.PRODUCT) {
        ProductService.to.clearProduct();
      }
    });
  }

  void cancelTimer() {
    if (timer != null) timer!.cancel();
  }
}
