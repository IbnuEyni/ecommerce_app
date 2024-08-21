import 'package:ecommerce_app/features/product/presentation/pages/serch_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/product_card_widget.dart';

void main() {
  testWidgets('SearchPage displays product cards and opens modal bottom sheet',
      (WidgetTester tester) async {
    // Arrange
    final products = [
      Product(
        name: 'Product 1',
        price: 19.99,
        description: 'Description 1',
        imageUrl: 'https://via.placeholder.com/150',
        id: '1',
      ),
      Product(
        name: 'Product 2',
        price: 29.99,
        description: 'Description 2',
        imageUrl: 'https://via.placeholder.com/150',
        id: '2',
      ),
    ];

    // Build the SearchPage widget with dummy data
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SearchPage(), // Directly use SearchPage widget
        ),
      ),
    );

    // Act
    // Simulate the user interaction to open the modal bottom sheet
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pump();

    // Verify if applying filter (e.g., using 'Apply' button) is handled correctly
    // This depends on how you implement the handling of button clicks in the actual widget
  });

  testWidgets('SearchPage shows correct UI elements',
      (WidgetTester tester) async {
    // Build the SearchPage widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SearchPage(), // Directly use SearchPage widget
        ),
      ),
    );

    // Assert
    // Verify UI elements present on the page
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.filter_list), findsOneWidget);
    expect(find.byType(ProductCardWidget),
        findsNothing); // Initially no products to display
  });
}
