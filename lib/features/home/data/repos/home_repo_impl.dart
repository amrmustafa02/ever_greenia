import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/features/home/domain/repos/home_repo.dart';

@Singleton(as: HomeRepo)
class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepoImpl(this.homeRemoteDataSource);

  @override
  Future<ApiResult<List<CategoryData>>> getCategories() async {
    try {
      var response = await homeRemoteDataSource.getCategories();
      return SuccessRequest<List<CategoryData>>(
        data: response.data!
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
      );
    } on FailedRequest catch (e) {
      return FailedRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<List<ProductData>>> getProducts() async {
    try {
      var response = await homeRemoteDataSource.getProducts();
      return SuccessRequest<List<ProductData>>(
        data: response.data
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
      );
    } on FailedRequest catch (e) {
      return FailedRequest(exception: e.exception);
    }
  }
}
