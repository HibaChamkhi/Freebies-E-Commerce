// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:freebies_e_commerce/core/config/injection/register_module.dart'
    as _i20;
import 'package:freebies_e_commerce/core/config/router/app_router.dart' as _i4;
import 'package:freebies_e_commerce/features/auth/data/data_source/supabase_data_source.dart'
    as _i6;
import 'package:freebies_e_commerce/features/auth/data/repositories/auth_repository_impl.dart'
    as _i9;
import 'package:freebies_e_commerce/features/auth/domain/repositories/auth_repository.dart'
    as _i8;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/logout_use_case.dart'
    as _i12;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart'
    as _i13;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_up_use_case.dart'
    as _i14;
import 'package:freebies_e_commerce/features/auth/presentation/bloc/login_bloc/login_bloc.dart'
    as _i19;
import 'package:freebies_e_commerce/features/auth/presentation/bloc/register_bloc/register_bloc.dart'
    as _i15;
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart'
    as _i5;
import 'package:freebies_e_commerce/features/products/data/repositories/product_repository_impl.dart'
    as _i11;
import 'package:freebies_e_commerce/features/products/domain/repositories/product_repository.dart'
    as _i10;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_categories_use_case.dart'
    as _i16;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_products_use_case.dart'
    as _i17;
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart'
    as _i18;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.factory<_i5.ProductDataSource>(() => _i5.RemoteDataSourceImpl());
    gh.factory<_i6.AuthDataSource>(() => _i6.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i7.Dio>(
        () => registerModule.dio(gh<_i3.SharedPreferences>()));
    gh.factory<_i8.AuthRepository>(
        () => _i9.AuthRepositoryImpl(gh<_i6.AuthDataSource>()));
    gh.factory<_i10.ProductRepository>(
        () => _i11.ProductRepositoryImpl(gh<_i5.ProductDataSource>()));
    gh.factory<_i12.LogOutUseCase>(
        () => _i12.LogOutUseCase(repository: gh<_i8.AuthRepository>()));
    gh.factory<_i13.SignInUseCase>(
        () => _i13.SignInUseCase(repository: gh<_i8.AuthRepository>()));
    gh.factory<_i14.SignUpUseCase>(
        () => _i14.SignUpUseCase(repository: gh<_i8.AuthRepository>()));
    gh.factory<_i15.RegisterBloc>(
        () => _i15.RegisterBloc(signUpUseCase: gh<_i14.SignUpUseCase>()));
    gh.factory<_i16.GetCategoriesUseCase>(() =>
        _i16.GetCategoriesUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i17.GetProductsUseCase>(() =>
        _i17.GetProductsUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i18.ProductBloc>(() => _i18.ProductBloc(
          getProductsUseCase: gh<_i17.GetProductsUseCase>(),
          getCategoriesUseCase: gh<_i16.GetCategoriesUseCase>(),
        ));
    gh.factory<_i19.LoginBloc>(
        () => _i19.LoginBloc(signInUseCase: gh<_i13.SignInUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i20.RegisterModule {}
