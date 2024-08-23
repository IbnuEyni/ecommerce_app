import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Calls the endpoint to create a product.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> createProduct(
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

  String ImageProvider(String imageUrl) {
    if (imageUrl.toLowerCase().endsWith('png')) {
      return 'png';
    } else if (imageUrl.toLowerCase().endsWith('jpg') ||
        imageUrl.toLowerCase().endsWith('jpeg')) {
      return 'jpeg';
    } else {
      throw UnsupportedError('Unsupported Image Format');
    }
  }

  @override
  Future<ProductModel> createProduct(
      String name, String description, String imageUrl, double price) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
    );
    request.fields.addAll({
      'name': name,
      'description': description,
      'price': price.toString(),
    });
    debugPrint('================================================$imageUrl');
    if (imageUrl.isNotEmpty) {
      String imageType = ImageProvider(imageUrl);
      request.files.add(await http.MultipartFile.fromPath('image', imageUrl,
          contentType: MediaType('image', imageType)));
    }

    final response = await request.send();
    debugPrint("\n\n\n\n $response");

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      debugPrint("\n\n\n $responseBody");
      return ProductModel.fromJson(json.decode(responseBody)['data']);
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
