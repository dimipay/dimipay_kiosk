import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/transaction/service.dart';
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
    var response = await repository.qrPaymentsApprove(token);
    if (response!.status == PaymentResponse.success) {
      Get.toNamed(Routes.PAYMENT_SUCCESS);
      ProductService.to.clearProductList();
      TransactionService.to.deleteTransactionId();
      await Future.delayed(const Duration(seconds: 5), () => Get.until((route) => route.settings.name == Routes.ONBOARD));
      HealthService.to.checkHealth();
      return;
    }

    Get.toNamed(Routes.PAYMENT_FAILED);
    AlertModal.to.show(response.message);
    return;
  }
}
