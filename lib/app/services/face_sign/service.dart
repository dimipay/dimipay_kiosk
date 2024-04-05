import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

enum FaceSignStatus { loading, success, failed, multipleUserDetected }

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  final FaceSignRepository repository;

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
        ((await availableCameras())[1]), ResolutionPreset.high,
        imageFormatGroup:
            Platform.isIOS ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
        enableAudio: false);
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

    do {
      if (_stop.value) {
        resetUser();
        return;
      }

      try {
        if (kDebugMode) {
          _users.value = await repository.faceSign(
            AuthService.to.accessToken!,
            "assets/images/single_test_face.png",
          );
        } else {
          final image = await _cameraController.value!.takePicture();
          _users.value = await repository.faceSign(
            AuthService.to.accessToken!,
            image.path,
          );
        }
        if (_users.value.length > 1) {
          _faceSignStatus.value = FaceSignStatus.multipleUserDetected;
          return;
        }
        _faceSignStatus.value = FaceSignStatus.success;
        return;
      } on NoUserFoundException {
        attempts++;
        continue;
      }
    } while (_users.value.isEmpty && attempts < 10);
    _faceSignStatus.value = FaceSignStatus.failed;
    return;
  }
}
