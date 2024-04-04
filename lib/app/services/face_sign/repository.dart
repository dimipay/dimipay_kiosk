import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/services/face_sign/model.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class FaceSignRepository {
  Future<List<User>> faceSign(String accessToken, String imagePath) async {
    String url = "/kiosk/face-sign";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    try {
      FormData formData;
      if (kDebugMode) {
        var bytes = (await rootBundle.load(imagePath)).buffer.asUint8List();
        formData = FormData.fromMap({
          "image": MultipartFile.fromBytes(bytes, filename: "face.jpg"),
        });
      } else {
        formData = FormData.fromMap({
          "image":
              await MultipartFile.fromFile(imagePath, filename: "face.jpg"),
        });
      }

      Response response = await ApiProvider.to.post(url,
          data: formData,
          options: Options(
              headers: headers,
              contentType: Headers.multipartFormDataContentType));

      var a = [
        for (var user in response.data["data"]["foundedUsers"])
          User.fromJson(user)
      ];
      print(a);

      // return List<User>.from(response.data["data"]);
      return [
        for (var user in response.data["data"]["foundedUsers"])
          User.fromJson(user)
      ];
    } on DioException catch (e) {
      print(e.response);
      throw NoAccessTokenException(e.response?.data["message"]);
    }
  }
}








//  Future<UserPayment?> getPaymentByFace(
//       String accessToken, String code, String userId, String pin) async {
//     String url = "/auth/face/method?code=$code&userId=$userId&pin=$pin";
//     Map<String, dynamic> headers = {'Authorization': 'Bearer$accessToken'};
//     try {
//       Response response =
//           await api.get(url, options: Options(headers: headers));
//       return UserPayment.fromJson(response.data);
//     } on DioException catch (e) {
//       if (e.response?.data["code"] == "ERR_FACE_NOT_FOUND") return null;
//       AlertModal.to.show(e.response?.data["message"]);
//       throw NoAccessTokenException(e.response?.data["message"]);
//     }
//   }

//   Future<UserFace?> findUserByFace(String accessToken, String imagePath) async {
//     String url = "/auth/face/find";
//     Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
//     try {
//       FormData formData;
//       if (kDebugMode) {
//         var bytes = (await rootBundle.load(imagePath)).buffer.asUint8List();
//         formData = FormData.fromMap({
//           "image": MultipartFile.fromBytes(bytes, filename: "face.jpg"),
//         });
//       } else {
//         formData = FormData.fromMap({
//           "image":
//               await MultipartFile.fromFile(imagePath, filename: "face.jpg"),
//         });
//       }

//       Response response = await api.post(url,
//           data: formData,
//           options: Options(
//               headers: headers,
//               contentType: Headers.multipartFormDataContentType));
//       return UserFace.fromJson(response.data);
//     } on DioException catch (e) {
//       if (e.response?.data["code"] == "ERR_FACE_NOT_FOUND") return null;
//       AlertModal.to.show(e.response?.data["message"]);
//       throw NoAccessTokenException(e.response?.data["message"]);
//     }
//   }