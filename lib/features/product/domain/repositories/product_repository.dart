import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> createProduct(
    String id,
    String name,
    String description,
    String imageUrl,
    double price,
  );
  Future<Either<Failure, Product>> detailProduct(
    String id,
  );
  Future<Either<Failure, Product>> updateProduct(
    String id,
    String name,
    String description,
    String imageUrl,
    double price,
  );
  Future<Either<Failure, Unit>> deleteProduct(
    String id,
  );
  Future<Either<Failure, List<Product>>> listProducts();
}
