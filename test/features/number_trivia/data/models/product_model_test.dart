import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
