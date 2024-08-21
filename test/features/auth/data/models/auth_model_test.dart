import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tAuthUserModel = AuthUserModel(
    id: '123',
    email: 'test@test.com',
    name: 'John Doe',
    token: 'abc123',
  );

  group('fromJson', () {
    test('should return a valid model when JSON is correct', () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'id': '123',
        'email': 'test@test.com',
        'name': 'John Doe',
        'token': 'abc123',
      };

      // Act
      final result = AuthUserModel.fromJson(jsonMap);

      // Assert
      expect(result, tAuthUserModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final result = tAuthUserModel.toJson();

      // Assert
      final expectedMap = {
        'id': '123',
        'email': 'test@test.com',
        'name': 'John Doe',
        'token': 'abc123',
      };
      expect(result, expectedMap);
    });
  });
}
