// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:plants_app/core/api/my_dio.dart' as _i682;
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart' as _i548;
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart' as _i634;
import 'package:plants_app/core/data_sources/cart_remote_data_source.dart'
    as _i874;
import 'package:plants_app/core/di/register_module.dart' as _i70;
import 'package:plants_app/core/entities/user_data.dart' as _i1068;
import 'package:plants_app/core/repos/cart_repo.dart' as _i424;
import 'package:plants_app/core/repos/cart_repo_impl.dart' as _i1056;
import 'package:plants_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i385;
import 'package:plants_app/features/auth/data/repos/auth_repo_remote.dart'
    as _i11;
import 'package:plants_app/features/auth/domain/repos/auth_repo.dart' as _i652;
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i378;
import 'package:plants_app/features/home/data/data_sources/home_remote_data_source.dart'
    as _i94;
import 'package:plants_app/features/home/data/repos/home_repo_impl.dart'
    as _i1010;
import 'package:plants_app/features/home/domain/repos/home_repo.dart' as _i140;
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart'
    as _i1062;
import 'package:plants_app/features/product_details/presentation/cubit/product_details_cubit.dart'
    as _i229;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i1068.UserData>(() => _i1068.UserData());
    gh.lazySingleton<_i682.MyDio>(() => registerModule.myDio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModule.secureStorage);
    gh.lazySingleton<_i874.CartRemoteDataSource>(
        () => _i874.CartRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i385.AuthRemoteDataSource>(
        () => _i385.AuthRemoteDataSource(gh<_i682.MyDio>()));
    gh.singleton<_i94.HomeRemoteDataSource>(
        () => _i94.HomeRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i424.CartRepo>(
        () => _i1056.CartRepoImpl(gh<_i874.CartRemoteDataSource>()));
    gh.singleton<_i634.MainCubit>(
        () => _i634.MainCubit(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i548.CartCubit>(() => _i548.CartCubit(gh<_i424.CartRepo>()));
    gh.factory<_i229.ProductDetailsCubit>(
        () => _i229.ProductDetailsCubit(gh<_i424.CartRepo>()));
    gh.lazySingleton<_i652.AuthRepo>(
        () => _i11.AuthRepoRemote(gh<_i385.AuthRemoteDataSource>()));
    gh.factory<_i378.AuthCubit>(() => _i378.AuthCubit(
          gh<_i652.AuthRepo>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.singleton<_i140.HomeRepo>(
        () => _i1010.HomeRepoImpl(gh<_i94.HomeRemoteDataSource>()));
    gh.factory<_i1062.HomeCubit>(() => _i1062.HomeCubit(gh<_i140.HomeRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i70.RegisterModule {}
