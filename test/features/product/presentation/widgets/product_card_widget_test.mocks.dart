// Mocks generated by Mockito 5.4.4 from annotations
// in ecommerce_app/test/features/product/presentation/widgets/product_card_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_app/features/product/domain/entities/product.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

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

/// A class which mocks [Product].
///
/// See the documentation for Mockito's code generation for more information.
class MockProduct extends _i1.Mock implements _i2.Product {
  MockProduct() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#id),
        ),
      ) as String);

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  String get description => (super.noSuchMethod(
        Invocation.getter(#description),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#description),
        ),
      ) as String);

  @override
  String get imageUrl => (super.noSuchMethod(
        Invocation.getter(#imageUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#imageUrl),
        ),
      ) as String);

  @override
  double get price => (super.noSuchMethod(
        Invocation.getter(#price),
        returnValue: 0.0,
      ) as double);

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
      ) as List<Object?>);
}
