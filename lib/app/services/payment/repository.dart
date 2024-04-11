import 'package:get/instance_manager.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:dio/dio.dart';
import 'dart:typed_data';

import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class PaymentRepository {
  Future<String> paymentPinAuthURL(
      String url, String pin, String accessToken) async {
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/octec-stream'
    };
    String body =
        encrypt.Encrypter(encrypt.AES(encrypt.Key.fromSecureRandom(12)))
            .encrypt({"pin": pin.toString()}.toString(),
                iv: encrypt.IV.fromLength(12))
            .base64;
    try {
      Response response = await ApiProvider.to.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response.data["data"]["otp"];
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw IncorrectPinException(e.response?.data["message"]);
    }
  }
}
