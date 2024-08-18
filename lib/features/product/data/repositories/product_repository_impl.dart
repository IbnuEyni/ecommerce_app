import 'package:dartz/dartz.dart';
import '../models/product_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';

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
  Future<Either<Failure, Product>> createProduct(String id, String name,
      String description, String imageUrl, double price) async {
    return await _getResponse(() {
      return remoteDataSource.createProduct(
          id, name, description, imageUrl, price);
    });
  }

  @override
  Future<Either<Failure, Product>> detailProduct(String id) async {
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
  Future<Either<Failure, Product>> updateProduct(String id, String name,
      String description, String imageUrl, double price) async {
    return await _getResponse(() {
      return remoteDataSource.updateProduct(
          id, name, description, imageUrl, price);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> listProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.listProducts();
        localDataSource.cacheProducts(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return Right(cachedProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, Product>> _getResponse(
      Future<Product> Function() getMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await getMethod();
        final remoteProductModel = convertProductToProductModel(remoteProduct);
        localDataSource.cacheProduct(remoteProductModel);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

ProductModel convertProductToProductModel(Product product) {
  return ProductModel(
    id: product.id,
    name: product.name,
    description: product.description,
    imageUrl: product.imageUrl,
    price: product.price,
  );
}

Product convertProductModelToProduct(ProductModel productModel) {
  return Product(
    id: productModel.id,
    name: productModel.name,
    description: productModel.description,
    imageUrl: productModel.imageUrl,
    price: productModel.price,
  );
}

// List<ProductModel> convertProductsToProductModels(List<Product> products) {
//   return products
//       .map((product) => ProductModel(
//             id: product.id,
//             name: product.name,
//             description: product.description,
//             imageUrl: product.imageUrl,
//             price: product.price,
//           ))
//       .toList();
// }
