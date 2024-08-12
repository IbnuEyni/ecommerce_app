import 'dart:convert';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tProductModel = ProductModel(
    id: 1,
    name: 'name',
    description: 'description',
    imageUrl: 'imageUrl',
    price: 1,
  );

  test(
    'should be a subclass of product entity',
    () async {
      //assert
      expect(tProductModel, isA<Product>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('product.json'));
          // act
          final result = ProductModel.fromJson(jsonMap);
          // assert
          expect(result, tProductModel);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          //act
          final result = tProductModel.toJson();

          //assert
          final expectedMap = {
            "id": 1,
            "name": "name",
            "description": "description",
            "imageUrl": "imageUrl",
            "price": 1
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
