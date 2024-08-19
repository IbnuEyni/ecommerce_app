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
  const tInvalidPrice = 'xyz';
  const tName = 'Test Product';
  const tDescription = 'Test Description';
  const tImageUrl = 'http://example.com/image.jpg';
  const tParsedPrice = 100.0;

  final tProduct = Product(
    id: tId,
    name: tName,
    description: tDescription,
    imageUrl: tImageUrl,
    price: tParsedPrice,
  );

  test('initial state should be CreateProductInitial', () {
    expect(createBloc.state, equals(CreateProductInitial()));
  });

  blocTest<CreateBloc, CreateState>(
    'emit [CreateProductError] when the Price is invalid',
    build: () {
      when(mockInputConverter.stringToUnsignedDouble(tInvalidPrice))
          .thenReturn(Left(InvalidInputFailure()));
      return createBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(
      name: tName,
      description: tDescription,
      price: tInvalidPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      CreateProductLoading(),
      CreateProductError(message: 'Invalid Price'),
    ],
  );

  blocTest<CreateBloc, CreateState>(
    'emit [CreateProductLoading, CreateProductLoaded] when the product is created successfully',
    build: () {
      when(mockInputConverter.stringToUnsignedDouble(tParsedPrice.toString()))
          .thenReturn(const Right(tParsedPrice));
      when(mockCreateProduct.call(any))
          .thenAnswer((_) async => Right(tProduct));
      return createBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(
      name: tName,
      description: tDescription,
      price: tParsedPrice.toString(),
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
      when(mockInputConverter.stringToUnsignedDouble(tParsedPrice.toString()))
          .thenReturn(const Right(tParsedPrice));
      when(mockCreateProduct.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return createBloc;
    },
    act: (bloc) => bloc.add(CreateProductEvent(
      name: tName,
      description: tDescription,
      price: tParsedPrice.toString(),
      imageUrl: tImageUrl,
    )),
    expect: () => [
      CreateProductLoading(),
      CreateProductError(message: 'Server Failure'),
    ],
  );
}
