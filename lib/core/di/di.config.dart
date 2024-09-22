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
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart' as _i634;
import 'package:plants_app/core/di/register_module.dart' as _i70;
import 'package:plants_app/core/models/user_data.dart' as _i8;
import 'package:plants_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i385;
import 'package:plants_app/features/auth/data/repos/auth_repo_remote.dart'
    as _i11;
import 'package:plants_app/features/auth/domain/repos/auth_repo.dart' as _i652;
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i378;

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
    gh.singleton<_i8.UserData>(() => _i8.UserData());
    gh.lazySingleton<_i682.MyDio>(() => registerModule.myDio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModule.secureStorage);
    gh.lazySingleton<_i385.AuthRemoteDataSource>(
        () => _i385.AuthRemoteDataSource(gh<_i682.MyDio>()));
    gh.singleton<_i634.MainCubit>(
        () => _i634.MainCubit(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i652.AuthRepo>(
        () => _i11.AuthRepoRemote(gh<_i385.AuthRemoteDataSource>()));
    gh.factory<_i378.AuthCubit>(() => _i378.AuthCubit(
          gh<_i652.AuthRepo>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i70.RegisterModule {}
