import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> createProduct(
    int id,
    String name,
    String description,
    String imageUrl,
    int price,
  );
  Future<Either<Failure, Product>> detailProduct(
    int id,
  );
  Future<Either<Failure, Product>> updateProduct(
    int id,
    String name,
    String description,
    String imageUrl,
    int price,
  );
  Future<Either<Failure, Unit>> deleteProduct(
    int id,
  );
  Future<Either<Failure, List<Product>>> listProducts();
}
