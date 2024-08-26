import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

enum PaymentType { qr, faceSign }

class PaymentPendingPageController extends GetxController {
  TransactionService transactionService = TransactionService();

  final paymentType = PaymentType.qr.obs;
  final transactionId = RxString('');
  final productItems = RxList<ProductItem>([]);
  final dpToken = RxString('');

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      paymentType.value = args['type'] ?? PaymentType.qr;
      transactionId.value = args['transactionId'] ?? '';
      productItems.value = args['productItems'];
      dpToken.value = args['dpToken'] ?? '';
    }
    if (paymentType.value == PaymentType.qr) {
      startQRPayment();
    }
  }

  void startQRPayment() {
    try {
      transactionService.payQR(
          transactionId: transactionId.value,
          dpToken: dpToken.value,
          productList: productItems);
      Get.offNamed(Routes.PAYMENT_SUCCESS);
    } on ForbiddenUserException catch (e) {
      DPAlertModal.open(e.message);
      Get.offNamed(Routes.PAYMENT_FAILED);
    } on WrongPayTokenException catch (e) {
      DPAlertModal.open(e.message);
      Get.offNamed(Routes.PAYMENT_FAILED);
    } on UnknownProductException catch (e) {
      DPAlertModal.open(e.message);
      Get.offNamed(Routes.PAYMENT_FAILED);
    } on FailedToCancelTransactionException catch (e) {
      DPAlertModal.open(e.message);
      Get.offNamed(Routes.PAYMENT_FAILED);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
      Get.offNamed(Routes.PAYMENT_FAILED);
    }
  }
}
