import 'package:ecommerce_app/features/auth/data/data_sources/local_data_sources.dart';
import 'package:ecommerce_app/features/auth/data/data_sources/remote_data_resources.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/me_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/logout_bloc/bloc/logout_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/me_bloc/me_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/product/data/data_sources/product_local_data_source.dart';
import 'features/product/data/data_sources/product_remote_data_source.dart';
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

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product
  // Bloc
  sl.registerFactory(() => ListProductsBloc(sl()));
  sl.registerFactory(() => CreateBloc(sl(), sl()));
  sl.registerFactory(() => UpdateBloc(sl(), sl()));
  sl.registerFactory(() => DeleteBloc(sl()));
  sl.registerFactory(() => DetailBloc(detailProduct: sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignupBloc(signUpUseCase: sl()));
  sl.registerFactory(() => LogoutBloc(sl()));
  sl.registerFactory(() => MeBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => ListProducts(repository: sl()));
  sl.registerLazySingleton(() => CreateProduct(repository: sl()));
  sl.registerLazySingleton(() => UpdateProduct(repository: sl()));
  sl.registerLazySingleton(() => DeleteProduct(repository: sl()));
  sl.registerLazySingleton(() => DetailProduct(repository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => MeUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  //! Core
  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkinfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
