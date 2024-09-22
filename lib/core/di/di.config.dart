// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:plants_app/core/api/my_dio.dart' as _i682;
import 'package:plants_app/core/di/register_module.dart' as _i70;
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
    gh.lazySingleton<_i682.MyDio>(() => registerModule.myDio);
    gh.lazySingleton<_i385.AuthRemoteDataSource>(
        () => _i385.AuthRemoteDataSource(gh<_i682.MyDio>()));
    gh.lazySingleton<_i652.AuthRepo>(
        () => _i11.AuthRepoRemote(gh<_i385.AuthRemoteDataSource>()));
    gh.factory<_i378.AuthCubit>(() => _i378.AuthCubit(gh<_i652.AuthRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i70.RegisterModule {}
