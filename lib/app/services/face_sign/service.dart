import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

enum FaceSignStatus { loading, success, failed, multipleUserDetected }

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  final FaceSignRepository repository;

  // final kDebugMode = false;

  FaceSignService({FaceSignRepository? repository})
      : repository = repository ?? FaceSignRepository();

  final Rx<List<User>> _users = Rx([]);
  final Rx<bool> _stop = Rx(false);
  final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);
  final Rx<CameraController?> _cameraController = Rx(null);

  FaceSignStatus get faceSignStatus => _faceSignStatus.value;
  List<User> get users => _users.value;

  void stop() {
    _stop.value = true;
  }

  void resetUser() {
    _users.value = [];
  }

  Future<FaceSignService> init() async {
    super.onInit();
    if (kDebugMode) return this;
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
    // _faceSignStatus.value = _faceSignStatus.value != FaceSignStatus.loading
    //     ? FaceSignStatus.loading
    //     : _faceSignStatus.value;
    if (_faceSignStatus.value != FaceSignStatus.loading) {
      _faceSignStatus.value = FaceSignStatus.loading;
    }
    if (_users.value.isNotEmpty) resetUser();

    if (kDebugMode) {
      _users.value = await repository.faceSign(
          AuthService.to.accessToken!,
          (await rootBundle.load("assets/images/single_test_face.png"))
              .buffer
              .asUint8List());
      _faceSignStatus.value = FaceSignStatus.success;
    } else {
      await _cameraController.value!.startImageStream(
        (image) async {
          do {
            if (_stop.value) {
              resetUser();
              return;
            }

            try {
              _users.value = await repository.faceSign(
                AuthService.to.accessToken!,
                image.planes[0].bytes,
              );
              _faceSignStatus.value = _users.value.length > 1
                  ? FaceSignStatus.multipleUserDetected
                  : FaceSignStatus.success;
              return;
            } on NoUserFoundException {
              attempts++;
              continue;
            }
          } while (_users.value.isEmpty && attempts < 10);
          _faceSignStatus.value = FaceSignStatus.failed;
          return;
        },
      );
      _cameraController.value!.stopImageStream();
    }
  }
}
