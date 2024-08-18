import 'core/network/network_info.dart';
import 'features/product/data/data_sources/product_local_data_source.dart';
import 'features/product/data/data_sources/product_remote_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/util/input_converter.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/detail_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/create_bloc/create_bloc.dart';
import 'features/product/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
import 'features/product/presentation/bloc/list_products/list_products_bloc.dart';
import 'features/product/presentation/bloc/update_bloc/update_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product
  // Bloc
  sl.registerFactory(() => ListProductsBloc(sl()));
  sl.registerFactory(() => CreateBloc(sl(), sl()));
  sl.registerFactory(() => UpdateBloc(sl(), sl()));
  sl.registerFactory(() => DeleteBloc(sl()));
  sl.registerFactory(() => DetailBloc(detailProduct: sl()));

  // Use cases
  sl.registerLazySingleton(() => ListProducts(repository: sl()));
  sl.registerLazySingleton(() => CreateProduct(repository: sl()));
  sl.registerLazySingleton(() => UpdateProduct(repository: sl()));
  sl.registerLazySingleton(() => DeleteProduct(repository: sl()));
  sl.registerLazySingleton(() => DetailProduct(repository: sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter(sl()));
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkinfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
