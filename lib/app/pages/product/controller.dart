import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/auth/service.dart';

class ProductPageController extends GetxController {
  static ProductPageController get to => Get.find<ProductPageController>();

  @override
  void onInit() {
    super.onInit();
    resetTimer();
    // AuthService.to.findUser();
  }

  var timer = Timer(const Duration(minutes: 1), () {
    ProductService.to.clearProduct();
    Get.back();
  });

  void resetTimer() {
    timer.cancel();
    // timer = Timer(const Duration(minutes: 1), () {
    //   ProductService.to.clearProduct();
    //   Get.back();
    // });
  }

  final _pressedButton = RxString("");
  String get pressedButton => _pressedButton.value;
  set pressedButton(String value) {
    _pressedButton.value = value;
    resetTimer();
  }
}
