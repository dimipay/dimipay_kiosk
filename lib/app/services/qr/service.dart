import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/services/qr/repository.dart';
import 'package:dimipay_kiosk/app/services/qr/model.dart';

class QRService extends GetxController {
  static QRService get to => Get.find<QRService>();

  final QRRepository repository;
  QRService({QRRepository? repository}) : repository = repository ?? QRRepository();

  Future<bool> approvePayment(String token) async {
    if ((await repository.qrPaymentsApprove(token))?.status == PaymentResponse.success) {
      TransactionService.to.deleteTransactionId();
      return true;
    }
    return false;
  }
}
