// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:freebies_e_commerce/core/config/injection/register_module.dart'
    as _i11;
import 'package:freebies_e_commerce/core/config/router/app_router.dart' as _i4;
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart'
    as _i5;
import 'package:freebies_e_commerce/features/products/data/repositories/product_repository_impl.dart'
    as _i8;
import 'package:freebies_e_commerce/features/products/domain/repositories/product_repository.dart'
    as _i7;
import 'package:freebies_e_commerce/features/products/domain/use_cases/get_products_use_case.dart'
    as _i9;
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart'
    as _i10;
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
    gh.lazySingleton<_i6.Dio>(
        () => registerModule.dio(gh<_i3.SharedPreferences>()));
    gh.factory<_i7.ProductRepository>(
        () => _i8.ProductRepositoryImpl(gh<_i5.ProductDataSource>()));
    gh.factory<_i9.GetProductsUseCase>(
        () => _i9.GetProductsUseCase(repository: gh<_i7.ProductRepository>()));
    gh.factory<_i10.ProductBloc>(() =>
        _i10.ProductBloc(getProductsUseCase: gh<_i9.GetProductsUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i11.RegisterModule {}
