import 'package:plants_app/core/errors/rest_api_error_handler.dart';

sealed class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success({required T data}) => SuccessRequest(data: data);

  factory ApiResult.failure({required RestApiErrorHandler error}) =>
      FailureRequest(exception: error);
}

class SuccessRequest<T> extends ApiResult<T> {
  final T data;

  const SuccessRequest({required this.data});
}

class FailureRequest<T> extends ApiResult<T> {
  final RestApiErrorHandler exception;

  const FailureRequest({required this.exception});
}
