import '../models/product_model.dart';
import 'package:http/http.dart' as http;

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

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> createProduct(
      int id, String name, String description, String imageUrl, int price) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> detailProduct(int id) {
    // TODO: implement detailProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> updateProduct(
      int id, String name, String description, String imageUrl, int price) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
