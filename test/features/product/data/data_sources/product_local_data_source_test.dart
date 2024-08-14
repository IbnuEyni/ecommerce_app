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
    final tProductModel = ProductModel(
        id: 1,
        name: "name",
        description: "description",
        imageUrl: "imageUrl",
        price: 1);
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
}
