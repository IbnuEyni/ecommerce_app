import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/number_trivia/domain/entities/product.dart';
import 'package:ecommerce_app/features/number_trivia/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/number_trivia/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late CreateProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = CreateProduct(repository: mockProductRepository);
  });

  // final tNumber = 1;
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
      price: 1);

  test('create product', () async {
    // Arrange
    when(mockProductRepository.createProduct(any, any, any, any, any))
        .thenAnswer((_) async => Right(tProduct));
    //act
    final result = await usecase(
      CreateParams(
          id: tid,
          name: tname,
          description: tdescription,
          imageUrl: timageUrl,
          price: tprice),
    );

    // Assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.createProduct(
        tid, tname, tdescription, timageUrl, tprice));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
