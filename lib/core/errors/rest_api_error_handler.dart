import 'package:dio/dio.dart';

class RestApiErrorHandler {
  final String errorMessage;
  final int? statusCode;

  RestApiErrorHandler._(this.errorMessage, this.statusCode);

  factory RestApiErrorHandler.handleError(DioException dioError) {
    String errorMessage;
    int? statusCode;

    if (dioError.response != null) {
      statusCode = dioError.response?.statusCode;

      errorMessage = dioError.response?.data['messageError'] ??
          _getDefaultMessage(statusCode);
    } else {
      errorMessage = _handleDioErrorType(dioError.type);
      statusCode = null;
    }

    return RestApiErrorHandler._(errorMessage, statusCode);
  }

  static String _getDefaultMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request. Please check your input.';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden. You do not have access to this resource.';
      case 404:
        return 'Not Found. The requested resource could not be found.';
      case 500:
        return 'Internal Server Error. Please try again later.';
      case 502:
        return 'Bad Gateway. There seems to be an issue with the server.';
      case 503:
        return 'Service Unavailable. Please try again later.';
      default:
        return 'An unknown error occurred.';
    }
  }

  // Helper method to handle different DioError types
  static String _handleDioErrorType(DioExceptionType errorType) {
    switch (errorType) {
      case DioExceptionType.cancel:
        return 'Request to the server was cancelled.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with the server.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with the server.';
      case DioExceptionType.unknown:
        return 'An unknown error occurred. Please try again later.';
      case DioExceptionType.connectionError:
        return 'An unexpected error occurred. Please check your internet connection.';
      default:
        return 'An unknown error occurred.';
    }
  }
}
