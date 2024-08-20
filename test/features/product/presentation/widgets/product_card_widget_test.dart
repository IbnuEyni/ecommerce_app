// import 'package:ecommerce_app/features/product/domain/entities/product.dart';
// import 'package:ecommerce_app/features/product/presentation/widgets/product_card_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// class MockHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }
// void main() {
//   group('ProductCardWidget Tests', () {
//     testWidgets('ProductCardWidget displays product details correctly',
//         (WidgetTester tester) async {
//       // Arrange
//       var product = Product(
//         name: 'Test Product',
//         price: 29.99,
//         description: 'This is a test product.',
//         imageUrl: 'https://via.placeholder.com/430x286',
//         id: '',
//       );

//       // Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: ProductCardWidget(item: product),
//           ),
//         ),
//       );

//       // Assert
//       expect(find.text('Test Product'), findsOneWidget);
//       expect(find.text('\$29.99'), findsOneWidget);
//       expect(find.text('This is a test product.'), findsOneWidget);
//       expect(find.byType(Image), findsOneWidget);
//       expect(find.byIcon(Icons.star), findsOneWidget);
//       expect(find.text('4'), findsOneWidget);
//     });

//     testWidgets('ProductCardWidget displays product image correctly',
//         (WidgetTester tester) async {
//       // Arrange
//       final product = Product(
//         name: 'Test Product',
//         price: 29.99,
//         description: 'This is a test product.',
//         imageUrl: 'https://via.placeholder.com/430x286',
//         id: '',
//       );

//       // Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: ProductCardWidget(item: product),
//           ),
//         ),
//       );

//       final image = tester.widget<Image>(find.byType(Image));

//       // Assert
//       expect(image.image, isA<NetworkImage>());
//       expect((image.image as NetworkImage).url,
//           'https://via.placeholder.com/430x286');
//     });

//     testWidgets('ProductCardWidget displays correct product price',
//         (WidgetTester tester) async {
//       // Arrange
//       final product = Product(
//         name: 'Test Product',
//         price: 29.99,
//         description: 'This is a test product.',
//         imageUrl: 'https://via.placeholder.com/430x286',
//         id: '',
//       );

//       // Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: ProductCardWidget(item: product),
//           ),
//         ),
//       );

//       // Assert
//       expect(find.text('\$29.99'), findsOneWidget);
//     });

//     testWidgets('ProductCardWidget displays correct product description',
//         (WidgetTester tester) async {
//       // Arrange
//       final product = Product(
//         name: 'Test Product',
//         price: 29.99,
//         description: 'This is a test product.',
//         imageUrl: 'https://via.placeholder.com/430x286',
//         id: '',
//       );

//       // Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: ProductCardWidget(item: product),
//           ),
//         ),
//       );

//       // Assert
//       expect(find.text('This is a test product.'), findsOneWidget);
//     });
//   });
// }
