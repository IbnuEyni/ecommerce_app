import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/create_bloc/create_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_bloc_test.mocks.dart';

@GenerateMocks([CreateProduct, InputConverter])
void main() {
  late CreateBloc createBloc;
  late MockCreateProduct mockCreateProduct;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockCreateProduct = MockCreateProduct();
    mockInputConverter = MockInputConverter();
    createBloc = CreateBloc(mockCreateProduct, mockInputConverter);
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

  final tProduct = Product(
    id: tParsedId,
    name: tName,
    description: tDescription,
    imageUrl: tImageUrl,
    price: tParsedPrice,
  );

  test('initial state should be CreateProductInitial', () {
    expect(createBloc.state, equals(CreateProductInitial()));
  });

  blocTest<CreateBloc, CreateState>(
    'emit [CreateProductError] when the ID is invalid',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tInvalidId))
          .thenReturn(Left(InvalidInputFailure()));
      return createBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(
      id: tInvalidId,
      name: tName,
      description: tDescription,
      price: tPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      CreateProductLoading(),
      CreateProductError(message: 'Invalid ID'),
    ],
  );

  blocTest<CreateBloc, CreateState>(
    'emit [CreateProductLoading, CreateProductLoaded] when the product is created successfully',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tId))
          .thenReturn(Right(tParsedId));
      when(mockInputConverter.stringToUnsignedInteger(tPrice))
          .thenReturn(Right(tParsedPrice));
      when(mockCreateProduct.call(any))
          .thenAnswer((_) async => Right(tProduct));
      return createBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      CreateProductLoading(),
      CreateProductLoaded(newProduct: tProduct),
    ],
  );

  blocTest<CreateBloc, CreateState>(
    'emit [CreateProductLoading, CreateProductError] when creating the product fails due to a server error',
    build: () {
      when(mockInputConverter.stringToUnsignedInteger(tId))
          .thenReturn(Right(tParsedId));
      when(mockInputConverter.stringToUnsignedInteger(tPrice))
          .thenReturn(Right(tParsedPrice));
      when(mockCreateProduct.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return createBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      CreateProductLoading(),
      CreateProductError(message: 'Server Failure'),
    ],
  );
}
