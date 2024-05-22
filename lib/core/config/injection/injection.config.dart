// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i13;
import 'package:freebies_e_commerce/core/config/injection/register_module.dart'
    as _i32;
import 'package:freebies_e_commerce/core/config/router/app_router.dart' as _i4;
import 'package:freebies_e_commerce/core/di/core_module.dart' as _i33;
import 'package:freebies_e_commerce/core/network/network_info.dart' as _i11;
import 'package:freebies_e_commerce/features/auth/data/data_source/supabase_data_source.dart'
    as _i7;
import 'package:freebies_e_commerce/features/auth/data/repositories/auth_repository_impl.dart'
    as _i15;
import 'package:freebies_e_commerce/features/auth/domain/repositories/auth_repository.dart'
    as _i14;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/logout_use_case.dart'
    as _i19;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart'
    as _i20;
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_up_use_case.dart'
    as _i21;
import 'package:freebies_e_commerce/features/auth/presentation/bloc/login_bloc/login_bloc.dart'
    as _i29;
import 'package:freebies_e_commerce/features/auth/presentation/bloc/register_bloc/register_bloc.dart'
    as _i22;
import 'package:freebies_e_commerce/features/news/data/data_source/supabase_data_source.dart'
    as _i8;
import 'package:freebies_e_commerce/features/news/data/repositories/news_repository_impl.dart'
    as _i10;
import 'package:freebies_e_commerce/features/news/domain/repositories/news_repository.dart'
    as _i9;
import 'package:freebies_e_commerce/features/news/domain/use_cases/get_news_use_case.dart'
    as _i12;
import 'package:freebies_e_commerce/features/news/presentation/bloc/news_bloc.dart'
    as _i16;
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart'
    as _i6;
import 'package:freebies_e_commerce/features/products/data/repositories/product_repository_impl.dart'
    as _i18;
import 'package:freebies_e_commerce/features/products/domain/repositories/product_repository.dart'
    as _i17;
import 'package:freebies_e_commerce/features/products/domain/use_cases/delete_search_value_use_case.dart'
    as _i24;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_categories_use_case.dart'
    as _i23;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_products_use_case.dart'
    as _i25;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_search_value_use_case.dart'
    as _i27;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_sub_categories_use_case.dart'
    as _i28;
import 'package:freebies_e_commerce/features/products/domain/use_cases/set_search_value_use_case.dart'
    as _i26;
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
    gh.factory<_i9.NewsRepository>(
        () => _i10.NewsRepositoryImpl(gh<_i8.NewsDataSource>()));
    gh.factory<_i11.NetworkInfo>(
        () => _i11.NetworkInfoImpl(gh<_i5.InternetConnectionChecker>()));
    gh.factory<_i12.GetNewsUseCase>(
        () => _i12.GetNewsUseCase(repository: gh<_i9.NewsRepository>()));
    gh.lazySingleton<_i13.Dio>(
        () => registerModule.dio(gh<_i3.SharedPreferences>()));
    gh.factory<_i14.AuthRepository>(() => _i15.AuthRepositoryImpl(
          gh<_i7.AuthDataSource>(),
          gh<_i11.NetworkInfo>(),
        ));
    gh.factory<_i16.NewsBloc>(
        () => _i16.NewsBloc(getNewsUseCase: gh<_i12.GetNewsUseCase>()));
    gh.factory<_i17.ProductRepository>(
        () => _i18.ProductRepositoryImpl(gh<_i6.ProductDataSource>()));
    gh.factory<_i19.LogOutUseCase>(
        () => _i19.LogOutUseCase(repository: gh<_i14.AuthRepository>()));
    gh.factory<_i20.SignInUseCase>(
        () => _i20.SignInUseCase(repository: gh<_i14.AuthRepository>()));
    gh.factory<_i21.SignUpUseCase>(
        () => _i21.SignUpUseCase(repository: gh<_i14.AuthRepository>()));
    gh.factory<_i22.RegisterBloc>(
        () => _i22.RegisterBloc(signUpUseCase: gh<_i21.SignUpUseCase>()));
    gh.factory<_i23.GetCategoriesUseCase>(() =>
        _i23.GetCategoriesUseCase(repository: gh<_i17.ProductRepository>()));
    gh.factory<_i24.DeleteSearchValueUseCase>(() =>
        _i24.DeleteSearchValueUseCase(
            repository: gh<_i17.ProductRepository>()));
    gh.factory<_i25.GetProductsUseCase>(() =>
        _i25.GetProductsUseCase(repository: gh<_i17.ProductRepository>()));
    gh.factory<_i26.SetSearchValueUseCase>(() =>
        _i26.SetSearchValueUseCase(repository: gh<_i17.ProductRepository>()));
    gh.factory<_i27.GetSearchValueUseCase>(() =>
        _i27.GetSearchValueUseCase(repository: gh<_i17.ProductRepository>()));
    gh.factory<_i28.GetSubCategoriesUseCase>(() =>
        _i28.GetSubCategoriesUseCase(repository: gh<_i17.ProductRepository>()));
    gh.factory<_i29.LoginBloc>(
        () => _i29.LoginBloc(signInUseCase: gh<_i20.SignInUseCase>()));
    gh.factory<_i30.ProductBloc>(() => _i30.ProductBloc(
          getProductsUseCase: gh<_i25.GetProductsUseCase>(),
          getCategoriesUseCase: gh<_i23.GetCategoriesUseCase>(),
          getSubCategoriesUseCase: gh<_i28.GetSubCategoriesUseCase>(),
        ));
    gh.factory<_i31.SearchBloc>(() => _i31.SearchBloc(
          getSearchValueUseCase: gh<_i27.GetSearchValueUseCase>(),
          getProductsUseCase: gh<_i25.GetProductsUseCase>(),
          deleteSearchValueUseCase: gh<_i24.DeleteSearchValueUseCase>(),
          setSearchValueUseCase: gh<_i26.SetSearchValueUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i32.RegisterModule {}

class _$CoreModule extends _i33.CoreModule {}
