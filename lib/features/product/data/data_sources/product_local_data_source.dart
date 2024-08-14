import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  // Gets the cached [ProductModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [cacheException] if no cached data is present.
  Future<ProductModel> getLastProduct();
  Future<void> cacheProduct(ProductModel productToCache);
}

const CACHED_PRODUCT = 'CACHED_PRODUCT';

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
  Future<void> cacheProduct(ProductModel productToCache) {
    return sharedPreferences.setString(
        CACHED_PRODUCT, json.encode(productToCache.toJson()));
  }
}
