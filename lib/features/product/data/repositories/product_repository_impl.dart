import 'package:dartz/dartz.dart';
import '../../../../core/platform/network_info.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

import '../../../../core/error/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> createProduct(
      int id, String name, String description, String imageUrl, int price) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> detailProduct(int id) {
    // TODO: implement detailProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
      int id, String name, String description, String imageUrl, int price) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
