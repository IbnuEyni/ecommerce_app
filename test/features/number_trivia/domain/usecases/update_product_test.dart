import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/number_trivia/domain/entities/product.dart';
import 'package:ecommerce_app/features/number_trivia/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/number_trivia/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late UpdateProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = UpdateProduct(repository: mockProductRepository);
  });

  final tid = 1;
  final tname = 'name';
  final tdescription = 'description';
  final timageUrl = 'imageUrl';
  final tprice = 10;

  final tProduct = Product(
    id: 1,
    name: 'name',
    description: 'description',
    imageUrl: 'imageUrl',
    price: 1,
  );

  test('update the product', () async {
    // Arrange
    when(mockProductRepository.updateProduct(any, any, any, any, any))
        .thenAnswer((_) async => Right(tProduct));
    //act
    final result = await usecase(
      UpdateParams(
        id: tid,
        name: tname,
        description: tdescription,
        imageUrl: timageUrl,
        price: tprice,
      ),
    );

    // Assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.updateProduct(
        tid, tname, tdescription, timageUrl, tprice));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
