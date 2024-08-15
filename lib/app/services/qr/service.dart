import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/health/service.dart';
import 'package:dimipay_kiosk/app/services/qr/repository.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/services/qr/model.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

class QRService extends GetxController {
  static QRService get to => Get.find<QRService>();

  final QRRepository repository;
  QRService({QRRepository? repository}) : repository = repository ?? QRRepository();

  Future<void> approvePayment(String token) async {
    FaceSignService.to.stop();

    // Get.defaultDialog(title: token);

    PaymentApprove? response;

    try {
      response = await repository.qrPaymentsApprove(token);
    } catch (_) {}

    if (response!.status == PaymentResponse.success) {
      Get.toNamed(Routes.PAYMENT_SUCCESS);
      ProductService.to.clearProductList();
      FaceSignService.to.resetUser();
      await Future.delayed(const Duration(seconds: 2), () => Get.until((route) => route.settings.name == Routes.ONBOARD));
      HealthService.to.checkHealth();
      return;
    }

    TransactionService.to.refreshTransactionId();
    Get.toNamed(Routes.PAYMENT_FAILED);
    AlertModal.to.show(response.message);
    return;
  }
}
