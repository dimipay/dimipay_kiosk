import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class FaceSignRepository {
  Future<dynamic> faceSign(String accessToken, Uint8List imageBytes) async {
    String url = "/kiosk/face-sign";
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $accessToken',
      'Transaction-ID': await AuthService.to.transactionId
    };

    try {
      Response response = await ApiProvider.to.post(
        url,
        data: FormData.fromMap(
          {
            "image": MultipartFile.fromBytes(
              imageBytes,
              filename: "image.jpeg",
              contentType: MediaType('image', 'jpeg'),
            ),
          },
        ),
        options: Options(
          headers: headers,
          contentType: Headers.multipartFormDataContentType,
        ),
      );
      return [
        User.fromJson(response.data["data"]["foundUsers"][0]),
        AltUser.fromJson(response.data["data"]["foundUsers"]?[1]),
        AltUser.fromJson(response.data["data"]["foundUsers"]?[2])
      ];
    } on DioException {
      throw NoUserFoundException();
    }
  }

  Future<String> faceSignPaymentsPin(
      String accessToken, String url, String pin) async {
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    var a = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromSecureRandom(12)))
        .encrypt({"pin": pin.toString()}.toString(),
            iv: encrypt.IV.fromLength(12))
        .base64;

    print(a);

    try {
      // Response response = await ApiProvider.to.post(
      //   url,
      //   data: encrypt.Encrypter(encrypt.AES(encrypt.Key.fromSecureRandom(12)))
      //       .encrypt({"pin": pin.toString()}.toString(),
      //           iv: encrypt.IV.fromLength(12))
      //       .base64,
      //   options: Options(
      //     headers: headers,
      //   ),
      // );
      // return response.data["data"]["otp"];
      return "asdf";
    } on DioException catch (e) {
      throw IncorrectPinException(e.response?.data["message"]);
    }
  }
}
