import 'dart:async';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/kiosk/model.dart';
import 'package:dimipay_kiosk/app/services/timer/service.dart';
import 'package:dimipay_kiosk/app/services/transaction/model.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

enum PaymentType { qr, faceSign }

class PaymentPendingPageController extends GetxController {
  TransactionService transactionService = TransactionService();
  TimerService timerService = Get.find<TimerService>();
  Timer? _paymentTimer;

  final paymentType = PaymentType.qr.obs;
  final transactionId = RxString('');
  final productItems = RxList<ProductItem>([]);
  final dpToken = RxString('');

  final paymentMethodId = RxString('');
  final otp = RxString('');

  @override
  void onInit() {
    super.onInit();
    timerService.stopTimer();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      paymentType.value = args['type'] ?? PaymentType.qr;
      transactionId.value = args['transactionId'] ?? '';
      productItems.value = args['productItems'];
      dpToken.value = args['dpToken'] ?? '';
      paymentMethodId.value = args['paymentMethodId'] ?? '';
      otp.value = args['otp'] ?? '';
    }

    // 5초 타이머 설정
    _paymentTimer = Timer(const Duration(seconds: 10), () {
      DPAlertModal.open('결제 시간이 초과되었습니다.');
      Get.offAllNamed(Routes.ONBOARDING);
    });

    if (paymentType.value == PaymentType.qr) {
      startQRPayment();
    } else if (paymentType.value == PaymentType.faceSign) {
      startFaceSignPayment();
    }
  }

  @override
  void onClose() {
    timerService.stopTimer();
    _paymentTimer?.cancel(); // 타이머 취소
    super.onClose();
  }

  List<Map<String, dynamic>> _formatProductList() {
    return productItems
        .map((product) => {"id": product.id, "amount": product.amount})
        .toList();
  }

  Future<void> startQRPayment() async {
    try {
      TransactionResult result = await transactionService.payQR(
          transactionId: transactionId.value,
          dpToken: dpToken.value,
          formattedProductList: _formatProductList());

      if (result.status == 'CONFIRMED') {
        Get.offAndToNamed(Routes.PAYMENT_SUCCESS);
      } else {
        DPAlertModal.open(result.message);
        Get.offAndToNamed(Routes.PAYMENT_FAILED);
      }
    } on NoTransactionIdFoundException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on ForbiddenUserException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on WrongPayTokenException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on UnknownProductException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on FailedToCancelTransactionException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    }
  }

  Future<void> startFaceSignPayment() async {
    try {
      TransactionResult result = await transactionService.payFaceSign(
          transactionId: transactionId.value,
          otp: otp.value,
          paymentMethodId: paymentMethodId.value,
          formattedProductList: _formatProductList());

      if (result.status == 'CONFIRMED') {
        Get.offAndToNamed(Routes.PAYMENT_SUCCESS);
      } else {
        DPAlertModal.open(result.message);
        Get.offAndToNamed(Routes.PAYMENT_FAILED);
      }
    } on NoTransactionIdFoundException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on InvalidOTPException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on ForbiddenUserException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on UnknownProductException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on FailedToCancelTransactionException catch (e) {
      DPAlertModal.open(e.message);
      Get.offAndToNamed(Routes.PAYMENT_FAILED);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
    }
  }
}