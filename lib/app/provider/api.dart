import 'api_interface.dart';
import 'interceptors/jwt.dart';
import 'interceptors/log.dart';

class ProdApiProvider extends ApiProvider {
  final baseUrl = 'https://prod-next.dimipay.io/kiosk';

  ProdApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class ProdSecureApiProvider extends SecureApiProvider {
  final baseUrl = 'https://prod-next.dimipay.io/kiosk';

  ProdSecureApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class DevApiProvider extends ApiProvider {
  final baseUrl = 'https://dev-next.dimipay.io/kiosk';

  DevApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class DevSecureApiProvider extends SecureApiProvider {
  final baseUrl = 'https://dev-next.dimipay.io/kiosk';

  DevSecureApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}
