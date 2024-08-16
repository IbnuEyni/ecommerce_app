import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/detail_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/create_bloc/create_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/list_products/list_products_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/update_bloc/update_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
@InjectableInit()
void configureDependencies() {
  // Initialize the external libraries and core services
  sl.registerLazySingleton(() => sl<Client>());
  sl.registerLazySingleton(() => sl<SharedPreferences>());
  sl.registerLazySingleton(() => sl<NetworkInfo>());
  sl.registerLazySingleton(() => sl<InternetConnectionChecker>());
  sl.registerLazySingleton(() => sl<InputConverter>());

  // Data sources
  sl.registerLazySingleton(() => sl<ProductRemoteDataSource>());
  sl.registerLazySingleton(() => sl<ProductLocalDataSource>());

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => sl<ProductRepository>());

  // Blocs
  sl.registerFactory(
      () => DetailBloc(inputConverter: sl(), detailProduct: sl()));
  sl.registerFactory(() => CreateBloc(sl(), sl()));
  sl.registerFactory(() => UpdateBloc(sl(), sl()));
  sl.registerFactory(() => DeleteBloc(sl(), sl()));
  sl.registerFactory(() => ListProductsBloc(sl()));

  //use cases
  sl.registerLazySingleton<ListProducts>(() => ListProducts(repository: sl()));
  sl.registerLazySingleton<CreateProduct>(
      () => CreateProduct(repository: sl()));
  sl.registerLazySingleton<UpdateProduct>(
      () => UpdateProduct(repository: sl()));
  sl.registerLazySingleton<DeleteProduct>(
      () => DeleteProduct(repository: sl()));
  sl.registerLazySingleton<DetailProduct>(
      () => DetailProduct(repository: sl()));
}

abstract class RegisterModule {
  // External Libraries
  @lazySingleton
  Client get httpClient => Client();

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
  // Core
  @lazySingleton
  InputConverter get inputConverter => InputConverter(sl());

  @lazySingleton
  NetworkInfo get networkInfo => NetworkinfoImpl(connectionChecker: sl());
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();

  // Data Sources
  @lazySingleton
  ProductRemoteDataSource get productRemoteDataSource =>
      ProductRemoteDataSourceImpl(client: sl());

  @lazySingleton
  ProductLocalDataSource get productLocalDataSource =>
      ProductLocalDataSourceImpl(sharedPreferences: sl());

  // Repository
  @lazySingleton
  ProductRepository get productRepository => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      );
}
