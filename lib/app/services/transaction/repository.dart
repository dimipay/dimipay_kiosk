import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class TransactionRepository {
  Future<String?> transactionId() async {
    String url = "/kiosk/transaction/id";
    try {
      Response response = await ApiProvider.to.get(url);
      return response.data["data"]["transactionId"];
    } on DioException catch (e) {
      AlertModal.to.show(e.response?.data["message"]);
      throw NoAccessTokenException(e.response?.data["message"]);
    }
  }
}
