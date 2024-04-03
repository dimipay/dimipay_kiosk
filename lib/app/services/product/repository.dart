import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/core/utils/errors.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/product/model.dart';

class ProductRepository {
  final ApiProvider api;

  ProductRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Product> getProduct(String barcode, String accessToken) async {
    String url = "/kiosk/product/$barcode";
    Map<String, dynamic> headers = {'Authorization': 'Bearer $accessToken'};
    try {
      Response response =
          await api.get(url, options: Options(headers: headers));
      return Product.fromJson(response.data["data"]["product"]);
    } on DioException catch (e) {
      throw NoProductException(e.response?.data["message"]);
    }
  }
}
