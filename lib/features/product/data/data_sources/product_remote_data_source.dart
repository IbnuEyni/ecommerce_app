import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Calls the endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> createProduct(
    int id,
    String name,
    String description,
    String imageUrl,
    int price,
  );

  /// Calls the endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> detailProduct(
    int id,
  );

  /// Calls the endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> updateProduct(
    int id,
    String name,
    String description,
    String imageUrl,
    int price,
  );

  /// Calls the endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> deleteProduct(
    int id,
  );
}
