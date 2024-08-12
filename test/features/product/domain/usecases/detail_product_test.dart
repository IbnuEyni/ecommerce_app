import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/detail_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late DetailProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = DetailProduct(repository: mockProductRepository);
  });

  final tid = 1;

  final tProduct = Product(
      id: 1,
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1);

  test('should get product details for the id from the repository', () async {
    // Arrange
    when(mockProductRepository.detailProduct(any))
        .thenAnswer((_) async => Right(tProduct));

    //act
    final result = await usecase(DetailParams(id: tid));

    //arrange
    expect(result, Right(tProduct));
    verify(mockProductRepository.detailProduct(tid));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
