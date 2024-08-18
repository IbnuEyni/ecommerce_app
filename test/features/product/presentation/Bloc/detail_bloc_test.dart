import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/util/input_converter.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/usecases/detail_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_bloc_test.mocks.dart';

@GenerateMocks([DetailProduct, InputConverter])
void main() {
  late DetailBloc detailBloc;
  late MockDetailProduct mockDetailProduct;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockDetailProduct = MockDetailProduct();
    mockInputConverter = MockInputConverter();

    detailBloc = DetailBloc(detailProduct: mockDetailProduct);
  });

  const tId = '1';
  final tProduct = ProductModel(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1.0);

  test('initial state should be Empty', () {
    expect(detailBloc.state, equals(DetailInitial()));
  });
  blocTest<DetailBloc, DetailState>(
    'emit [Loading, Loaded] when DetailProductEvent is added',
    build: () {
      when(mockDetailProduct.call(any))
          .thenAnswer((_) async => Right(tProduct));
      return detailBloc;
    },
    act: (bloc) => bloc.add(DetailProductEvent(id: tId.toString())),
    expect: () => [Loading(), Loaded(product: tProduct)],
  );

  blocTest<DetailBloc, DetailState>(
    'emit [Loading, Error] when getting data fails',
    build: () {
      when(mockDetailProduct.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      return detailBloc;
    },
    act: (bloc) => bloc.add(DetailProductEvent(id: tId)),
    expect: () => [
      Loading(),
      Error(message: 'SERVER_FAILURE_MESSAGE'),
    ],
  );
}
