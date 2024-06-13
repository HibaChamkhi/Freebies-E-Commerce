// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:freebies_e_commerce/core/config/injection/register_module.dart'
    as _i32;
import 'package:freebies_e_commerce/core/config/router/app_router.dart' as _i4;
import 'package:freebies_e_commerce/core/di/core_module.dart' as _i33;
import 'package:freebies_e_commerce/core/network/network_info.dart' as _i9;
import 'package:freebies_e_commerce/features/auth/data/data_source/supabase_data_source.dart'
    as _i7;
import 'package:freebies_e_commerce/features/auth/data/repositories/auth_repository_impl.dart'
    as _i14;
import 'package:freebies_e_commerce/features/auth/domain/repositories/auth_repository.dart'
    as _i13;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/logout_use_case.dart'
    as _i17;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart'
    as _i18;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_up_use_case.dart'
    as _i19;
import 'package:freebies_e_commerce/features/auth/presentation/bloc/login_bloc/login_bloc.dart'
    as _i28;
import 'package:freebies_e_commerce/features/auth/presentation/bloc/register_bloc/register_bloc.dart'
    as _i20;
import 'package:freebies_e_commerce/features/news/data/data_source/supabase_data_source.dart'
    as _i8;
import 'package:freebies_e_commerce/features/news/data/repositories/news_repository_impl.dart'
    as _i16;
import 'package:freebies_e_commerce/features/news/domain/repositories/news_repository.dart'
    as _i15;
import 'package:freebies_e_commerce/features/news/domain/use_cases/get_news_use_case.dart'
    as _i21;
import 'package:freebies_e_commerce/features/news/presentation/bloc/news_bloc.dart'
    as _i29;
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart'
    as _i6;
import 'package:freebies_e_commerce/features/products/data/repositories/product_repository_impl.dart'
    as _i11;
import 'package:freebies_e_commerce/features/products/domain/repositories/product_repository.dart'
    as _i10;
import 'package:freebies_e_commerce/features/products/domain/use_cases/delete_search_value_use_case.dart'
    as _i23;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_categories_use_case.dart'
    as _i22;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_products_use_case.dart'
    as _i24;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_search_value_use_case.dart'
    as _i26;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_sub_categories_use_case.dart'
    as _i27;
import 'package:freebies_e_commerce/features/products/domain/use_cases/set_search_value_use_case.dart'
    as _i25;
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart'
    as _i30;
import 'package:freebies_e_commerce/features/products/presentation/bloc/search/search_bloc.dart'
    as _i31;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
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
    final coreModule = _$CoreModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.lazySingleton<_i5.InternetConnectionChecker>(
        () => coreModule.dataConnectionChecker);
    gh.factory<_i6.ProductDataSource>(() => _i6.RemoteDataSourceImpl());
    gh.factory<_i7.AuthDataSource>(() => _i7.AuthRemoteDataSourceImpl());
    gh.factory<_i8.NewsDataSource>(() => _i8.NewsRemoteDataSourceImpl());
    gh.factory<_i9.NetworkInfo>(
        () => _i9.NetworkInfoImpl(gh<_i5.InternetConnectionChecker>()));
    gh.factory<_i10.ProductRepository>(() => _i11.ProductRepositoryImpl(
          gh<_i6.ProductDataSource>(),
          gh<_i9.NetworkInfo>(),
        ));
    gh.lazySingleton<_i12.Dio>(
        () => registerModule.dio(gh<_i3.SharedPreferences>()));
    gh.factory<_i13.AuthRepository>(() => _i14.AuthRepositoryImpl(
          gh<_i7.AuthDataSource>(),
          gh<_i9.NetworkInfo>(),
        ));
    gh.factory<_i15.NewsRepository>(() => _i16.NewsRepositoryImpl(
          gh<_i8.NewsDataSource>(),
          gh<_i9.NetworkInfo>(),
        ));
    gh.factory<_i17.LogOutUseCase>(
        () => _i17.LogOutUseCase(repository: gh<_i13.AuthRepository>()));
    gh.factory<_i18.SignInUseCase>(
        () => _i18.SignInUseCase(repository: gh<_i13.AuthRepository>()));
    gh.factory<_i19.SignUpUseCase>(
        () => _i19.SignUpUseCase(repository: gh<_i13.AuthRepository>()));
    gh.factory<_i20.RegisterBloc>(
        () => _i20.RegisterBloc(signUpUseCase: gh<_i19.SignUpUseCase>()));
    gh.factory<_i21.GetNewsUseCase>(
        () => _i21.GetNewsUseCase(repository: gh<_i15.NewsRepository>()));
    gh.factory<_i22.GetCategoriesUseCase>(() =>
        _i22.GetCategoriesUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i23.DeleteSearchValueUseCase>(() =>
        _i23.DeleteSearchValueUseCase(
            repository: gh<_i10.ProductRepository>()));
    gh.factory<_i24.GetProductsUseCase>(() =>
        _i24.GetProductsUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i25.SetSearchValueUseCase>(() =>
        _i25.SetSearchValueUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i26.GetSearchValueUseCase>(() =>
        _i26.GetSearchValueUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i27.GetSubCategoriesUseCase>(() =>
        _i27.GetSubCategoriesUseCase(repository: gh<_i10.ProductRepository>()));
    gh.factory<_i28.LoginBloc>(() => _i28.LoginBloc(
          signInUseCase: gh<_i18.SignInUseCase>(),
          logOutUseCase: gh<_i17.LogOutUseCase>(),
        ));
    gh.factory<_i29.NewsBloc>(
        () => _i29.NewsBloc(getNewsUseCase: gh<_i21.GetNewsUseCase>()));
    gh.factory<_i30.ProductBloc>(() => _i30.ProductBloc(
          getProductsUseCase: gh<_i24.GetProductsUseCase>(),
          getCategoriesUseCase: gh<_i22.GetCategoriesUseCase>(),
          getSubCategoriesUseCase: gh<_i27.GetSubCategoriesUseCase>(),
        ));
    gh.factory<_i31.SearchBloc>(() => _i31.SearchBloc(
          getSearchValueUseCase: gh<_i26.GetSearchValueUseCase>(),
          getProductsUseCase: gh<_i24.GetProductsUseCase>(),
          deleteSearchValueUseCase: gh<_i23.DeleteSearchValueUseCase>(),
          setSearchValueUseCase: gh<_i25.SetSearchValueUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i32.RegisterModule {}

class _$CoreModule extends _i33.CoreModule {}
