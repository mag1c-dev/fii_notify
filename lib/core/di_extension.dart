
import 'dart:io';

import 'package:dio/dio.dart';

extension DioExtension on DioError {
  String getDioMessage() {
    var message = '';
    switch (type) {
      case DioErrorType.connectTimeout:
        message = 'Failure connect to server.';
        break;
      case DioErrorType.sendTimeout:
        message = 'Send data to server timeout.';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Receive data from server timeout.';
        break;
      case DioErrorType.response:
        message = 'Receive error from server.';
        try {
          final result = response?.data as Map<String, dynamic>;
          message =
              (result['error_description'] ?? result['message'] ?? message)
                  .toString();
        } catch (_) {}
        break;
      case DioErrorType.cancel:
        message = 'Request was cancel.';
        break;
      case DioErrorType.other:
        message = 'Unknown error. ${error.toString()}';
        if (error is SocketException) {
          message = 'No network connect.';
        }
        break;
    }
    return message;
  }
}
