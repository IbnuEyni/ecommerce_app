// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:ecommerce_app/core/error/failure.dart';
// import 'package:ecommerce_app/core/util/input_converter.dart';
// import 'package:ecommerce_app/features/product/data/models/product_model.dart';
// import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
// import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
// import 'package:ecommerce_app/features/product/domain/usecases/detail_product.dart';
// import 'package:ecommerce_app/features/product/domain/usecases/get_all_products.dart';
// import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
// import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'product_bloc_test.mocks.dart';

// @GenerateMocks([
//   DetailProduct,
//   CreateProduct,
//   UpdateProduct,
//   DeleteProduct,
//   ListProducts,
//   InputConverter
// ])
// void main() {
//   late ProductBloc bloc;
//   late MockDetailProduct mockDetailProduct;
//   late MockCreateProduct mockCreateProduct;
//   late MockUpdateProduct mockUpdateProduct;
//   late MockDeleteProduct mockDeleteProduct;
//   late MockListProducts mockListProducts;
//   late MockInputConverter inputConverter;

//   setUp(() {
//     mockDetailProduct = MockDetailProduct();
//     mockCreateProduct = MockCreateProduct();
//     mockUpdateProduct = MockUpdateProduct();
//     mockDeleteProduct = MockDeleteProduct();
//     mockListProducts = MockListProducts();
//     inputConverter = MockInputConverter();

//     bloc = ProductBloc(mockDetailProduct, mockCreateProduct, mockUpdateProduct,
//         mockDeleteProduct, mockListProducts, inputConverter);
//   });

//   final tProduct = ProductModel(
//       id: 1,
//       name: 'name',
//       description: 'description',
//       imageUrl: 'imageUrl',
//       price: 1);
//   const tid = 1;

//   test('initial state should be Empty', () {
//     expect(bloc.state, equals(Empty()));
//   });

//   blocTest<ProductBloc, ProductState>(
//     'emits [Loading] when DetailProductBloc event is added',
//     build: () {
//       when(mockDetailProduct.call(DetailParams(id: tid)))
//           .thenAnswer((_) async => Right(tProduct));
//       return bloc;
//     },
//     act: (bloc) => bloc.add(DetailProductEvent(id: tid.toString())),
//     wait: const Duration(milliseconds: 500),
//     expect: () => [Loading(), Loaded(product: tProduct)],
//   );

//   blocTest<ProductBloc, ProductState>(
//     'emits [Loading, Error] when DetailProductBloc event is added and fails',
//     build: () {
//       when(mockDetailProduct.call(DetailParams(id: tid)))
//           .thenAnswer((_) async => Left(ServerFailure()));
//       return bloc;
//     },
//     act: (bloc) => bloc.add(DetailProductEvent(id: tid.toString())),
//     wait: const Duration(milliseconds: 500),
//     expect: () => [Loading(), Error(message: 'Server Failure')],
//   );
// }
