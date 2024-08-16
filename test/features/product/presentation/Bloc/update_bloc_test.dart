import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/update_bloc/update_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_bloc_test.mocks.dart';

@GenerateMocks([UpdateProduct, InputConverter])
void main() {
  late UpdateBloc updateBloc;
  late MockUpdateProduct mockUpdateProduct;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockUpdateProduct = MockUpdateProduct();
    mockInputConverter = MockInputConverter();
    updateBloc = UpdateBloc(mockUpdateProduct, mockInputConverter);
  });

  const tId = '1';
  const tInvalidId = 'abc';
  const tPrice = '100';
  const tInvalidPrice = 'xyz';
  const tName = 'Test Product';
  const tDescription = 'Test Description';
  const tImageUrl = 'http://example.com/image.jpg';
  const tParsedId = 1;
  const tParsedPrice = 100;

  final tProduct = ProductModel(
      id: 1,
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1);

  test('initial state should be UpdateInitial', () {
    expect(updateBloc.state, equals(UpdateInitial()));
  });

  blocTest<UpdateBloc, UpdateState>(
    'emit [CreateProductError] when the ID is invalid',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tInvalidId))
          .thenReturn(Left(InvalidInputFailure()));
      return updateBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(
      id: tInvalidId,
      name: tName,
      description: tDescription,
      price: tPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      UpdateProductLoading(),
      UpdateProductError(message: 'Invalid ID'),
    ],
  );
  blocTest<UpdateBloc, UpdateState>(
    'emit [UpdateProductLoading, UpdateProductLoaded] when the product is updated successfully',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tId))
          .thenReturn(Right(tParsedId));
      when(mockInputConverter.stringToUnsignedInteger(tPrice))
          .thenReturn(Right(tParsedPrice));
      when(mockUpdateProduct.call(any))
          .thenAnswer((_) async => Right(tProduct));
      return updateBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      UpdateProductLoading(),
      UpdateProductLoaded(product: tProduct),
    ],
  );
  blocTest<UpdateBloc, UpdateState>(
    'emit [UpdateProductLoading, UpdateProductError] when updating the product fails due to a server error',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tId))
          .thenReturn(Right(tParsedId));
      when(mockInputConverter.stringToUnsignedInteger(tPrice))
          .thenReturn(Right(tParsedPrice));
      when(mockUpdateProduct.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return updateBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      UpdateProductLoading(),
      UpdateProductError(message: 'Server Failure'),
    ],
  );
}
