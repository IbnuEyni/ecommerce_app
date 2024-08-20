import 'package:ecommerce_app/features/product/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ButtonWidget Tests', () {
    testWidgets('ButtonWidget displays correct title',
        (WidgetTester tester) async {
      // Arrange
      const buttonTitle = 'Test Button';
      const isFilled = true;
      const buttonWidth = 100.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonWidget(
              title: buttonTitle,
              isFilled: isFilled,
              buttonWidth: buttonWidth,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(buttonTitle), findsOneWidget);
    });

    testWidgets('ButtonWidget triggers onPressed callback',
        (WidgetTester tester) async {
      // Arrange
      var wasPressed = false;
      const buttonTitle = 'Test Button';
      const isFilled = true;
      const buttonWidth = 100.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonWidget(
              title: buttonTitle,
              isFilled: isFilled,
              buttonWidth: buttonWidth,
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ButtonWidget));
      await tester.pumpAndSettle();

      // Assert
      expect(wasPressed, isTrue);
    });

    testWidgets('ButtonWidget has correct color when filled',
        (WidgetTester tester) async {
      // Arrange
      const buttonTitle = 'Test Button';
      const isFilled = true;
      const buttonWidth = 100.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonWidget(
              title: buttonTitle,
              isFilled: isFilled,
              buttonWidth: buttonWidth,
              onPressed: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      // Assert
      expect(decoration.color, const Color(0xff3F51F3));
    });

    testWidgets('ButtonWidget has correct border color when not filled',
        (WidgetTester tester) async {
      // Arrange
      const buttonTitle = 'Test Button';
      const isFilled = false;
      const buttonWidth = 100.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ButtonWidget(
              title: buttonTitle,
              isFilled: isFilled,
              buttonWidth: buttonWidth,
              onPressed: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      // Assert
      expect(decoration.border!.top.color, Colors.red);
    });
  });
}
