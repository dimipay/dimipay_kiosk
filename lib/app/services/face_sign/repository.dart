import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class FaceSignRepository {
  // final Map<String, dynamic> _testData = {
  //   "statusCode": 200,
  //   "code": "OK",
  //   "data": {
  //     "foundUsers": [
  //       {
  //         "id": "379638d9-e4a2-449d-9a9d-79d46fe472c5",
  //         "name": "이*빈",
  //         "profileImage":
  //             "https://lh3.googleusercontent.com/a/ACg8ocKdvzrSrIAOu0uDDxVPA1KQ2ZRxjDzFKhLHk-AgAjdm=s96-c",
  //         "paymentMethods": {
  //           "methods": [],
  //           "mainPaymentMethodId": null,
  //           "paymentPinAuthURL": null
  //         }
  //       },
  //       // {
  //       //   "id": "d609dfd8-739f-4fa0-a2b5-2b9fba099b15",
  //       //   "name": "디**페",
  //       //   "profileImage":
  //       //       "https://lh3.googleusercontent.com/a/ACg8ocIaNAJdQZ5kF6NgV1OMdbFSiAlTZmROoshwf7aPj_oaDJg=s96-c",
  //       //   "paymentMethods":
  //       //       "/kiosk/face-sign/payments/methods?t=l2qitQjQyrBFbbZQHjilm"
  //       // }
  //     ]
  //   },
  //   "timestamp": "2024-04-03T01:55:18.842Z"
  // };

  Future<List<User>> faceSign(String accessToken, Uint8List imageBytes) async {
    String url = "/kiosk/face-sign";
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $accessToken',
      'Transaction-ID': await AuthService.to.transactionId
    };

    // if (kDebugMode) {
    //   return [
    //     for (var user in _testData["data"]["foundUsers"]) User.fromJson(user)
    //   ];
    // }

    try {
      Response response = await ApiProvider.to.post(
        url,
        data: FormData.fromMap({
          "image": MultipartFile.fromBytes(
            imageBytes,
            filename: "image.jpeg",
            contentType: MediaType('image', 'jpeg'),
          ),
        }),
        options: Options(
          headers: headers,
          contentType: Headers.multipartFormDataContentType,
        ),
      );

      try {
        return [
          for (var user in response.data["data"]["foundedUsers"])
            User.fromJson(user)
        ];
      } catch (e) {
        throw NoUserFoundException();
      }
    } on DioException {
      throw NoUserFoundException();
    }
  }
}
