import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/product/service.dart';

class ProductPageController extends GetxController {
  static ProductPageController get to => Get.find<ProductPageController>();

  final _pressedButton = RxString("");
  String get pressedButton => _pressedButton.value;
  set pressedButton(String value) {
    _pressedButton.value = value;
  }

  Timer? timer;

  void resetTimer() {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(minutes: 1), () {
      if (Get.currentRoute == Routes.PRODUCT) {
        ProductService.to.clearProduct();
      }
    });
  }
}
