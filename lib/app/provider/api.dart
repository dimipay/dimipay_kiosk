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
  final baseUrl = 'http://server.dimipay.io:4002/';

  ProdApiProvider() {
    dio.options.baseUrl = baseUrl;
  }
}

class DevApiProvider extends ApiProvider {
  final baseUrl = 'http://server.dimipay.io:4002/';

  DevApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
  }
}
