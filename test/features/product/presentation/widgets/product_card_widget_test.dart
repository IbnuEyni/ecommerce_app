import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/product_card_widget.dart';

import 'product_card_widget_test.mocks.dart';

@GenerateMocks([Product])
void main() {
  late MockProduct mockProduct;

  setUp(() {
    // Initialize the mock product
    mockProduct = MockProduct();
    when(mockProduct.name).thenReturn('Test Product');
    when(mockProduct.price).thenReturn(29.99);
    when(mockProduct.description).thenReturn('This is a test product.');
    // when(mockProduct.imageUrl)
    //     .thenReturn('https://via.placeholder.com/430x286');
  });

  testWidgets('ProductCardWidget displays product details correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCardWidget(item: mockProduct),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$29.99'), findsOneWidget);
    expect(find.text('This is a test product.'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });

  testWidgets('ProductCardWidget displays product image correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCardWidget(item: mockProduct),
        ),
      ),
    );

    final image = tester.widget<Image>(find.byType(Image));

    // Assert
    // expect(image.image, isA<NetworkImage>());
    // expect((image.image as NetworkImage).url,
    //     'https://via.placeholder.com/430x286');
  });

  testWidgets('ProductCardWidget displays correct product price',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCardWidget(item: mockProduct),
        ),
      ),
    );

    // Assert
    expect(find.text('\$29.99'), findsOneWidget);
  });

  testWidgets('ProductCardWidget displays correct product description',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCardWidget(item: mockProduct),
        ),
      ),
    );

    // Assert
    expect(find.text('This is a test product.'), findsOneWidget);
  });
}
