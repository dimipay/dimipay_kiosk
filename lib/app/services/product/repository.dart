import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/product/model.dart';
import 'package:dimipay_kiosk/app/core/utils/errors.dart';

class ProductRepository {
  Future<Product> getProduct(String barcode) async {
    String url = "/kiosk/product/$barcode";
    try {
      Response response = await ApiProvider.to.get(url);
      return Product.fromJson(response.data["data"]["product"]);
    } on DioException catch (e) {
      throw NoProductException(e.response?.data["message"]);
    }
  }
}
