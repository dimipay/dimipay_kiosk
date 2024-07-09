import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

import 'package:dimipay_kiosk/globals.dart' as globals;

enum FaceSignStatus { loading, success, failed, multipleUserDetected }

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  final Rx<Uint8List> imageSample = Rx(Uint8List(0));

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
      ResolutionPreset.low,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    await _cameraController.value!.initialize();
    await _cameraController.value!.setFlashMode(FlashMode.off);
    return this;
  }

  Future<Uint8List> _captureImage() async {
    Uint8List? image;
    await _cameraController.value!.startImageStream((capturedImage) async {
      await Future.delayed(const Duration(milliseconds: 2500));
      image = capturedImage.planes[0].bytes;
    });
    // await Future.delayed(const Duration(milliseconds: 2500));
    await _cameraController.value!.stopImageStream();
    return image!;
  }

  Future<void> findUser() async {
    int attempts = 0;

    _stop.value = false;
    if (_faceSignStatus.value != FaceSignStatus.loading) {
      _faceSignStatus.value = FaceSignStatus.loading;
    }

    if (_users.value.isNotEmpty) resetUser();

    if (globals.isSimulator) {
      try {
        _users.value = await repository.faceSign(
            (await rootBundle.load('assets/images/single_test_face.jpg'))
                .buffer
                .asUint8List());

        _faceSignStatus.value = _users.value.length > 1
            ? FaceSignStatus.multipleUserDetected
            : FaceSignStatus.success;

        return;
      } on NoUserFoundException {
        attempts++;
      }
    }

    // Uint8List? image;
    // await
    // _cameraController.value!.startImageStream((capturedImage) {
    //   FaceSignService.to.imageSample.value = capturedImage.planes[0].bytes;
    //   print(FaceSignService.to.imageSample.value);
    // await Future.delayed(const Duration(milliseconds: 500), () {
    // image = capturedImage.planes[0].bytes;
    // });
    // });

    // if (_stop.value) {
    //   return;
    // } else {
    //   await Future.delayed(const Duration(milliseconds: 2500));
    // }

    // while (attempts < 10) {
    // try {
    // print(image!);
    // _users.value = await repository.faceSign(image);
    // _users.value = await repository.faceSign(await _captureImage());

    // _users.value = await repository.faceSign(
    //     await (await _cameraController.value!.takePicture()).readAsBytes());

    //     _faceSignStatus.value = _users.value.length > 1
    //         ? FaceSignStatus.multipleUserDetected
    //         : FaceSignStatus.success;
    //   } on NoUserFoundException {
    //     attempts++;
    //   }
    // }

    // await _cameraController.value!.stopImageStream();
  }

  Future<bool> approvePayment(String pin) async {
    try {
      var otp = await repository.faceSignPaymentsPin(
          _users.value[0].paymentMethods.paymentPinAuthURL, pin);
      await repository.faceSignPaymentsApprove(otp);
      TransactionService.to.removeTransactionId;
      return true;
    } catch (_) {
      return false;
    }
  }
}
