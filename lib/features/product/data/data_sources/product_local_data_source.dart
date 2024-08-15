import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  /// Gets the cached [ProductModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheException] if no cached data is present.
  Future<ProductModel> getLastProduct();

  /// Gets the cached list of [ProductModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheException] if no cached data is present.
  Future<List<ProductModel>> getCachedProducts();

  /// Caches a single [ProductModel] to be used offline.
  ///
  /// Throws a [CacheException] if caching fails.
  Future<void> cacheProduct(ProductModel productToCache);

  /// Caches a list of [ProductModel] to be used offline.
  ///
  /// Throws a [CacheException] if caching fails.
  Future<void> cacheProducts(List<ProductModel> productsToCache);
}

const CACHED_PRODUCT = 'CACHED_PRODUCT';
const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ProductModel> getLastProduct() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCT);
    if (jsonString != null) {
      return Future.value(ProductModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonStringList = sharedPreferences.getStringList(CACHED_PRODUCTS);
    if (jsonStringList != null) {
      final products = jsonStringList
          .map((jsonString) => ProductModel.fromJson(json.decode(jsonString)))
          .toList();
      return Future.value(products);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProduct(ProductModel productToCache) {
    return sharedPreferences.setString(
        CACHED_PRODUCT, json.encode(productToCache.toJson()));
  }

  @override
  Future<void> cacheProducts(List<ProductModel> productsToCache) {
    final jsonStringList = productsToCache
        .map((product) => json.encode(product.toJson()))
        .toList();
    return sharedPreferences.setStringList(CACHED_PRODUCTS, jsonStringList);
  }
}
