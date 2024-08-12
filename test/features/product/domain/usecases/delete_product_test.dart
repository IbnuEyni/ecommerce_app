import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late DeleteProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = DeleteProduct(repository: mockProductRepository);
  });

  final tid = 1;

  test('should delete the product', () async {
    // Arrange
    when(mockProductRepository.deleteProduct(any))
        .thenAnswer((_) async => const Right(unit));

    //act
    final result = await usecase(DeleteParams(id: tid));

    //arrange
    expect(result, const Right(unit));
    verify(mockProductRepository.deleteProduct(tid));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
