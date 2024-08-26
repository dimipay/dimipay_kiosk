import 'package:dimipay_kiosk/app/pages/payment/paymeent_pending/controller.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

import 'package:dimipay_kiosk/app/routes/routes.dart';

class PaymentPageController extends GetxController {
  final progress = 1.0.obs;
  final remainingTime = 30.obs;
  late Timer progressTimer;
  late Timer secondTimer;

  final transactionId = RxString('');
  final productItems = RxList<ProductItem>([]);
  final dpToken = RxString('');

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      transactionId.value = args['transactionId'] ?? '';
      productItems.value = args['productItems'];
    }
    startTimers();
  }

  void payQR({required String dpToken}) {
    Get.offNamed(Routes.PAYMENT_PENDING, arguments: {
      'type': PaymentType.qr,
      'transactionId': transactionId,
      'productItems': productItems,
      'dpToken': dpToken,
    });
  }

  void setDPToken({required String barcode}) {
    dpToken.value = barcode;
    payQR(dpToken: dpToken.value);
  }

  void startTimers() {
    progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progress.value > 0) {
        progress.value = max(0, progress.value - 1 / 300);
      } else {
        timer.cancel();
        Get.back();
      }
    });

    secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        progressTimer.cancel();
        Get.back();
      }
    });
  }

  @override
  void onClose() {
    progressTimer.cancel();
    secondTimer.cancel();
    super.onClose();
  }
}
