import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class FaceSignRepository {
  Future<List<User>> faceSign(String accessToken, Uint8List imageBytes) async {
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
      print("wtf");

      print(response.data);

      return [
        for (var user in response.data["data"]["foundedUsers"])
          User.fromJson(user)
      ];
    } catch (e) {
      print(e);
      throw NoUserFoundException();
    }
    // on DioException {
    //   throw NoUserFoundException();
    // }
  }
}
