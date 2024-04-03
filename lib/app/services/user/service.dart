// final Rx<UserFace?> _users = Rx(null);

// final Rx<FaceSignStatus> _faceSignStatus = Rx(FaceSignStatus.loading);
  // final Rx<CameraController?> _cameraController = Rx(null);

// UserFace? get users => _users.value;
  // FaceSignStatus get faceSignStatus => _faceSignStatus.value;

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