import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:get/get.dart';
import 'dart:typed_data';

import 'model.dart';

class FaceSignService extends GetxController {
  final FaceSignRepository repository;

  Rx<String?> otp = Rx<String?>(null);

  FaceSignService({FaceSignRepository? repository})
      : repository = repository ?? FaceSignRepository();

  Future<User> getUserWithFaceSign(
      {required Uint8List image, required String transactionId}) async {
    User data = await repository.getUserWithFaceSign(
        file: image, transactionId: transactionId);

    return data;
  }

  Future<void> getFaceSignOTP(
      {required String transactionId,
      required String paymentPinAuthURL,
      required String pin}) async {
    String data = await repository.getFaceSignOTP(
        transactionId: transactionId,
        paymentPinAuthURL: paymentPinAuthURL,
        pin: pin);

    otp.value = data;
  }

  void resetOTP() {
    otp.value = null;
  }
}
