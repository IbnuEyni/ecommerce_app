import 'dart:convert';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';

import '../models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  /// Calls the endpoint to create a product.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> createProduct(
    String id,
    String name,
    String description,
    String imageUrl,
    double price,
  );

  /// Calls the endpoint to get a product.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> detailProduct(
    String id,
  );

  /// Calls the endpoint to update a product.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> updateProduct(
    String id,
    String name,
    String description,
    String imageUrl,
    double price,
  );

  /// Calls the endpoint to delete a product.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> deleteProduct(
    String id,
  );

  /// Calls the endpoint to fetch a list of products.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> listProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> createProduct(String id, String name, String description,
      String imageUrl, double price) async {
    final response = await client.post(
      Uri.parse(Urls.baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
      }),
    );

    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('${Urls.baseUrl}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> detailProduct(String id) async {
    final response = await client.get(
      Uri.parse('${Urls.baseUrl}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(String id, String name, String description,
      String imageUrl, double price) async {
    final response = await client.put(Uri.parse('${Urls.baseUrl}/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'name': name,
          'description': description,
          'imageUrl': imageUrl,
          'price': price,
        }));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> listProducts() async {
    final response = await client.get(
      Uri.parse(Urls.baseUrl),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['data'];
      return jsonList
          .map((jsonItem) => ProductModel.fromJson(jsonItem))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
