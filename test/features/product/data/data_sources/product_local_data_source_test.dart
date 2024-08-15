import 'dart:convert';

import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ProductLocalDataSourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastProduct', () {
    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product_cached.json')));

    test(
        'should return Product from SharedPrefernces when there is one in the cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('product_cached.json'));
      //act
      final result = await datasource.getLastProduct();
      //assert
      verify(mockSharedPreferences.getString(CACHED_PRODUCT));
      expect(result, equals(tProductModel));
    });

    test('should throw a CacheExeception when there is not a cached value',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = datasource.getLastProduct;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheProduct', () {
    final tProductModel = ProductModel.fromJson(
      json.decode(fixture('product_cached.json')),
    );
    test('should call SharedPreference to cache the data', () async {
      final expectedJsonString = json.encode(tProductModel.toJson());

      //arrange
      when(mockSharedPreferences.setString(CACHED_PRODUCT, expectedJsonString))
          .thenAnswer((_) async => true);
      //act
      datasource.cacheProduct(tProductModel);
      //assert
      verify(
          mockSharedPreferences.setString(CACHED_PRODUCT, expectedJsonString));
    });
  });

  group('getCachedProducts', () {
    final List<dynamic> jsonList = json.decode(fixture('cached_products.json'));
    final tProductModels =
        jsonList.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();

    test(
        'should return List<ProductModel> from SharedPreferences when there is a list of products in the cache',
        () async {
      final cachedProductJsonList =
          jsonList.map((jsonItem) => json.encode(jsonItem)).toList();
      //arrange
      when(mockSharedPreferences.getStringList(CACHED_PRODUCTS))
          .thenReturn(cachedProductJsonList);
      //act
      final result = await datasource.getCachedProducts();
      //assert
      verify(mockSharedPreferences.getStringList(CACHED_PRODUCTS));
      expect(result, equals(tProductModels));
    });

    test('should throw a CacheException when there is not a cached products',
        () async {
      when(mockSharedPreferences.getStringList(any)).thenReturn(null);

      //act
      final call = datasource.getCachedProducts;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheProducts', () {
    final List<dynamic> jsonList = json.decode(fixture('cached_products.json'));
    final tProductModels =
        jsonList.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
    final jsonStringList =
        tProductModels.map((product) => json.encode(product.toJson())).toList();

    test('should call SharedPreferences to cache the list of products',
        () async {
      //arrange
      when(mockSharedPreferences.setStringList(CACHED_PRODUCTS, jsonStringList))
          .thenAnswer((_) async => true);
      //act
      final result = await datasource.cacheProducts(tProductModels);
      //assert
      verify(
          mockSharedPreferences.setStringList(CACHED_PRODUCTS, jsonStringList));
    });
  });
}
