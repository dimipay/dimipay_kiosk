import 'package:dio/dio.dart';
import 'dart:developer' as dev;

import '../../core/utils/logger.dart';

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final message = '${response.requestOptions.method}[${response.statusCode}] => PATH: ${response.requestOptions.path}';

    dev.log(message, name: 'DIO');
    DPLogCollector.addCustomLog(message, type: 'DIO');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusMessage = '${err.response!.requestOptions.method}[${err.response!.statusCode}] => PATH: ${err.response!.requestOptions.path}';
      final errorData = '${err.response!.data}';

      dev.log(statusMessage, name: 'DIO');
      dev.log(errorData);

      DPLogCollector.addCustomLog('$statusMessage\n$errorData', type: 'DIO_ERROR');
    }

    handler.next(err);
  }
}