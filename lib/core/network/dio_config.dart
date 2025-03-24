import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pharmacy/core/network/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfig {
  DioConfig._();

  static const timeout = Duration(milliseconds: 5000);
  static Dio? _dio;

  static Dio getDio() {
    _dio ??= Dio()
      ..options.baseUrl = Constant.baseUrl
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..options.contentType = ContentType.json.toString()
      ..options.responseType = ResponseType.json
      ..interceptors.add(
          PrettyDioLogger(requestBody: true, responseBody: true, error: true));
    return _dio!;
  }
}
