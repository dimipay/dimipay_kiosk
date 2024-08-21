import 'package:cryptography/cryptography.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'dart:convert';

import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class FaceSignRepository {
  Future<List<User>> faceSign(Uint8List imageBytes) async {
    String url = "/kiosk/face-sign";

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
          contentType: Headers.multipartFormDataContentType,
        ),
      );

      return [for (int i = 0; i < (response.data["data"]["foundUsers"] as List).length; i++) User.fromJson(response.data["data"]["foundUsers"][i])];
    } on DioException {
      throw NoUserFoundException();
    }
  }

  Future<String?> faceSignPaymentsPin(String url, String pin) async {
    var encrypt = await AesGcm.with128bits(nonceLength: 12).encrypt(Uint8List.fromList({"\"pin\"": "\"$pin\""}.toString().codeUnits), secretKey: SecretKey((await AuthService.to.encryptionKey)!));

    try {
      Response response = await ApiProvider.to.post(
        url,
        data: base64.encode(
          [
            12,
            ...encrypt.nonce,
            ...encrypt.mac.bytes,
            ...encrypt.cipherText,
          ],
        ),
        options: Options(
          contentType: "application/octet-stream",
        ),
      );
      return response.data["data"]["otp"];
    } on DioException catch (e) {
      throw IncorrectPinException(e.response?.data["message"]);
    }
  }

  Future<PaymentApprove?> faceSignPaymentsApprove(String otp) async {
    String url = "/kiosk/face-sign/payments/approve";

    try {
      Response response = await ApiProvider.to.post(
        url,
        options: Options(
          headers: {
            "DP-PAYMENT-PIN-OTP": otp,
            "DP-DCH-USER-ID": FaceSignService.to.user.id,
          },
        ),
        data: {
          "products": [
            for (var product in ProductService.to.productList.keys) {"id": ProductService.to.productList[product]!.id, "amount": ProductService.to.productList[product]!.count.value}
          ],
          "paymentMethodId": FaceSignService.to.user.paymentMethods.methods[FaceSignService.to.paymentIndex.value].id,
        },
      );

      if (response.data["data"]["status"] != PaymentResponse.success) {
        throw PaymentApproveFailedException(response.data["data"]["message"]);
      }

      return PaymentApprove.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw PaymentApproveFailedException(e.response?.data["message"]);
    }
  }
}
