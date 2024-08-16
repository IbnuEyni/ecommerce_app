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
    deleteBloc = DeleteBloc(mockDeleteProduct, mockInputConverter);
  });

  const tId = '1';
  const tInvalidId = 'abc';
  const tParsedId = 1;

  test('initial state should be DeleteInitial', () {
    expect(deleteBloc.state, equals(DeleteInitial()));
  });

  blocTest<DeleteBloc, DeleteState>(
    'emit [DeleteProductError] when the ID is invalid',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tInvalidId))
          .thenReturn(Left(InvalidInputFailure()));
      return deleteBloc;
    },
    act: (bloc) => bloc.add(const DeleteProductEvent(id: tInvalidId)),
    expect: () => [
      DeleteProductLoading(),
      const DeleteProductError(message: 'Invalid ID'),
    ],
  );

  blocTest<DeleteBloc, DeleteState>(
    'emit [DeleteProductLoading, DeleteProductLoaded] when the product is deleted successfully',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tId))
          .thenReturn(Right(tParsedId));
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
      when(mockInputConverter.stringToUnsignedInteger(tId))
          .thenReturn(Right(tParsedId));
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
