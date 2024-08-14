import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';

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
  Future<void> deleteProduct(
    int id,
  );
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> createProduct(int id, String name, String description,
      String imageUrl, int price) async {
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
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse('${Urls.baseUrl}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> detailProduct(int id) async {
    final response = await client.get(
      Uri.parse('${Urls.baseUrl}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(int id, String name, String description,
      String imageUrl, int price) async {
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
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
