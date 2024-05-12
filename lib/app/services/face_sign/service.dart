import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

import 'package:dimipay_kiosk/globals.dart' as globals;

enum FaceSignStatus { loading, success, failed, multipleUserDetected }

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  // final kDebugMode = false;

  final FaceSignRepository repository;
  FaceSignService({FaceSignRepository? repository})
      : repository = repository ?? FaceSignRepository();

  final Rx<bool> _stop = Rx(false);
  final Rx<List<dynamic>> _users = Rx([]);
  final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);
  final Rx<CameraController?> _cameraController = Rx(null);

  List<dynamic> get users => _users.value;
  FaceSignStatus get faceSignStatus => _faceSignStatus.value;

  void stop() {
    resetUser();
    _stop.value = true;
  }

  void resetUser() {
    _faceSignStatus.value = FaceSignStatus.loading;
    _users.value = [];
  }

  Future<FaceSignService> init() async {
    super.onInit();
    if (globals.isSimulator) return this;
    _cameraController.value = CameraController(
      ((await availableCameras())[1]),
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    await _cameraController.value!.initialize();
    await _cameraController.value!.setFlashMode(FlashMode.off);
    return this;
  }

  Future<void> findUser() async {
    int attempts = 0;
    _stop.value = false;
    if (_faceSignStatus.value != FaceSignStatus.loading) {
      _faceSignStatus.value = FaceSignStatus.loading;
    }
    if (_users.value.isNotEmpty) resetUser();

    if (globals.isSimulator) {
      _users.value = await repository
          .faceSign((await rootBundle.load("assets/images/test_face.jpg"))
              // (await rootBundle.load("assets/images/user_test_face.jpeg"))
              .buffer
              .asUint8List());
      _faceSignStatus.value = FaceSignStatus.success;
    } else {
      _cameraController.value!.startImageStream((image) async {
        if (_stop.value) return;

        if (attempts > 10) {
          _faceSignStatus.value = FaceSignStatus.failed;
          _cameraController.value!.stopImageStream();
        }

        try {
          _users.value = await repository.faceSign(image.planes[0].bytes);
        } on NoUserFoundException {
          // print(attempts);
          attempts++;
        }
        _faceSignStatus.value = _users.value.length > 1
            ? FaceSignStatus.multipleUserDetected
            : FaceSignStatus.success;
        _cameraController.value!.stopImageStream();
      });
    }
  }

  Future<bool> approvePayment(String pin) async {
    try {
      var otp = await repository.faceSignPaymentsPin(
          _users.value[0].paymentMethods.paymentPinAuthURL, pin);
      await repository.faceSignPaymentsApprove(otp);
      return true;
    } catch (_) {
      return false;
    }
  }
}
