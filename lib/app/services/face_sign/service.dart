import 'package:camera/camera.dart';
import 'package:dimipay_kiosk/app/services/face_sign/repository.dart';
import 'package:get/get.dart';

import 'model.dart';

class FaceSignService extends GetxController {
  final FaceSignRepository repository;

  FaceSignService({FaceSignRepository? repository})
      : repository = repository ?? FaceSignRepository();

  Future<User> getUserWithFaceSign(
      {required XFile image, required String transactionId}) async {
    User data = await repository.getUserWithFaceSign(
        file: image, transactionId: transactionId);

    return data;
  }

  Future<String> getFaceSignOTP(
      {required String transactionId,
      required String paymentPinAuthURL,
      required String pin}) async {
    String data = await repository.getFaceSignOTP(
        transactionId: transactionId,
        paymentPinAuthURL: paymentPinAuthURL,
        pin: pin);

    return data;
  }
}
