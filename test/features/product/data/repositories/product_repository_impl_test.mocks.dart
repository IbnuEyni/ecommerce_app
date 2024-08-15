// Mocks generated by Mockito 5.4.4 from annotations
// in ecommerce_app/test/features/product/data/repositories/product_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:ecommerce_app/core/network/network_info.dart' as _i6;
import 'package:ecommerce_app/features/product/data/data_sources/product_local_data_source.dart'
    as _i5;
import 'package:ecommerce_app/features/product/data/data_sources/product_remote_data_source.dart'
    as _i3;
import 'package:ecommerce_app/features/product/data/models/product_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProductModel_0 extends _i1.SmartFake implements _i2.ProductModel {
  _FakeProductModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductRemoteDataSource extends _i1.Mock
    implements _i3.ProductRemoteDataSource {
  MockProductRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ProductModel> createProduct(
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    int? price,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createProduct,
          [
            id,
            name,
            description,
            imageUrl,
            price,
          ],
        ),
        returnValue: _i4.Future<_i2.ProductModel>.value(_FakeProductModel_0(
          this,
          Invocation.method(
            #createProduct,
            [
              id,
              name,
              description,
              imageUrl,
              price,
            ],
          ),
        )),
      ) as _i4.Future<_i2.ProductModel>);

  @override
  _i4.Future<_i2.ProductModel> detailProduct(int? id) => (super.noSuchMethod(
        Invocation.method(
          #detailProduct,
          [id],
        ),
        returnValue: _i4.Future<_i2.ProductModel>.value(_FakeProductModel_0(
          this,
          Invocation.method(
            #detailProduct,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.ProductModel>);

  @override
  _i4.Future<_i2.ProductModel> updateProduct(
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    int? price,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProduct,
          [
            id,
            name,
            description,
            imageUrl,
            price,
          ],
        ),
        returnValue: _i4.Future<_i2.ProductModel>.value(_FakeProductModel_0(
          this,
          Invocation.method(
            #updateProduct,
            [
              id,
              name,
              description,
              imageUrl,
              price,
            ],
          ),
        )),
      ) as _i4.Future<_i2.ProductModel>);

  @override
  _i4.Future<void> deleteProduct(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.ProductModel>> listProducts() => (super.noSuchMethod(
        Invocation.method(
          #listProducts,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.ProductModel>>.value(<_i2.ProductModel>[]),
      ) as _i4.Future<List<_i2.ProductModel>>);
}

/// A class which mocks [ProductLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductLocalDataSource extends _i1.Mock
    implements _i5.ProductLocalDataSource {
  MockProductLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ProductModel> getLastProduct() => (super.noSuchMethod(
        Invocation.method(
          #getLastProduct,
          [],
        ),
        returnValue: _i4.Future<_i2.ProductModel>.value(_FakeProductModel_0(
          this,
          Invocation.method(
            #getLastProduct,
            [],
          ),
        )),
      ) as _i4.Future<_i2.ProductModel>);

  @override
  _i4.Future<List<_i2.ProductModel>> getCachedProducts() => (super.noSuchMethod(
        Invocation.method(
          #getCachedProducts,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.ProductModel>>.value(<_i2.ProductModel>[]),
      ) as _i4.Future<List<_i2.ProductModel>>);

  @override
  _i4.Future<void> cacheProduct(_i2.ProductModel? productToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheProduct,
          [productToCache],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> cacheProducts(List<_i2.ProductModel>? productsToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheProducts,
          [productsToCache],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
