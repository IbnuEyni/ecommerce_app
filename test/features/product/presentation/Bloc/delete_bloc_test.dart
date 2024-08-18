import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_bloc_test.mocks.dart';

@GenerateMocks([DeleteProduct, InputConverter])
void main() {
  late DeleteBloc deleteBloc;
  late MockDeleteProduct mockDeleteProduct;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockDeleteProduct = MockDeleteProduct();
    mockInputConverter = MockInputConverter();
    deleteBloc = DeleteBloc(mockDeleteProduct);
  });
  const tId = '1';

  test('initial state should be DeleteInitial', () {
    expect(deleteBloc.state, equals(DeleteInitial()));
  });

  blocTest<DeleteBloc, DeleteState>(
    'emit [DeleteProductLoading, DeleteProductLoaded] when the product is deleted successfully',
    build: () {
      when(mockDeleteProduct.call(any))
          .thenAnswer((_) async => const Right(unit));
      return deleteBloc;
    },
    act: (bloc) => bloc.add(const DeleteProductEvent(id: tId)),
    expect: () => [
      DeleteProductLoading(),
      DeleteProductLoaded(),
    ],
  );

  blocTest<DeleteBloc, DeleteState>(
    'emit [DeleteProductLoading, DeleteProductError] when deleting the product fails due to a server error',
    build: () {
      when(mockDeleteProduct.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return deleteBloc;
    },
    act: (bloc) => bloc.add(const DeleteProductEvent(id: tId)),
    expect: () => [
      DeleteProductLoading(),
      const DeleteProductError(message: 'Server Failure'),
    ],
  );
}
