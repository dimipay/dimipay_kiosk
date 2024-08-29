import 'package:camera/camera.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class FaceSignRepository {
  final SecureApiProvider secureApi;

  FaceSignRepository({SecureApiProvider? secureApi})
      : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  Future<User> getUserWithFaceSign(
      {required Uint8List file, required String transactionId}) async {
    String url = "/kiosk/face-sign";

    try {
      final response = await secureApi.post(url,
          data: FormData.fromMap(
            {
              'image': MultipartFile.fromBytes(
                file,
                filename: "image.jpeg",
                contentType: MediaType('image', 'jpeg'),
              ),
            },
          ),
          options: Options(headers: {'Transaction-ID': transactionId}));

      return User.fromJson(response.data["foundUsers"][0]);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_NO_MATCHED_USER') {
        throw NoMatchedUserException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_NO_TRANSACTION_ID_FOUND') {
        throw NoTransactionIdFoundException(
            message: e.response?.data['message']);
      }
      throw UnknownException(message: e.response?.data['message']);
    }
  }

  Future<String> getFaceSignOTP(
      {required String transactionId,
      required String paymentPinAuthURL,
      required String pin}) async {
    try {
      final response = await secureApi.post(
        paymentPinAuthURL,
        options: Options(
          headers: {
            'Transaction-ID': transactionId,
          },
        ),
        encrypt: true,
        data: {
          'pin': pin,
        },
      );

      return response.data["otp"];
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_INVALID_USER_TOKEN') {
        throw InvalidUserTokenException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_PAYMENT_PIN_NOT_MATCH') {
        throw PaymentPinNotMatchException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_TRY_LIMIT_EXCEEDED') {
        throw TryLimitExceededException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_NO_TRANSACTION_ID_FOUND') {
        throw NoTransactionIdFoundException(
            message: e.response?.data['message']);
      }
      throw UnknownException(message: e.response?.data['message']);
    }
  }
}
