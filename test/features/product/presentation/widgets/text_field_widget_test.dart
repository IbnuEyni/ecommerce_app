import 'package:ecommerce_app/features/product/presentation/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomTextField Widget Tests', () {
    testWidgets('CustomTextField displays the correct label',
        (WidgetTester tester) async {
      // Arrange
      const label = 'Test Label';
      final controller = TextEditingController();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(label, controller),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('CustomTextField accepts text input',
        (WidgetTester tester) async {
      // Arrange
      const label = 'Test Label';
      final controller = TextEditingController();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(label, controller),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Test Input');

      // Assert
      expect(controller.text, 'Test Input');
    });

    testWidgets('CustomTextField displays suffix icon if provided',
        (WidgetTester tester) async {
      // Arrange
      const label = 'Test Label';
      final controller = TextEditingController();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label,
              controller,
              suffixIcon: const Icon(Icons.visibility),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('CustomTextField sets the correct keyboard type',
        (WidgetTester tester) async {
      // Arrange
      const label = 'Test Label';
      final controller = TextEditingController();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label,
              controller,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));

      // Assert
      expect(textField.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('CustomTextField sets the correct maxLines',
        (WidgetTester tester) async {
      // Arrange
      const label = 'Test Label';
      final controller = TextEditingController();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label,
              controller,
              maxLines: 3,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));

      // Assert
      expect(textField.maxLines, 3);
    });

    testWidgets('CustomTextField has correct fill color',
        (WidgetTester tester) async {
      // Arrange
      const label = 'Test Label';
      final controller = TextEditingController();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(label, controller),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;

      // Assert
      expect(decoration.fillColor, Colors.grey[200]);
    });
  });
}
