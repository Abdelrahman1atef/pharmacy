import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pharmacy/core/network/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfig {
  DioConfig._();
  static Dio? _dio;
  static const timeout = Duration(milliseconds: 50000);


  static Dio getDio() {
    _dio ??= Dio()
      ..options.baseUrl = Constant.baseUrl
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..options.contentType = ContentType.json.toString()
      ..options.responseType = ResponseType.json
      ..options.validateStatus = (status) {
        return status! < 500; // Accept all status codes below 500
      }
      ..interceptors.addAll([
        // Logging Interceptor
        PrettyDioLogger(
          requestBody: true,
          responseBody: false,
          error: true,
        ),
        // Retry Interceptor
        InterceptorsWrapper(
          onError: (DioException e, ErrorInterceptorHandler handler) async {
            int retries = e.requestOptions.extra['retries'] ?? 3;
            if (retries > 0) {
              e.requestOptions.extra['retries'] = retries - 1;
              await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
              handler.resolve(await _dio!.fetch(e.requestOptions));// Retry the request
            } else {
              handler.next(e); // Pass the error if max retries reached
            }
          },
        ),
      ]);

    return _dio!;
  }

}
