import 'dart:io';

import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/detail_bloc/detail_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailBloc extends Mock implements DetailBloc {}

void main() {
  late MockDetailBloc mockDetailBloc;

  // setUpAll(() {
  //   // Register fallback values for any non-primitive type that the mock uses.
  //   registerFallbackValue<DetailState>(DetailInitial());
  //   registerFallbackValue<DetailEvent>(DetailProductEvent(id: '1'));
  // });

  setUp(() {
    mockDetailBloc = MockDetailBloc();
    HttpOverrides.global = null;
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailBloc>.value(
      value: mockDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testProduct = Product(
    id: '1',
    name: 'name',
    description: 'description',
    imageUrl: 'imageUrl',
    price: 10.0,
  );

  testWidgets('triggers state change from initial to loading',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockDetailBloc.state).thenReturn(DetailInitial());

    // Act
    await tester.pumpWidget(
      _makeTestableWidget(DetailPage(id: testProduct.id)),
    );

    // Assert
    expect(find.byType(TextField), findsOneWidget);

    // Simulate user interaction if necessary
    // await tester.enterText(find.byType(TextField), 'New York');

    // // Rebuild the widget to reflect changes
    // await tester.pump();

    // expect(find.text('New York'), findsOneWidget);
  });

  // testWidgets('should show progress indicator when state is loading',
  //     (WidgetTester) async {
  //   //arrange
  //   when(mockDetailBloc.state).thenReturn(DetailLoading());
  //   //act
  //   await WidgetTester.pumpWidget(
  //       _makeTestableWidget(const DetailPage(id: 'id')));
  //   //assert
  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

  // testWidgets('should show progress indicator when state is loading',
  //     (WidgetTester) async {
  //   //arrange
  //   when(mockDetailBloc.state).thenReturn(DetailLoaded(product: testProduct));
  //   //act
  //   await WidgetTester.pumpWidget(
  //       _makeTestableWidget(const DetailPage(id: '1')));
  //   //assert
  //   expect(find.byKey(const Key('Detail_product')), findsOneWidget);
  // });
}
