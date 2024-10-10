import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/api/endpoints.dart';
import 'package:plants_app/core/api/my_dio.dart';
import 'package:plants_app/core/errors/rest_api_error_handler.dart';
import 'package:plants_app/features/home/data/models/get_categories_response_body.dart';
import 'package:plants_app/features/home/data/models/get_products_reponse_body.dart';
import 'package:plants_app/features/home/data/models/search_request_body_model.dart';

@singleton
class HomeRemoteDataSource {
  final MyDio _dio;

  HomeRemoteDataSource(this._dio);

  Future<GetCategoriesResponseBody> getCategories() async {
    try {
      var response = await _dio.get(Endpoints.getCategories);
      return GetCategoriesResponseBody.fromJson(response.data);
    } on DioException catch (e) {
      throw FailureRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<GetProductsResponseBody> getProducts() async {
    try {
      var response = await _dio.get(Endpoints.getProducts);
      return GetProductsResponseBody.fromJson(response.data);
    } on DioException catch (e) {
      throw FailureRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<SearchRequestBody> search(String query) async {
    try {
      var response = await _dio.get(Endpoints.search, queryParameters: {
        'keyword': query,
      });
      return SearchRequestBody.fromJson(response.data);
    } on DioException catch (e) {
      throw FailureRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }
}
