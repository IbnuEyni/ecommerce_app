import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_products_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ListProducts usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = ListProducts(repository: mockProductRepository);
  });

  final tProductList = [
    Product(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1.0,
    ),
    Product(
      id: '2',
      name: 'name2',
      description: 'description2',
      imageUrl: 'imageUrl2',
      price: 20.0,
    ),
  ];
  test('should all products from the repository', () async {
    // Arrange
    when(mockProductRepository.listProducts())
        .thenAnswer((_) async => Right(tProductList));

    //act
    final result = await usecase(NoParams());

    //arrange
    expect(result, Right(tProductList));
    verify(mockProductRepository.listProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
