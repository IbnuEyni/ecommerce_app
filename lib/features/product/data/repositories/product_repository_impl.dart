import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import '../../../../core/error/exception.dart';
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
  Future<Either<Failure, Product>> createProduct(int id, String name,
      String description, String imageUrl, int price) async {
    return await _getResponse(() {
      return remoteDataSource.createProduct(
          id, name, description, imageUrl, price);
    });
  }

  @override
  Future<Either<Failure, Product>> detailProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.detailProduct(id);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await localDataSource.getLastProduct();
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(int id, String name,
      String description, String imageUrl, int price) async {
    return await _getResponse(() {
      return remoteDataSource.updateProduct(
          id, name, description, imageUrl, price);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.deleteProduct(id);
        localDataSource.cacheProduct(remoteProduct);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, Product>> _getResponse(
      Future<Product> Function() getMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await getMethod();
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
