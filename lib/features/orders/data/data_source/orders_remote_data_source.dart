import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/endpoints.dart';
import 'package:plants_app/core/api/my_dio.dart';
import 'package:plants_app/features/orders/data/models/orders_model.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/errors/rest_api_error_handler.dart';

@lazySingleton
class OrdersRemoteDataSource {
  final MyDio _dio;

  OrdersRemoteDataSource(this._dio);

  Future<GetOrdersModel> getOrders() async {
    try {
      final response = await _dio.get(
        Endpoints.order,
      );
      return GetOrdersModel.fromJson(response.data);
    } on DioException catch (e) {
      throw FailedRequest(exception: RestApiErrorHandler.handleError(e));
    }
  }
}
