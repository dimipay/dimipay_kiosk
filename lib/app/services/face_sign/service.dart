import 'package:convert_native_img_stream/convert_native_img_stream.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

import 'package:dimipay_kiosk/globals.dart' as globals;

enum FaceSignStatus { loading, success, failed, multipleUserDetected }

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  final FaceSignRepository repository;
  FaceSignService({FaceSignRepository? repository})
      : repository = repository ?? FaceSignRepository();

  final Rx<bool> _stop = Rx(false);
  final Rx<User?> _user = Rx(null);
  final Rx<int> _paymentIndex = Rx(0);
  final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);

  late final CameraController _camera;
  final ConvertNativeImgStream _convertNative = ConvertNativeImgStream();

  int get paymentIndex => _paymentIndex.value;
  User get user => _user.value!;
  FaceSignStatus get faceSignStatus => _faceSignStatus.value;

  set paymentIndex(int index) => _paymentIndex.value = index;

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
    // if (globals.isSimulator) return this;
    _camera = CameraController(
      ((await availableCameras())[1]),
      ResolutionPreset.low,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    await _camera.initialize();
    await _camera.setFlashMode(FlashMode.off);
    return this;
  }

  Future<Uint8List> _captureImage() async {
    late CameraImage image;
    _camera.startImageStream((capturedImage) => image = capturedImage);
    await Future.delayed(const Duration(milliseconds: 500));
    await _camera.stopImageStream();
    return (await _convertNative.convertImgToBytes(
        image.planes[0].bytes, image.width, image.width))!;
  }

  Future<void> findUser() async {
    int attempts = 0;

    _stop.value = false;
    if (_faceSignStatus.value != FaceSignStatus.loading) {
      _faceSignStatus.value = FaceSignStatus.loading;
    }

    if (_user.value != null) resetUser();

    // if (globals.isSimulator) {
    //   try {
    //     List<User> users = await repository.faceSign(
    //         (await rootBundle.load('assets/images/single_test_face.jpg'))
    //             .buffer
    //             .asUint8List());

    //     if (users.length > 1) {
    //       _faceSignStatus.value = FaceSignStatus.multipleUserDetected;
    //       // select user
    //     } else {
    //       _user.value = users[0];
    //       _faceSignStatus.value = FaceSignStatus.success;
    //     }

    //     return;
    //   } on NoUserFoundException {
    //     // attempts++;
    //   }
    // }

    while (attempts < 10) {
      try {
        List<User> users = await repository.faceSign(await _captureImage());

        if (users.length == 1) {
          _user.value = users[0];
          _faceSignStatus.value = FaceSignStatus.success;
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

  Future<String?> approvePin(String pin) async {
    try {
      return await repository.faceSignPaymentsPin(
          _user.value!.paymentMethods.paymentPinAuthURL!, pin);
    } catch (_) {
      return null;
    }
  }

  Future<bool> approvePayment(String otp) async {
    if ((await repository.faceSignPaymentsApprove(otp))?.status ==
        PaymentResponse.success) {
      TransactionService.to.deleteTransactionId();
      return true;
    }
    return false;
  }
}
