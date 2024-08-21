import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/services/qr/model.dart';

class QRRepository {
  Future<PaymentApprove?> qrPaymentsApprove(String token) async {
    String url = "/kiosk/qr";

    try {
      Response response = await ApiProvider.to.post(
        url,
        options: Options(
          headers: {
            "DP-Token": token,
          },
        ),
        data: {
          "products": [
            for (var product in ProductService.to.productList.keys) {"id": ProductService.to.productList[product]!.id, "amount": ProductService.to.productList[product]!.count.value}
          ],
        },
      );

      return PaymentApprove.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw PaymentApproveFailedException(e.response?.data["message"]);
    }
  }
}
