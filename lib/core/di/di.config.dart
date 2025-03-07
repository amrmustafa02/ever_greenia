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
import 'package:plants_app/features/orders/data/data_source/orders_remote_data_source.dart'
    as _i506;
import 'package:plants_app/features/orders/data/repo/orders_repo_impl.dart'
    as _i749;
import 'package:plants_app/features/orders/domain/repo/orders_repo.dart'
    as _i974;
import 'package:plants_app/features/orders/presentation/cubit/orders_cubit.dart'
    as _i344;
import 'package:plants_app/features/place_order/data/data_sources/place_order_remote_data_source.dart'
    as _i572;
import 'package:plants_app/features/place_order/data/repo/place_order_repo_impl.dart'
    as _i683;
import 'package:plants_app/features/place_order/domain/repo/place_order_repo.dart'
    as _i545;
import 'package:plants_app/features/place_order/presentation/cubit/place_order_cubit.dart'
    as _i302;
import 'package:plants_app/features/product_details/presentation/cubit/product_details_cubit.dart'
    as _i229;
import 'package:plants_app/features/profile/data/data_sources/profile_remote_data_source.dart'
    as _i842;
import 'package:plants_app/features/profile/data/repos/profile_repo_impl.dart'
    as _i872;
import 'package:plants_app/features/profile/domain/repos/profile_repo.dart'
    as _i96;
import 'package:plants_app/features/profile/presentation/cubit/profile_cubit.dart'
    as _i369;

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
    gh.lazySingleton<_i842.ProfileRemoteDataSource>(
        () => _i842.ProfileRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i385.AuthRemoteDataSource>(
        () => _i385.AuthRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i506.OrdersRemoteDataSource>(
        () => _i506.OrdersRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i572.PlaceOrderRemoteDataSource>(
        () => _i572.PlaceOrderRemoteDataSource(gh<_i682.MyDio>()));
    gh.singleton<_i94.HomeRemoteDataSource>(
        () => _i94.HomeRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i424.CartRepo>(
        () => _i1056.CartRepoImpl(gh<_i874.CartRemoteDataSource>()));
    gh.lazySingleton<_i96.ProfileRepo>(
        () => _i872.ProfileRepoImpl(gh<_i842.ProfileRemoteDataSource>()));
    gh.singleton<_i634.MainCubit>(
        () => _i634.MainCubit(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i548.CartCubit>(() => _i548.CartCubit(gh<_i424.CartRepo>()));
    gh.factory<_i229.ProductDetailsCubit>(
        () => _i229.ProductDetailsCubit(gh<_i424.CartRepo>()));
    gh.lazySingleton<_i652.AuthRepo>(
        () => _i11.AuthRepoRemote(gh<_i385.AuthRemoteDataSource>()));
    gh.lazySingleton<_i974.OrdersRepo>(
        () => _i749.OrderRepoImpl(gh<_i506.OrdersRemoteDataSource>()));
    gh.factory<_i378.AuthCubit>(() => _i378.AuthCubit(
          gh<_i652.AuthRepo>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.singleton<_i140.HomeRepo>(
        () => _i1010.HomeRepoImpl(gh<_i94.HomeRemoteDataSource>()));
    gh.factory<_i369.ProfileCubit>(
        () => _i369.ProfileCubit(gh<_i96.ProfileRepo>()));
    gh.lazySingleton<_i545.PlaceOrderRepo>(
        () => _i683.PlaceOrderRepoImpl(gh<_i572.PlaceOrderRemoteDataSource>()));
    gh.factory<_i1062.HomeCubit>(() => _i1062.HomeCubit(gh<_i140.HomeRepo>()));
    gh.factory<_i302.PlaceOrderCubit>(
        () => _i302.PlaceOrderCubit(gh<_i545.PlaceOrderRepo>()));
    gh.factory<_i344.OrdersCubit>(
        () => _i344.OrdersCubit(gh<_i974.OrdersRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i70.RegisterModule {}
