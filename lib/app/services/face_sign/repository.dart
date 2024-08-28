import 'package:camera/camera.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class FaceSignRepository {
  final SecureApiProvider secureApi;

  FaceSignRepository({SecureApiProvider? secureApi})
      : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  Future<User> getUserWithFaceSign(
      {required XFile file, required String transactionId}) async {
    String url = "/kiosk/face-sign";

    MultipartFile faceSign = await MultipartFile.fromFile(file.path,
        contentType: MediaType('image', 'jpeg'));

    try {
      final response = await secureApi.post(url,
          data: FormData.fromMap(
            {
              'image': faceSign,
            },
          ),
          options: Options(headers: {'Transaction-ID': transactionId}));

      return User.fromJson(response.data["foundUsers"][0]);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_NO_MATCHED_USER') {
        throw NoMatchedUserException(message: e.response?.data['message']);
      }
      rethrow;
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
      rethrow;
    }
  }
}
