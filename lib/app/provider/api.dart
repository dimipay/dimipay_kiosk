import 'package:dio/dio.dart';

import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';

class JWTInterceptor extends Interceptor {
  final Dio _dioInstance;

  JWTInterceptor(this._dioInstance);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path == '/kiosk/auth/refresh') {
      return handler.next(options);
    }

    if (AuthService.to.isAuthenticated) {
      options.headers['Authorization'] = 'Bearer ${AuthService.to.accessToken}';
      if (options.path.contains("face-sign") || options.path.contains("qr")) {
        options.headers['Transaction-ID'] = await TransactionService.to.transactionId;
      }
    }
    print("-----------------------REQUEST-----------------------");
    print("path : ${options.path}");
    print("header : ${options.headers}");
    print("data : ${options.data}");

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("-----------------------RESPONSE-----------------------");
    print(response.data);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.requestOptions.path == '/kiosk/auth/refresh') {
      return handler.next(err);
    }

    print("-----------------------ERROR-----------------------");
    print(err);
    print(err.response);

    if (err.response?.statusCode == 401 && AuthService.to.accessToken != null) {
      try {
        await AuthService.to.refreshAccessToken();
        final Response response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}

class ProdApiProvider extends ApiProvider {
  final baseUrl = 'https://prod-next.dimipay.io/';

  ProdApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class DevApiProvider extends ApiProvider {
  final baseUrl = 'https://dev-next.dimipay.io/';

  DevApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(JWTInterceptor(dio));
  }
}
