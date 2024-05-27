import 'package:freebies_e_commerce/core/network/network_info.dart';
import 'package:freebies_e_commerce/features/auth/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:freebies_e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:freebies_e_commerce/features/news/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/news/data/repositories/news_repository_impl.dart';
import 'package:freebies_e_commerce/features/news/domain/repositories/news_repository.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/data/repositories/product_repository_impl.dart';
import 'package:freebies_e_commerce/features/products/domain/repositories/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  AuthDataSource,
  AuthRepositoryImpl,
  AuthRepository,
  NetworkInfo,
  SignInUseCase,
  SignUpUseCase,
  NewsDataSource,
  NewsRepositoryImpl,
  NewsRepository,
  ProductDataSource,
  ProductRepositoryImpl,
  ProductRepository,LogOutUseCase
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
