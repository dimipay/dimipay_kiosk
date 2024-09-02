import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/pages/payment/paymeent_pending/controller.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/timer/service.dart';
import 'package:dimipay_kiosk/app/widgets/snackbar.dart';
import 'package:get/get.dart';

enum PinPageType {
  login,
  facesign,
}

class PinPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  FaceSignService faceSignService = Get.find<FaceSignService>();
  TimerService timerService = Get.find<TimerService>();

  final PinPageType pinPageType =
      Get.arguments?['pinPageType'] ?? PinPageType.login;

  final PaymentType? paymentType = Get.arguments?['type'];
  final String? transactionId = Get.arguments?['transactionId'];
  final List<dynamic>? productItems = Get.arguments?['productItems'];
  final String? paymentPinAuthURL = Get.arguments?['paymentPinAuthURL'];
  final String? paymentMethodId = Get.arguments?['paymentMethodId'];

  final Rx<List<int>> _nums = Rx([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);

  List<int> get nums => _nums.value;

  final Rx<String> _pin = Rx('');

  String get pin => _pin.value;

  bool get backBtnEnabled => pin.isNotEmpty && pin.length < 4;

  bool get numpadEnabled => pin.length < 4;

  @override
  void onInit() {
    _shufleList();
    if (pinPageType == PinPageType.facesign) {
      timerService.stopTimer();
    }
    super.onInit();
  }

  @override
  void onClose() {
    if (pinPageType == PinPageType.facesign) {
      timerService.startTimer();
    }
    super.onClose();
  }

  void _shufleList() {
    _nums.value.shuffle();
    _nums.refresh();
  }

  void onPinTap(String value) async {
    if (value == 'del') {
      if (pin.length > 0 && pin.length < 4) {
        _pin.value = pin.substring(0, pin.length - 1);
      }
      return;
    }
    _pin.value += value;
  }

  void clearPin() {
    _pin.value = '';
  }

  Future<void> loginWithPasscode() async {
    try {
      await authService.loginWithPasscode(passcode: pin);
      Get.offNamed(Routes.ONBOARDING);
    } on PasscodeNotFoundException catch (e) {
      DPAlertModal.open(e.message);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
    }
  }

  Future<void> payFaceSign() async {
    try {
      await faceSignService.getFaceSignOTP(
        transactionId: transactionId!,
        paymentPinAuthURL: paymentPinAuthURL!,
        pin: pin,
      );
      Get.offNamed(Routes.PAYMENT_PENDING, arguments: {
        'type': paymentType,
        'transactionId': transactionId,
        'productItems': productItems,
        'paymentMethodId': paymentMethodId,
        'otp': faceSignService.otp.value,
      });
    } on InvalidUserTokenException catch (e) {
      DPAlertModal.open(e.message);
    } on PaymentPinNotMatchException catch (e) {
      DPAlertModal.open(e.message);
    } on TryLimitExceededException catch (e) {
      DPAlertModal.open(e.message);
    } on NoTransactionIdFoundException catch (e) {
      DPAlertModal.open(e.message);
    } on UnknownException catch (e) {
      DPAlertModal.open(e.message);
    }
  }
}
