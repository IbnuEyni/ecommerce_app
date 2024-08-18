import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/list_products/list_products_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'list_products_bloc_test.mocks.dart';

@GenerateMocks([ListProducts])
void main() {
  late ListProductsBloc listProductsBloc;
  late MockListProducts mockListProducts;

  setUp(() {
    mockListProducts = MockListProducts();

    listProductsBloc = ListProductsBloc(mockListProducts);
  });

  final tProductsList = [
    Product(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 10.0,
        imageUrl: 'imageUrl1'),
    Product(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 20.0,
        imageUrl: 'imageUrl2'),
  ];

  test('initial state should be ListProductsInitial', () {
    expect(listProductsBloc.state, equals(ListProductsInitial()));
  });

  blocTest<ListProductsBloc, ListProductsState>(
    'emits [ListProductsLoading, ListProductsLoaded] when data is gotten successfully',
    build: () {
      when(mockListProducts(any)).thenAnswer((_) async => Right(tProductsList));
      return listProductsBloc;
    },
    act: (bloc) => bloc.add(ListEvent()),
    expect: () => [
      ListProductsLoading(),
      ListProductsLoaded(products: tProductsList),
    ],
    verify: (_) {
      verify(mockListProducts(NoParams()));
    },
  );

  blocTest<ListProductsBloc, ListProductsState>(
    'emits [ListProductsLoading, ListProductsError] when getting data fails',
    build: () {
      when(mockListProducts(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return listProductsBloc;
    },
    act: (bloc) => bloc.add(ListEvent()),
    expect: () => [
      ListProductsLoading(),
      ListProductsError(message: 'Server Failure'),
    ],
    verify: (_) {
      verify(mockListProducts(NoParams()));
    },
  );
}
