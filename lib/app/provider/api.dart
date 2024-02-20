import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/provider/api_interface.dart';

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

class ProdApiProvider extends ApiProvider {
  final baseUrl = 'https://api.dimipay.io';

  ProdApiProvider() {
    dio.options.baseUrl = baseUrl;
  }
}

class DevApiProvider extends ApiProvider {
  final baseUrl = 'https://dev-api.dimipay.io';

  DevApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
  }
}
