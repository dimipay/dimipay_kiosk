import 'dart:async';
import 'dart:convert';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import 'encryptor.dart';
import 'model/response.dart';

abstract class ApiProvider {
  final Dio dio = Dio();

  Future<DPHttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    Response dioResponse =
        await dio.get(path, queryParameters: queryParameters, options: options);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<Stream<Map<String, dynamic>>> getStream(String path) async {
    Response<ResponseBody> dioResponse = await dio.get(
      path,
      options: Options(
        headers: {"Accept": "text/event-stream"},
        responseType: ResponseType.stream,
      ),
    );
    return dioResponse.data!.stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (rawdata, sink) {
          String strData = String.fromCharCodes(rawdata);
          String formatedData =
              strData.substring(strData.indexOf('{'), strData.indexOf('}') + 1);
          Map<String, dynamic> data = json.decode(formatedData);

          sink.add(data);
        },
      ),
    );
  }

  Future<DPHttpResponse> delete(String path, {dynamic data}) async {
    Response dioResponse = await dio.delete(path, data: data);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Response dioResponse = await dio.post(path,
        data: data, queryParameters: queryParameters, options: options);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> patch(String path, {dynamic data}) async {
    Response dioResponse = await dio.patch(path, data: data);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> put(String path,
      {dynamic data, Options? options}) async {
    Response dioResponse = await dio.put(path, data: data, options: options);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }
}

abstract class SecureApiProvider extends ApiProvider {
  Future<String> encryptData(dynamic data) async {
    AuthService authService = Get.find<AuthService>();
    return await AesGcmEncryptor.encrypt(
        json.encode(data), authService.aes.key!);
  }

  @override
  Future<DPHttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    options ??= Options();
    options.headers ??= {};

    return await super
        .get(path, queryParameters: queryParameters, options: options);
  }

  @override
  Future<DPHttpResponse> delete(String path, {dynamic data}) async {
    return await super.delete(path, data: data);
  }

  @override
  Future<DPHttpResponse> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      bool encrypt = false}) async {
    options ??= Options();
    options.headers ??= {};

    if (encrypt) {
      options.headers!['content-type'] = 'application/octet-stream';
      data = await encryptData(data);
    }
    return await super.post(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  @override
  Future<DPHttpResponse> patch(String path, {dynamic data}) async {
    return await super.patch(path, data: data);
  }

  @override
  Future<DPHttpResponse> put(String path,
      {dynamic data, Options? options}) async {
    options ??= Options();
    options.headers ??= {};
    return await super.put(path, data: data, options: options);
  }
}
