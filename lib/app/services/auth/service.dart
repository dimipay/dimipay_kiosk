import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:dimipay_kiosk/app/services/auth/repository.dart';
import 'package:dimipay_kiosk/app/services/auth/model.dart';

enum FaceSignStatus { success, loading, fail, multipleUserDetected }

class AuthService extends GetxController {
  static AuthService get to => Get.find<AuthService>();

  final AuthRepository repository;
  // final Rx<UserFace?> _users = Rx(null);
  final Rx<String> _deviceName = Rx("");
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());
  // final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);
  // final Rx<CameraController?> _cameraController = Rx(null);
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();

  bool get isAuthenticated => _jwtToken.value.accessToken != null;
  String? get accessToken => _jwtToken.value.accessToken;
  // UserFace? get users => _users.value;
  // FaceSignStatus get faceSignStatus => _faceSignStatus.value;

  Future<AuthService> init() async {
    if (kDebugMode) {
      // await _storage.deleteAll();
    } else {
      // initializeCamera();
    }
    final String? refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) {
      return this;
    }
    _jwtToken.value = await repository.authRefresh(refreshToken);
    return this;
  }

  Future<void> _storeJWTToken(JWTToken newToken) async {
    await _storage.write(key: 'refreshToken', value: newToken.refreshToken);
    _jwtToken.value = newToken;
  }

  Future<bool> loginKiosk(String pin) async {
    try {
      var result = await repository.authLogin(pin);
      _deviceName.value = result.name;
      await _storeJWTToken(result.tokens);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Future<void> initializeCamera() async {
  //   _cameraController.value = CameraController(
  //       ((await availableCameras())[1]), ResolutionPreset.high,
  //       imageFormatGroup:
  //           Platform.isIOS ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
  //       enableAudio: false);
  //   await _cameraController.value!.initialize();
  //   await _cameraController.value!.setFlashMode(FlashMode.off);
  // }

  // void resetUser() {
  //   _users.value = null;
  //   _faceSignStatus.value = FaceSignStatus.loading;
  // }

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
}
