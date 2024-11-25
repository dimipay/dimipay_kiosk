import 'package:dimipay_kiosk/app/routes/routes.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../model/response.dart';

class JWTInterceptor extends Interceptor {
  final Dio _dioInstance;

  JWTInterceptor(this._dioInstance);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AuthService authService = Get.find<AuthService>();

    options.headers['Authorization'] ??=
        'Bearer ${authService.jwt.token.accessToken}';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    DPHttpResponse httpResponse = err.response!.toDPHttpResponse();

    if (httpResponse.code == 'ERR_TOKEN_EXPIRED' ||
        httpResponse.code == 'ERR_TOKEN_ERROR' ||
        httpResponse.code == 'ERR_TOKEN_NOT_FOUND' ||
        httpResponse.code == 'ERR_UNAUTHENTICATED' ||
        httpResponse.code == 'ERR_WRONG_TOKEN_TYPE' ||
        err.type == DioExceptionType.connectionTimeout) {
      AuthService authService = Get.find<AuthService>();

      if (err.requestOptions.path == '/kiosk/auth/refresh') {
        return handler.next(err);
      }

      try {
        await authService.refreshAcessToken();

        err.requestOptions.headers['Authorization'] =
            'Bearer ${authService.jwt.token.accessToken}';
        final response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (refreshError) {
        await _handleLogout(authService);
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  Future<void> _handleLogout(AuthService authService) async {
    await authService.logout();
    Get.offAllNamed(Routes.PIN);
  }
}

extension DioResponseDTO on Response {
  DPHttpResponse toDPHttpResponse() {
    if (requestOptions.responseType == ResponseType.stream) {
      return DPHttpResponse(
        code: '',
        message: '',
        statusCode: 200,
        timeStamp: '',
        data: data,
      );
    }
    return DPHttpResponse(
      code: data['code'],
      message: data['message'],
      statusCode: data['statusCode'],
      timeStamp: data['timestamp'],
      data: data['data'],
      errors: data['errors'],
    );
  }
}
