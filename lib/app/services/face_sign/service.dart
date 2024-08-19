import 'package:convert_native_img_stream/convert_native_img_stream.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/services/health/service.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/routes/routes.dart';

enum FaceSignStatus { loading, success, failed, multipleUserDetected }

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  final FaceSignRepository repository;
  FaceSignService({FaceSignRepository? repository}) : repository = repository ?? FaceSignRepository();

  final Rx<int> paymentIndex = Rx(0);
  final Rx<bool> _stop = Rx(false);
  final Rx<User?> _user = Rx(null);
  final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);

  bool isRetry = false;
  bool _isStreaming = false;
  String? _otp;
  late CameraController _camera;
  final ConvertNativeImgStream _convertNative = ConvertNativeImgStream();

  User get user => _user.value!;
  FaceSignStatus get faceSignStatus => _faceSignStatus.value;

  void stop() {
    resetUser();
    _stop.value = true;
  }

  void resetUser() {
    _faceSignStatus.value = FaceSignStatus.loading;
    _user.value = null;
  }

  Future<FaceSignService> init() async {
    super.onInit();
    _camera = CameraController(((await availableCameras())[1]), ResolutionPreset.low, imageFormatGroup: ImageFormatGroup.jpeg, enableAudio: false);
    await _camera.initialize();
    await _camera.setFlashMode(FlashMode.off);
    return this;
  }

  Future<Uint8List> _captureImage() async {
    late CameraImage image;
    try {
      if (!_isStreaming) {
        _camera.startImageStream((capturedImage) {
          _isStreaming = true;
          image = capturedImage;
        });
      }
      await Future.delayed(const Duration(milliseconds: 250));
      await _camera.stopImageStream();
      return (await _convertNative.convertImgToBytes(image.planes[0].bytes, image.width, image.width))!;
    } catch (_) {
      return _captureImage();
    }
  }

  Future<void> findUser() async {
    int attempts = 0;

    _stop.value = false;
    if (_faceSignStatus.value != FaceSignStatus.loading) {
      _faceSignStatus.value = FaceSignStatus.loading;
    }
    if (_user.value != null) resetUser();

    while (attempts < 10) {
      try {
        List<User> users = await repository.faceSign(await _captureImage());
        if (users.length == 1) {
          _user.value = users[0];
          _faceSignStatus.value = FaceSignStatus.success;
          setMainPaymentMethod();
        } else {
          _faceSignStatus.value = FaceSignStatus.multipleUserDetected;
        }
        return;
      } on NoUserFoundException {
        attempts++;
      }
    }

    _faceSignStatus.value = FaceSignStatus.failed;
  }

  void setMainPaymentMethod() {
    if (_user.value != null) {
      String? mainMethodId = _user.value!.paymentMethods.mainPaymentMethodId;
      if (mainMethodId != null) {
        int index = _user.value!.paymentMethods.methods.indexWhere((method) => method.id == mainMethodId);
        if (index != -1) {
          paymentIndex.value = index;
        } else {
          paymentIndex.value = 0; // mainMethodId가 없으면 첫 번째 방법을 선택
        }
      } else {
        paymentIndex.value = 0; // mainMethodId가 null이면 첫 번째 방법을 선택
      }
    }
  }

  PaymentMethod? getMainPaymentMethod() {
    if (_user.value != null) {
      String? mainMethodId = _user.value!.paymentMethods.mainPaymentMethodId;
      if (mainMethodId != null) {
        return _user.value!.paymentMethods.methods.firstWhere(
          (method) => method.id == mainMethodId,
          orElse: () => _user.value!.paymentMethods.methods.first,
        );
      }
    }
    return null;
  }

  Future<void> approvePin(String pin) async {
    try {
      _otp = await repository.faceSignPaymentsPin(_user.value!.paymentMethods.paymentPinAuthURL!, pin);
      return approvePayment();
    } catch (_) {}
  }

  Future<void> approvePayment() async {
    if (_otp == null) return;

    var response = await repository.faceSignPaymentsApprove(_otp!);

    if (response!.status == PaymentResponse.success) {
      paymentIndex.value = 0;
      isRetry = false;
      _otp = null;
      Get.toNamed(Routes.PAYMENT_SUCCESS);
      ProductService.to.clearProductList();
      TransactionService.to.deleteTransactionId();
      await Future.delayed(const Duration(seconds: 3), () => Get.until((route) => route.settings.name == Routes.ONBOARD));
      HealthService.to.checkHealth();
      return;
    }

    isRetry = true;
    TransactionService.to.refreshTransactionId();
    Get.toNamed(Routes.PAYMENT_FAILED);
    AlertModal.to.show(response.message);
    return;
  }
}
