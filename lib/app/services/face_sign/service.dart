import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';

class FaceSignService extends GetxController {
  static FaceSignService get to => Get.find<FaceSignService>();

  final FaceSignRepository repository;

  FaceSignService({FaceSignRepository? repository})
      : repository = repository ?? FaceSignRepository();

  final Rx<List<User>> _users = Rx([]);
  final Rx<CameraController?> _cameraController = Rx(null);

  void resetUser() {
    _users.value = [];
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    if (kDebugMode) return;
    _cameraController.value = CameraController(
        ((await availableCameras())[1]), ResolutionPreset.high,
        imageFormatGroup:
            Platform.isIOS ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
        enableAudio: false);
    await _cameraController.value!.initialize();
    await _cameraController.value!.setFlashMode(FlashMode.off);
  }

  Future<void> findUser() async {
    if (_users.value.isNotEmpty) resetUser();
    do {
      if (kDebugMode) {
        _users.value = await repository.faceSign(
            AuthService.to.accessToken!, "assets/images/single_test_face.png");
      } else {
        final image = await _cameraController.value!.takePicture();
        _users.value =
            await repository.faceSign(AuthService.to.accessToken!, image.path);
      }
    } while (_users.value.isEmpty);
  }
}








// final Rx<UserFace?> _users = Rx(null);

// final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);
  // final Rx<CameraController?> _cameraController = Rx(null);

// UserFace? get users => _users.value;
  // FaceSignStatus get faceSignStatus => _faceSignStatus.value;

  // Future<void> findUser() async {
  //   if (_users.value != null) resetUser();
  //   do {
  //     if (kDebugMode) {
  //       _users.value = await repository.findUserByFace(
  //           accessToken!, "assets/images/single_test_face.png");
  //     } else {
  //       final image = await _cameraController.value!.takePicture();
  //       _users.value =
  //           await repository.findUserByFace(accessToken!, image.path);
  //     }
  //   } while (_users.value == null);
  //   if (_users.value!.users.length > 1) {
  //     _faceSignStatus.value = FaceSignStatus.multipleUserDetected;
  //     return;
  //   }
  //   _faceSignStatus.value = FaceSignStatus.success;
  //   repository.getPaymentByFace(
  //       accessToken!, _users.value!.code, _users.value!.users[0].id, "0221");
  // }

