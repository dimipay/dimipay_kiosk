import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/product/model.dart';

class KioskRepository {
  final ApiProvider api;

  KioskRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Product> getProduct(String barcode, String accessToken) async {
    String url = "/product/$barcode";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    Response response = await api.post(url, options: Options(headers: headers));
    return response.data["product"];
  }
}
