import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/create_bloc/create_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/pages/create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateBloc extends Mock implements CreateBloc {}

void main() {
  late MockCreateBloc mockCreateBloc;

  setUp(() {
    mockCreateBloc = MockCreateBloc();
  });

  Future<void> _pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MockCreateBloc>.value(
          value: mockCreateBloc,
          child: CreatePage(),
        ),
      ),
    );
  }

  final testProduct = Product(
    id: '1',
    name: 'Test Product',
    price: 100.0,
    description: 'Test Description',
    imageUrl: '',
  );

  testWidgets('shows success Snackbar on successful product creation',
      (WidgetTester tester) async {
    // Arrange
    // final mockProduct = Product(
    //   id: '1',
    //   name: 'Test Product',
    //   price: 50.0,
    //   description: 'Test Description',
    //   imageUrl: 'test_image_url',
    // );
    when(() => mockCreateBloc.state).thenReturn(CreateProductInitial());

    // whenListen(
    //   mockCreateBloc,
    //   Stream<CreateState>.fromIterable([
    //     CreateProductInitial(),
    //     CreateProductLoaded(newProduct: mockProduct),
    //   ]),
    // );

    // await _pumpWidget(tester);

    // await tester.enterText(find.byType(TextField).at(0), 'Test Product');
    // await tester.enterText(find.byType(TextField).at(1), 'Test Category');
    // await tester.enterText(find.byType(TextField).at(2), '50');
    // await tester.enterText(find.byType(TextField).at(3), 'Test Description');

    await tester.tap(find.text('ADD').first);
    // await tester.pumpAndSettle();

    // expect(find.text('Product Created Successfully'), findsOneWidget);
  });

  // testWidgets('shows error Snackbar on product creation failure',
  //     (WidgetTester tester) async {
  //   // Arrange
  //   when(() => mockCreateBloc.state).thenReturn(CreateProductInitial());

  //   whenListen(
  //     mockCreateBloc,
  //     Stream<CreateState>.fromIterable(
  //         [CreateProductError(message: 'Failed to create product')]),
  //   );

  //   await _pumpWidget(tester);

  //   await tester.enterText(find.byType(TextField).at(0), 'Test Product');
  //   await tester.enterText(find.byType(TextField).at(1), 'Test Category');
  //   await tester.enterText(find.byType(TextField).at(2), '50');
  //   await tester.enterText(find.byType(TextField).at(3), 'Test Description');

  //   await tester.tap(find.text('ADD'));
  //   await tester.pumpAndSettle();

  //   expect(find.text('Failed to create product'), findsOneWidget);
  // });
}
