import 'package:ecommerce_app/features/product/presentation/widgets/number_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberCard Widget Tests', () {
    testWidgets('NumberCard displays the correct size',
        (WidgetTester tester) async {
      // Arrange
      const size = '41';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NumberCard(size: size),
          ),
        ),
      );

      // Assert
      expect(find.text(size), findsOneWidget);
    });

    testWidgets(
        'NumberCard has correct background color and text color when size is "41"',
        (WidgetTester tester) async {
      // Arrange
      const size = '41';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NumberCard(size: size),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final text = tester.widget<Text>(find.text(size));

      // Assert
      expect(decoration.color, const Color(0xff3F51F3));
      expect(text.style!.color, Colors.white);
    });

    testWidgets(
        'NumberCard has correct background color and text color when size is not "41"',
        (WidgetTester tester) async {
      // Arrange
      const size = '42';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NumberCard(size: size),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      final text = tester.widget<Text>(find.text(size));

      // Assert
      expect(decoration.color, Colors.white);
      expect(text.style!.color, Colors.black);
    });

    testWidgets('NumberCard has correct border color when size is "41"',
        (WidgetTester tester) async {
      // Arrange
      const size = '41';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NumberCard(size: size),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      // Assert
      expect(decoration.border!.top.color, const Color(0xff3F51F3));
    });

    testWidgets('NumberCard has correct border color when size is not "41"',
        (WidgetTester tester) async {
      // Arrange
      const size = '42';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NumberCard(size: size),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      // Assert
      expect(decoration.border!.top.color, Colors.white10);
    });
  });
}
