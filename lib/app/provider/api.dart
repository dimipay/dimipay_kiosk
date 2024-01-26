import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as dev;

class JWTInterceptor extends Interceptor {
  final Dio _dioInstance;

  // Dependency Injection
  JWTInterceptor(this._dioInstance);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AuthService authService = Get.find<AuthService>();
    if (options.path == '/auth/refresh') {
      return handler.next(options);
    }

    if (authService.isAuthenticated) {
      options.headers['Authorization'] = 'Bearer ${authService.accessToken}';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AuthService authService = Get.find<AuthService>();
    //refresh api가 401시 무한 루프 방지
    if (err.response?.requestOptions.path == '/auth/refresh') {
      return handler.next(err);
    }

    if (err.response?.statusCode == 401 && authService.accessToken != null) {
      try {
        // await authService.refreshAcessToken();
        print("error");

        //api 호출을 다시 시도함
        final Response response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dev.log(
        '${response.requestOptions.method}[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        name: 'DIO');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      dev.log(
          '${err.response!.requestOptions.method}[${err.response!.statusCode}] => PATH: ${err.response!.requestOptions.path}',
          name: 'DIO');
      dev.log('${err.response!.data}');
    }
    handler.next(err);
  }
}

class ProdApiProvider extends ApiProvider {
  final baseUrl = 'https://api.dimipay.io';

  ProdApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class DevApiProvider extends ApiProvider {
  final baseUrl = 'https://dev-api.dimipay.io';

  DevApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}