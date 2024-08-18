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
  const tInvalidPrice = 'xyz';
  const tName = 'Test Product';
  const tDescription = 'Test Description';
  const tImageUrl = 'http://example.com/image.jpg';
  const tParsedPrice = 100.0;

  final tProduct = ProductModel(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1.0);

  test('initial state should be UpdateInitial', () {
    expect(updateBloc.state, equals(UpdateInitial()));
  });

  blocTest<UpdateBloc, UpdateState>(
    'emit [UpdateProductError] when the Price is invalid',
    build: () {
      when(mockInputConverter.stringToUnsignedDouble(tInvalidPrice))
          .thenReturn(Left(InvalidInputFailure()));
      return updateBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tInvalidPrice,
      imageUrl: tImageUrl,
    )),
    expect: () => [
      UpdateProductLoading(),
      UpdateProductError(message: 'Invalid Price'),
    ],
  );
  blocTest<UpdateBloc, UpdateState>(
    'emit [UpdateProductLoading, UpdateProductLoaded] when the product is updated successfully',
    build: () {
      when(mockInputConverter.stringToUnsignedDouble(tParsedPrice.toString()))
          .thenReturn(const Right(tParsedPrice));
      when(mockUpdateProduct.call(any))
          .thenAnswer((_) async => Right(tProduct));
      return updateBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tParsedPrice.toString(),
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
      when(mockInputConverter.stringToUnsignedDouble(tParsedPrice.toString()))
          .thenReturn(Right(tParsedPrice));
      when(mockUpdateProduct.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return updateBloc;
    },
    act: (bloc) => bloc.add(UpdateProductEvent(
      id: tId,
      name: tName,
      description: tDescription,
      price: tParsedPrice.toString(),
      imageUrl: tImageUrl,
    )),
    expect: () => [
      UpdateProductLoading(),
      UpdateProductError(message: 'Server Failure'),
    ],
  );
}
