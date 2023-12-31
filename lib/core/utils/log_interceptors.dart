// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';

import 'logger.dart';

class LogInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    logger.log(
      '\n\n--------------------------------------------------------------------------------------------------------',
    );
    if (method == 'GET') {
      logger.log(
        '✈️ REQUEST[$method] => PATH: $uri \n Header: ${options.headers}',
        printFullText: true,
      );
    } else {
      try {
        logger.log(
          '✈️ REQUEST[$method] => PATH: $uri \n Header: ${options.headers} '
          '\n DATA: ${jsonEncode(data)}',
          printFullText: true,
        );
      } catch (e) {
        logger.log(
          '✈️ REQUEST[$method] => PATH: $uri \n Header: ${options.headers} '
          '\n DATA: $data',
          printFullText: true,
        );
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    logger.log('✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.path;
    var data = '';
    try {
      data = jsonEncode(err.response?.data);
    } catch (e) {}
    logger.log('⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data');
    super.onError(err, handler);
  }
}
